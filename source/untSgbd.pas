unit untSgbd;
(* ----------------------------------------------------------------
  Daniel Júnior (daniel.junior@engegraph.com.br)  em 29/10/2018
  Esta classe define comandos e tratativas especificas para um SGBD
 ----------------------------------------------------------------- *)

interface
uses
  Classes, DBXpress, SysUtils, SqlExpr, untEngeEnumerados, untEngeAutenticador;
type
  (* Modelo de conector Base *)
  TSGBD = class (TComponent)
  protected
    FSql: string;
    FParametros: TStrings;
    FOwner: TEngeAutenticador;
  public
    constructor Create(pOwner: TEngeAutenticador); virtual;
    class function Instancia(pAutenticador: TEngeAutenticador): TSGBD;
    procedure SetContext(pConexao: TSQLConnection; pUsuario: string); virtual;
    function GetContext(pConexao: TSQLConnection): string; virtual;
  published
    property Parametros: TStrings read FParametros write FParametros;
  end;

  {firebird}
  TFirebird = class(TSGBD)
  public
    procedure SetContext(pConexao: TSQLConnection; pUsuario: string);  override;
    function GetContext(pConexao: TSQLConnection): string; override;
  end;

  {Sql Server}
  TSqlServer = class(TSGBD)
  public
    constructor Create(pOwner: TEngeAutenticador); override;
    procedure SetContext(pConexao: TSQLConnection; pUsuario: string);  override;
    function GetContext(pConexao: TSQLConnection): string; override;
  end;

  {Oracle}
  TOracle = class(TSGBD)
  public
    constructor Create(pOwner: TEngeAutenticador); override;
    procedure SetContext(pConexao: TSQLConnection; pUsuario: string);  override;
    function GetContext(pConexao: TSQLConnection): string; override;
  end;

implementation
uses SimpleDS, untUtils, Math;

{ TFirebird }

function TFirebird.GetContext(pConexao: TSQLConnection): string;
begin
  FSql := 'SELECT RDB$GET_CONTEXT(''USER_SESSION'', ''USUARIOLOGADO'') FROM RDB$DATABASE';
  result := inherited GetContext(pConexao);
end;

procedure TFirebird.SetContext(pConexao: TSQLConnection; pUsuario: string);
begin
    FSql := 'SELECT RDB$SET_CONTEXT(''USER_SESSION'', ''USUARIOLOGADO'', ' + quotedStr(pUsuario) + ') FROM RDB$DATABASE';
    inherited SetContext(pConexao, pUsuario);
end;

{ TSqlServer }

constructor TSqlServer.Create(pOwner: TEngeAutenticador);
var strHost,
    strDatabase: string;
    lstAux: TStringList;
begin
  inherited Create(pOwner);
  lstAux := TStringList.Create;
  try
  begin
    TUtils.SplitStr(FOwner.StringConexao, ';', lstAux);
    TUtils.SplitStr(FOwner.StringConexao, ';', lstAux);
    strHost := Trim(lstAux[0]);
    strDatabase := Trim(lstAux[1]);
    lstAux.Clear;
    TUtils.SplitStr(strHost, '=', lstAux);
    TUtils.SplitStr(strDatabase, '=', lstAux);
    strHost := Trim(lstAux[1]);
    strDatabase := Trim(lstAux[3]);
    FParametros.Values['HostName'] := strHost;
    FParametros.Values['DataBase'] := strDatabase;
  end;
  finally
    lstAux.Free;
  end;
end;

function TSqlServer.GetContext(pConexao: TSQLConnection): string;
begin
  FSql := 'SELECT SESSION_CONTEXT(N''USUARIOLOGADO'')';
  result := inherited GetContext(pConexao);
end;

procedure TSqlServer.SetContext(pConexao: TSQLConnection;
  pUsuario: string);
begin
  FSql := 'EXEC sp_set_session_context ''USUARIOLOGADO'', '+ quotedStr(pUsuario) + ';';
  inherited SetContext(pConexao, pUsuario);
end;

{ TOracle }

constructor TOracle.Create(pOwner: TEngeAutenticador);
var strHost,
    strDatabase: string;
    lstAux: TStringList;
begin
  inherited Create(pOwner);
  lstAux := TStringList.Create;
  try
  begin
    TUtils.SplitStr(FOwner.StringConexao, '/', lstAux);
    strHost := Trim(lstAux[0]);
    strDatabase := Trim(lstAux[1]);
    lstAux.Clear;
    TUtils.SplitStr(strHost, ':', lstAux);
    TUtils.SplitStr(strDatabase, ':', lstAux);
    strHost := Trim(lstAux[0]);
    strDatabase := Trim(lstAux[2]);
    FParametros.Values['HostName'] := strHost;
    FParametros.Values['DataBase'] :=  Trim(lstAux[1]); // strDatabase;
    FParametros.Values['Port'] := Trim(lstAux[1]);
  end;
  finally
    lstAux.Free;
  end;
end;

function TOracle.GetContext(pConexao: TSQLConnection): string;
begin
  FSql := 'SELECT sys_context(''ENGEGRAPH_CTX'', ''USUARIOLOGADO'') FROM DUAL';
  result := inherited GetContext(pConexao);
end;

procedure TOracle.SetContext(pConexao: TSQLConnection; pUsuario: string);
var sqlSp : TSQLStoredProc;
begin
  if not Self.FOwner.UsaServicoAuditoria then
    exit;  
  sqlSp := TSQLStoredProc.Create(self);
  sqlsp.SQLConnection := pConexao;
  try
  begin
    with sqlSp do
    begin
      StoredProcName := 'setContextVariavel';
      ParamByName('pVariavel').AsString := 'USUARIOLOGADO';
      ParamByName('pValor').AsString := pUsuario;
      ExecProc;
    end;
  end;
  finally
  begin
    freeAndNil(sqlSp);
  end;
  end;
end;

{ TSGBD }

constructor TSGBD.Create(pOwner: TEngeAutenticador);
begin
  inherited Create(pOwner);
  FOwner := pOwner;
  FParametros := TStringList.Create;
end;

function TSGBD.GetContext(pConexao: TSQLConnection): string;
var sds: TSimpleDataSet;
begin
  if not Self.FOwner.UsaServicoAuditoria then
  begin
    result := 'NULL';
    exit;
  end;
  
  sds := TSimpleDataSet.Create(self);
  try
  begin
    sds.Connection := pConexao;
    sds.Close();
    sds.DataSet.CommandText := FSql;
    sds.Open;
    result := sds.Fields[0].AsString;
  end;
  finally
    freeandNil(sds);
  end;
end;

class function TSGBD.Instancia(pAutenticador: TEngeAutenticador): TSGBD;
begin
  case pAutenticador.TipoConexao of
    tcFirebird: result := TFirebird.Create(pAutenticador);
    tcMSSQL: result := TSqlServer.Create(pAutenticador);
    tcOracle: result := TOracle.Create(pAutenticador);
  end;
end;

procedure TSGBD.SetContext(pConexao: TSQLConnection; pUsuario: string);
var sds: TSimpleDataSet;
begin
  if not Self.FOwner.UsaServicoAuditoria then
    exit;
  sds := TSimpleDataSet.Create(self);
  try
  begin
    sds.Connection := pConexao;
    sds.Close();
    sds.DataSet.CommandText := FSql;
    sds.Open;
  end;
  finally
    freeandNil(sds);
  end;
end;

end.
