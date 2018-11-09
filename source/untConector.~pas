unit untConector;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr,
  untEngeAutenticador, Forms, untEngeEnumerados,
  DBClient, IBCustomDataSet, IBQuery, IBDatabase,
  IBDatabaseInfo, untDriverInfo, untSgbd, Cripto;

type
  (* Modelo de conector Base *)
  TConector = class(TComponent)
  private
    FCripto: TCriptografa;
    FNomeConexao: string;
    FValido: boolean;
    FSqlLogin: string;
    FSgbd: TSGBD;
    function GetFirebirdInfo(): string;
  protected
    FCampoUsuario: string;
    FTabelaUsuario: string;
    FCampoLoginUsuario: string;
    FQuery: TSQlQuery;
    FAutenticador: TEngeAutenticador;
    FDriver: TDriverInfo;
    FServerCharSet: string;
    procedure ExtraiDLL;
    procedure CarregarPadroes; virtual;
    procedure Validar; virtual;
    procedure ConexaoSqlServer; virtual;
    procedure ConexaoFirebird; virtual;
    procedure ConexaoOracle; virtual;
    function LogarUsuario(): Boolean; virtual;
  public
    constructor Create(AOwner: TEngeAutenticador);  virtual;
    destructor  Destroy; virtual;
    procedure Conectar();
    function GetContext: string;
  published
    property Valido: boolean read FValido;
  end;

  { Notas }
  TConectorNotas = class(TConector)
  public
    constructor Create(AOwner: TEngeAutenticador); override;
    protected
      procedure ConexaoSqlServer; override;
      procedure ConexaoFirebird; override;
      procedure ConexaoOracle; override;
  end;

  { RC }
  TConectorRC = class(TConector)
  public
    constructor Create(AOwner: TEngeAutenticador); override;
    protected
      procedure ConexaoSqlServer; override;
      procedure ConexaoFirebird; override;
      procedure ConexaoOracle; override;
  end;

  { PROTESTO }
  TConectorProtesto = class(TConector)
  public
    constructor Create(AOwner: TEngeAutenticador); override;
    protected
      procedure ConexaoSqlServer; override;
      procedure ConexaoFirebird; override;
      procedure ConexaoOracle; override;
  end;

  { RTD }
  TConectorRTD = class(TConector)
  public
    constructor Create(AOwner: TEngeAutenticador); override;
    protected
      procedure ConexaoSqlServer; override;
      procedure ConexaoFirebird; override;
      procedure ConexaoOracle; override;
  end;

  { RI }
  TConectorRI = class(TConector)
  public
    constructor Create(AOwner: TEngeAutenticador); override;
    protected
      procedure ConexaoSqlServer; override;
      procedure ConexaoFirebird; override;
      procedure ConexaoOracle; override;
  end;

  (* Factory *)
  TConectorFactory = class(TObject)
  public
    class function GetInstancia(vpSistema: TSistema; vpAutenticador: TEngeAutenticador): TConector;
  end;


implementation
uses untUtils;

{$R launcher.res}

{ TConector }

procedure TConector.CarregarPadroes;
var
  sStringConexao: String;
  iPosDoisPontos: Integer;
begin
  try
  begin
    Validar();
    FValido := true;
  end
  Except
    on e: Exception do
    begin
      FValido := false;
      raise Exception.Create(e.Message);
    end;
  end;

  case Self.FAutenticador.TipoConexao of
    tcMSSQL: ConexaoSqlServer;
    tcFirebird: begin
      ConexaoFirebird;
      if(Self.FAutenticador.ExtrairDlls) then
        Self.ExtraiDLL;
    end;
    tcOracle: ConexaoOracle;
  end;
end;

procedure TConector.Conectar;
begin
  try
  begin
    CarregarPadroes();
    FAutenticador.Conexao.Params.Values['Password']  := FAutenticador.SenhaDb;
    FAutenticador.Conexao.Params.Values['User_Name'] := FAutenticador.UsuarioDb;
    FAutenticador.Conexao.LoginPrompt := False;
    FAutenticador.Conexao.Open();
    LogarUsuario();
  end
  except
    on e: Exception do
    begin
      Raise Exception.Create(e.message);
      FValido := False;
    end;
  end;
end;

procedure TConector.ConexaoFirebird;
var waitOnLocks: string;
begin
  FAutenticador.Conexao.Params.Values['RoleName']     := 'RoleName';
  FAutenticador.Conexao.Params.Values['BlobSize']     := '-1';
  FAutenticador.Conexao.Params.Values['CommitRetain'] := 'False';
  FAutenticador.Conexao.Params.Values['LocaleCode']   := '0000';
  FAutenticador.Conexao.Params.Values['SQLDialect']   := '3';

  if(FAutenticador.WaitOnLocks) then
    waitOnLocks := 'True'
  else
    waitOnLocks := 'False';

  FAutenticador.Conexao.Params.Values['WaitOnLocks'] := waitOnLocks;
  FAutenticador.Conexao.Params.Values['Interbase TransIsolation'] := 'ReadCommited';
  FAutenticador.Conexao.Params.Values['ErrorResourceFile'] := '';
  FAutenticador.Conexao.Params.Values['Trim Char'] := 'False';
  FAutenticador.Conexao.Params.Values['ServerCharSet'] := FServerCharSet;
  FAutenticador.Conexao.Params.Values['DataBase'] := FAutenticador.StringConexao;
end;

procedure TConector.ConexaoOracle;
begin

end;

procedure TConector.ConexaoSqlServer;
begin
  FAutenticador.Conexao.ConnectionName  := 'MSSQLConnection';
  FAutenticador.Conexao.LibraryName     := FDriver.Parametros.Values['LibraryName'];
  FAutenticador.Conexao.Params.Values['RoleName'] := 'RoleName';
  FAutenticador.Conexao.Params.Values['BlobSize'] := '-1';
  FAutenticador.Conexao.Params.Values['LongStrings'] := 'True';
  FAutenticador.Conexao.Params.Values['EnableBCD'] := 'True';
  FAutenticador.Conexao.Params.Values['FetchAll'] := 'True';
  FAutenticador.Conexao.Params.Values['ErrorResourceFile'] := '';
  FAutenticador.Conexao.Params.Values['LocaleCode'] := '0000';
  FAutenticador.Conexao.Params.Values['MSSQLTransIsolation'] := 'ReadCommited';
  FAutenticador.Conexao.Params.Values['OSAuthentication'] := 'False';
  FAutenticador.Conexao.Params.Values['HostName'] := FSgbd.Parametros.Values['HostName'];
  FAutenticador.Conexao.Params.Values['DataBase'] := FSgbd.Parametros.Values['DataBase'];
end;

constructor TConector.Create(AOwner: TEngeAutenticador);
begin
  FAutenticador := AOwner;
  FSgbd := TSGBD.Instancia(self.FAutenticador);
  FDriver := TDriverFactory.GetInstancia(AOwner.Driver, AOwner.TipoConexao);
  if(Assigned(FAutenticador.Conexao)) then
  begin
    FAutenticador.Conexao.Params.Clear();
    FAutenticador.Conexao.LoadParamsOnConnect := false;
  end;

  FSqlLogin   := 'SELECT * FROM ' + FTabelaUsuario +' WHERE ' + FCampoUsuario + ' = :' + FCampoUsuario;

  FCripto := TCriptografa.Create(self);
  FCripto.Key  := 'PescaMilagrosa';

end;

destructor TConector.Destroy;
begin
  self := nil;
  inherited Destroy;
end;

procedure TConector.ExtraiDLL;
var
  PathToSave: String;
  Res: TResourceStream;
begin
  try
    if(self.FAutenticador.TipoConexao = tcFirebird) then
    begin
        if FileExists(ExtractFilePath(Application.ExeName) + 'GDS32.DLL') then
        DeleteFile(ExtractFilePath(Application.ExeName) + 'GDS32.DLL');

        if FileExists(ExtractFilePath(Application.ExeName) + 'fbclient.DLL') then
          DeleteFile(ExtractFilePath(Application.ExeName) + 'fbclient.DLL');

        if FileExists(ExtractFilePath(Application.ExeName) + 'dbexpida.dll') then
          DeleteFile(ExtractFilePath(Application.ExeName) + 'dbexpida.dll');

        PathToSave := ExtractFilePath(Application.ExeName) + 'GDS32.dll';

        if not FileExists(PathToSave) then
        begin
          Res := TResourceStream.Create(Hinstance, 'FbClient25', 'DLLFILE');
          try
            Res.SavetoFile(PathToSave);
          finally
            Res.Free;
          end;
        end;

        PathToSave := ExtractFilePath(Application.ExeName) + 'fbclient.dll';
        if not FileExists(PathToSave) then
        begin
          if GetFirebirdInfo() = '1.5' then
            Res := TResourceStream.Create(Hinstance, 'FbClient15', 'DLLFILE')
          else
            Res := TResourceStream.Create(Hinstance, 'FbClient25', 'DLLFILE');
          try
            Res.SavetoFile(PathToSave);
          finally
            Res.Free;
          end;
        end;

        if(self.FAutenticador.Driver = tdDevart) then
        begin
          PathToSave := ExtractFilePath(Application.ExeName) + 'dbexpida.dll';
          if not FileExists(PathToSave) then
          begin
            Res := TResourceStream.Create(Hinstance, 'DevartInterBase', 'DLLFILE');
            try
              Res.SavetoFile(PathToSave);
            finally
              Res.Free;
            end;
          end;
        end;
    end
    else if(self.FAutenticador.TipoConexao = tcMsSql) then
    begin
      if(self.FAutenticador.Driver = tdDevart) then
      begin
        PathToSave := ExtractFilePath(Application.ExeName) + 'dbexpida.dll';
        if not FileExists(PathToSave) then
        begin
          Res := TResourceStream.Create(Hinstance, 'DevartSqlServer', 'DLLFILE');
          try
            Res.SavetoFile(PathToSave);
          finally
            Res.Free;
          end;
        end;
      end;
    end
    else if(self.FAutenticador.TipoConexao = tcOracle) then
    begin
      raise Exception.Create('Método extrair dlls não implementado para o Oracle.');
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao tentar extrair Dlls: ' + E.Message);
    end;
  end;
end;

procedure TConector.Validar;
begin
    if Trim(Self.FAutenticador.UsuarioDb) = EmptyStr then
    begin
      raise Exception.Create('Em modo debug, informe a propriedade "UsuarioDb" no componente de autenticação!');
    end;
    if Trim(Self.FAutenticador.SenhaDb) = EmptyStr then
    begin
      raise Exception.Create('Em modo debug, informe a propriedade "SenhaDb" no componente de autenticação!');
    end;
    if Trim(Self.FAutenticador.StringConexao) = EmptyStr then
    begin
      raise Exception.Create('Em modo debug: informe a propriedade "StringConexao" de conexão no componente de autenticação!');
    end;
    if Trim(Self.FAutenticador.UsuarioId) = '' then
    begin
      raise Exception.Create('Em modo debug, informe a propriedade "UsuarioId" no componente de autenticação!');
    end;
end;

function TConector.LogarUsuario: Boolean;
var usuarioAuditoria: string;
begin
  FQuery := TSqlQuery.Create(Self);
  try
  begin
    try
    begin
      FQuery.Close();
      FQuery.SQLConnection := FAutenticador.Conexao;
      FQuery.GetMetaData := false;
      FQuery.SQL.Text := FSqlLogin;
      FQuery.ParamCheck := true;
      FQuery.Params.ParamByName(FCampoUsuario).AsInteger := Round(strToFloat(FAutenticador.UsuarioId));
      FQuery.Open();
      if(FQuery.IsEmpty) then
        raise Exception.Create('Usuário inexistente no sistema!');

      usuarioAuditoria := FQuery.FieldByName(FCampoLoginUsuario).AsString;
      result := FAutenticador.UsuarioId = FQuery.FieldByName(FCampoUsuario).AsString;

      FSgbd.SetContext(self.FQuery.SQLConnection, FCripto.CriptoHexToText(usuarioAuditoria));

    end;
    except
      on e: Exception do
      begin
        raise Exception.Create('Erro ao tentar efetuar login no sistema: ' + e.message);
      end;
    end;
  end;
  Finally
    FreeandNil(FQuery);
  end
end;

function TConector.GetFirebirdInfo(): string;
VAR IBDatabase1: TIBDatabase;
    IBDatabaseInfo1: TIBDatabaseInfo;
    IBQuery: TIBQuery;
    IBTransaction: TIBTransaction;
begin
  IBDatabase1 := TIBDatabase.Create(Self);
  IBTransaction := TIBTransaction.Create(self);
  IBTransaction.DefaultDatabase := IBDatabase1;
  IBDatabaseInfo1 := TIBDatabaseInfo.Create(Self);
  IBQuery := TIBQuery.Create(Self);

  try
  begin
    IBDatabaseInfo1.Database := IBDatabase1;
    IBQuery.DataBase := IBDatabase1;
    IBDatabase1.DatabaseName := Self.FAutenticador.StringConexao;
    IBDatabase1.SQLDialect := 3;
    IBDatabase1.LoginPrompt := false;
    IBDatabase1.Params.Values['User_Name'] := Self.FAutenticador.UsuarioDb;
    IBDatabase1.Params.Values['Password'] := Self.FAutenticador.SenhaDb;
    IBDatabase1.Connected := True;

    IBTransaction.StartTransaction();
    IBQuery.Close();
    IBQuery.Sql.Add('SELECT RDB$CHARACTER_SET_NAME AS CHARSET FROM RDB$DATABASE');
    IBQuery.Open();

    if not (IBQuery.IsEmpty) then
      FServerCharSet := Trim(IBQuery.FieldByName('CHARSET').AsString)
    else
      FServerCharSet := 'NONE';

    if Pos('Firebird 1.5', IBDatabaseInfo1.Version) > 0 then
      Result := '1.5'
    else if Pos('Firebird 2.5', IBDatabaseInfo1.Version) > 0 then
      Result := '2.5'
    else
      Result := 'Indeterminada';
  end
  finally
    IBTransaction.Rollback();
    freeAndNil(IBTransaction);
    freeAndNil(IBDatabase1);
    freeAndNil(IBDatabaseInfo1);
    FreeAndNil(IBQuery);
  end;
end;

function TConector.GetContext: string;
var sgbd: TSGBD;
begin
  result := sgbd.Instancia(FAutenticador).GetContext(FAutenticador.Conexao);
end;

{ TConectorNotas }

procedure TConectorNotas.ConexaoFirebird;
begin
  inherited ConexaoFirebird();
  FAutenticador.Conexao.DriverName := FDriver.Parametros.Values['DriverName'];
  FAutenticador.Conexao.LibraryName := FDriver.Parametros.Values['LibraryName'];
  FAutenticador.Conexao.getDriverFunc := FDriver.Parametros.Values['getDriverFunc'];
  FAutenticador.Conexao.VendorLib := FDriver.Parametros.Values['VendorLib'];
end;

procedure TConectorNotas.ConexaoOracle;
begin
  raise Exception.Create('Conexão Oracle não implementada para este sistema');
end;

procedure TConectorNotas.ConexaoSqlServer;
begin
  FAutenticador.Conexao.DriverName := FDriver.Parametros.Values['DriverName'];
  FAutenticador.Conexao.LibraryName := FDriver.Parametros.Values['LibraryName'];
  FAutenticador.Conexao.getDriverFunc := FDriver.Parametros.Values['getDriverFunc'];
  FAutenticador.Conexao.VendorLib := FDriver.Parametros.Values['VendorLib'];
  inherited ConexaoSqlServer();
end;

constructor TConectorNotas.Create(AOwner: TEngeAutenticador);
begin
  FTabelaUsuario    := 'FUNCIONARIOS';
  FCampoUsuario     := 'CHAVE_FUNCIONARIOS';
  FNomeConexao      := 'NTCS';
  FCampoLoginUsuario := 'NOME';
  inherited Create(AOwner);
end;

{ TConectorFactory }

class function TConectorFactory.GetInstancia(vpSistema: TSistema; vpAutenticador: TEngeAutenticador): TConector;
begin
  case vpSistema of
    siProtesto: result := TConectorProtesto.Create(vpAutenticador);
    siRtd:      result := TConectorRTD.Create(vpAutenticador);
    siCivil:    result := TConectorRC.Create(vpAutenticador);
    siRics:     result := TConectorRI.Create(vpAutenticador);
    siNtcs:     result := TConectorNotas.Create(vpAutenticador);
  end
end;

{ TConectorRI }
procedure TConectorRI.ConexaoFirebird;
begin
  FAutenticador.Conexao.ConnectionName := FNomeConexao;
  FAutenticador.Conexao.DriverName := FDriver.Parametros.Values['DriverName'];
  FAutenticador.Conexao.Params.Values['DriverName'] := FDriver.Parametros.Values['DriverName'];
  FAutenticador.Conexao.Params.Values['LibraryName'] := FDriver.Parametros.Values['LibraryName'];
  FAutenticador.Conexao.LibraryName := FDriver.Parametros.Values['LibraryName'];
  FAutenticador.Conexao.VendorLib := FDriver.Parametros.Values['VendorLib'];
  FAutenticador.Conexao.GetDriverFunc := FDriver.Parametros.Values['getDriverFunc'];
  inherited ConexaoFirebird;
end;

procedure TConectorRI.ConexaoOracle;
var sgbd: TSGBD;
begin
  FAutenticador.Conexao.DriverName := FDriver.Parametros.Values['DriverName'];
  FAutenticador.Conexao.LibraryName := FDriver.Parametros.Values['LibraryName'];
  FAutenticador.Conexao.VendorLib := FDriver.Parametros.Values['VendorLib'];
  FAutenticador.Conexao.GetDriverFunc := FDriver.Parametros.Values['GetDriverFunc'];
  FAutenticador.Conexao.ConnectionName := FNomeConexao;
  FAutenticador.Conexao.Params.Values['BlobSize'] := '-1';
  FAutenticador.Conexao.Params.Values['ErrorResourceFile'] := '';
  FAutenticador.Conexao.Params.Values['HostName'] := FSgbd.Parametros.Values['HostName'];
  FAutenticador.Conexao.Params.Values['DataBase'] := FSgbd.Parametros.Values['DataBase'];
  FAutenticador.Conexao.Params.Values['Port'] := FSgbd.Parametros.Values['Port'];
  FAutenticador.Conexao.Params.Values['LocaleCode'] := '0000';
  FAutenticador.Conexao.Params.Values['Oracle TransIsolation'] := 'ReadCommitted';
  FAutenticador.Conexao.Params.Values['RoleName'] := 'Normal';
  FAutenticador.Conexao.Params.Values['LongStrings'] := 'True';
  FAutenticador.Conexao.Params.Values['EnableBCD'] := 'True';
  FAutenticador.Conexao.Params.Values['InternalName'] := 'True';
  FAutenticador.Conexao.Params.Values['FetchAll'] := 'False';
  FAutenticador.Conexao.Params.Values['CharLength'] := '0';
  FAutenticador.Conexao.Params.Values['Charset'] := '';
  FAutenticador.Conexao.Params.Values['UseQuoteChar'] := 'False';
  FAutenticador.Conexao.Params.Values['UseUnicode'] := 'True';
  inherited ConexaoOracle;
end;

procedure TConectorRI.ConexaoSqlServer;
begin
  FAutenticador.Conexao.ConnectionName  := FNomeConexao;
  FAutenticador.Conexao.VendorLib := FDriver.Parametros.Values['VendorLib'];
  FAutenticador.Conexao.DriverName := FDriver.Parametros.Values['DriverName'];
  FAutenticador.Conexao.LibraryName := FDriver.Parametros.Values['LibraryName'];
  FAutenticador.Conexao.GetDriverFunc := FDriver.Parametros.Values['getDriverFunc'];
  FAutenticador.Conexao.Params.Values['HostName'] := FSgbd.Parametros.Values['HostName'];
  FAutenticador.Conexao.Params.Values['DataBase'] := FSgbd.Parametros.Values['DataBase'];
end;

constructor TConectorRI.Create(AOwner: TEngeAutenticador);
begin
  FTabelaUsuario  := 'FUNCIONARIOS';
  FCampoUsuario   := 'CHAVE_FUNCIONARIOS';
  FCampoLoginUsuario := 'NOME';
  FDriver := TDriverFactory.GetInstancia(AOwner.Driver, AOwner.TipoConexao);
  inherited Create(AOwner);
  if(FAutenticador.TipoConexao = tcOracle) then
    FNomeConexao := 'Oracle'
  else
    FNomeConexao := 'IBLocal';
end;

{ TConectorRTD }

procedure TConectorRTD.ConexaoFirebird;
begin
  Inherited ConexaoFirebird();
  FAutenticador.Conexao.Params.Values['ServerCharSet'] := FServerCharSet;
end;

procedure TConectorRTD.ConexaoOracle;
begin
  Inherited ConexaoOracle();
end;

procedure TConectorRTD.ConexaoSqlServer;
begin
  inherited ConexaoSqlServer();
  FAutenticador.Conexao.Params.Values['DriverName'] := FDriver.Parametros.Values['DriverName'];
end;

constructor TConectorRTD.Create(AOwner: TEngeAutenticador);
begin
  FTabelaUsuario := 'USUARIOS';
  FCampoUsuario  := 'CHAVE_USUARIO';
  FNomeConexao   := 'RTD';
  FCampoLoginUsuario := 'LOGIN';
  inherited Create(AOwner);
end;

{ TConectorRC }

procedure TConectorRC.ConexaoFirebird;
begin
  FAutenticador.Conexao.Params.Values['ConnectionName'] := 'IBLocal';
  FAutenticador.Conexao.Params.Values['DriverName'] := FDriver.Parametros.Values['DriverName'];
  FAutenticador.Conexao.Params.Values['LibraryName'] := FDriver.Parametros.Values['LibraryName'];
  FAutenticador.Conexao.Params.Values['VendorLib'] := FDriver.Parametros.Values['VendorLib'];
  FAutenticador.Conexao.Params.Values['GetDriverFunc'] := FDriver.Parametros.Values['getDriverFunc'];
  inherited ConexaoFirebird;
  FAutenticador.Conexao.Params.Values['ServerCharSet'] := FServerCharSet;
end;

procedure TConectorRC.ConexaoOracle;
begin
  
end;

procedure TConectorRC.ConexaoSqlServer;
begin
  inherited;
end;

constructor TConectorRC.Create(AOwner: TEngeAutenticador);
begin
  FTabelaUsuario   := 'FUNCIONARIOS';
  FCampoUsuario := 'CHAVE_FUNCIONARIOS';
  FNomeConexao := 'RC';
  FCampoLoginUsuario := 'NOME';
  inherited Create(AOwner);
end;

{ TConectorProtesto }

procedure TConectorProtesto.ConexaoFirebird;
begin
  inherited;
  FAutenticador.Conexao.Params.Values['DriverName'] := FDriver.Parametros.Values['DriverName'];
  FAutenticador.Conexao.Params.Values['GetDriverFunc'] := FDriver.Parametros.Values['getDriverFunc'];
  FAutenticador.Conexao.Params.Values['LibraryName'] := FDriver.Parametros.Values['LibraryName'];
  FAutenticador.Conexao.Params.Values['LocaleCode'] := '0000';
  FAutenticador.Conexao.Params.Values['SQLDialect'] := '3';
  FAutenticador.Conexao.Params.Values['WaitOnLocks'] := 'True';
  FAutenticador.Conexao.Params.Values['Interbase TransIsolation'] := 'ReadCommited';
  FAutenticador.Conexao.Params.Values['ErrorResourceFile'] := '';
  FAutenticador.Conexao.Params.Values['Trim Char'] := 'False';
  FAutenticador.Conexao.Params.Values['ServerCharSet'] := FServerCharSet;
  FAutenticador.Conexao.Params.Values['Database'] := FAutenticador.StringConexao;
end;

procedure TConectorProtesto.ConexaoOracle;
begin
  raise Exception.Create('Conector Oracle não foi implementado para sistema de Protesto!');
end;

procedure TConectorProtesto.ConexaoSqlServer;
var DadosSqlServer: TStringList;
begin
  FAutenticador.Conexao.ConnectionName  := FNomeConexao;
  FAutenticador.Conexao.VendorLib := FDriver.Parametros.Values['VendorLib'];
  FAutenticador.Conexao.DriverName := FDriver.Parametros.Values['DriverName'];
  FAutenticador.Conexao.LibraryName := FDriver.Parametros.Values['LibraryName'];
  FAutenticador.Conexao.GetDriverFunc := FDriver.Parametros.Values['getDriverFunc'];

  try
    DadosSqlServer := TStringList.Create;
    FAutenticador.Conexao.Params.Values['HostName'] := FSgbd.Parametros.Values['HostName'];
    FAutenticador.Conexao.Params.Values['DataBase'] := FSgbd.Parametros.Values['DataBase'];
  finally
    DadosSqlServer.Free;
  end;
end;

constructor TConectorProtesto.Create(AOwner: TEngeAutenticador);
begin
  FNomeConexao   := 'PROTESTO';
  FTabelaUsuario := 'USUARIOS';
  FCampoUsuario  := 'CHAVE_USUARIO';
  FCampoLoginUsuario := 'LOGIN';
  Inherited Create(AOwner);
end;

end.
