unit untEngeAutenticador;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, msxmldom,
  XMLDoc, XMLIntf, untEngeEnumerados, Forms, IdCoderMIME, Dialogs;



type

  TOnAntesAutenticar = procedure(Sender: TObject) of object;
  TOnExibirAcessoRestrito = procedure(Sender: TObject) of object;
  TOnDepoisAutenticar = procedure(Sender: TObject) of object;
  TOnErro = procedure(e: Exception) of object;

  TEngeAutenticador = class(TComponent)
  private
    { Private declarations }
    FTipoAutenticacao: TTipoAutenticacao;
    FOnAntesAutenticar: TOnAntesAutenticar;
    FOnDepoisAutenticar: TOnDepoisAutenticar;
    FOnExibirAcessoRestrito: TOnExibirAcessoRestrito;
    FOnErro: TOnErro;
    FConexao: TSQLConnection;
    FStringAutenticacao: WideString;
    FStringXml: string;
    FSistema: TSistema;
    FWaitOnLocks: Boolean;
    FextrairDlls: Boolean;
    FDriver: TTipoDriver;
    FForm: TForm;

    //campos originados do xml
    FTipoConexao: TTipoConexao;
    FStringConexao: string;
    FUsuarioDb: string;
    FSenhaDb: string;
    FUsaServicoAuditoria: Boolean;

    //campos que ficarão expostos apoós a autenticação
    FUsuarioId: string; //originado do XML
    FLogin: string; 
    FSenha: string;
    FToken: string;
    function GetToken(): string;

  protected
    { Protected declarations }

    procedure SetConnection(const value: TSQLConnection);
    function GetAutenticado: Boolean;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); overload;
    procedure Autenticar;
    function GetContext: string;
    procedure ExibeAcessoRestrito();

    property Form: TForm read FForm write FForm;
  published
    { Published declarations }
    property TipoAutenticacao: TTipoAutenticacao read FTipoAutenticacao write FTipoAutenticacao;
    property Conexao: TSQLConnection read FConexao write SetConnection;
    property StringAutenticacao: WideString read FStringAutenticacao write FStringAutenticacao;
    property Autenticado: Boolean read GetAutenticado;
    property Sistema: TSistema read FSistema write FSistema;

    //propriedades expostas para autenticação em debug (sem uso do launcher/ desenvolvedor)
    property TipoConexao: TTipoConexao read FTipoConexao write FTipoConexao;
    property StringConexao: string read FStringConexao write FStringConexao;
    property UsuarioDb: string read FUsuarioDb write FUsuarioDb;
    property SenhaDb: string read FSenhaDb write FSenhaDb;
    property WaitOnLocks: boolean read FWaitOnLocks write FWaitOnLocks;
    property ExtrairDlls: boolean read FextrairDlls write FextrairDlls;
    property Driver: TTipoDriver read FDriver write FDriver;
    //Eventos
    property OnAntesAutenticar: TOnAntesAutenticar read FOnAntesAutenticar write FOnAntesAutenticar;
    property OnDepoisAutenticar: TOnDepoisAutenticar read FOnDepoisAutenticar write FOnDepoisAutenticar;
    property OnExibirAcessoRestrito: TOnExibirAcessoRestrito read FOnExibirAcessoRestrito write FOnExibirAcessoRestrito;
    property OnErro: TOnErro read FOnErro write FOnErro;

    // Propriedades expostas após a autenticação
    property UsuarioId: string read FUsuarioId write FUsuarioId;
    property Login: string read FUsuarioId write FUsuarioId;
    property Senha: string read FUsuarioId write FUsuarioId;

    property UsaServicoAuditoria: Boolean read FUsaServicoAuditoria write FUsaServicoAuditoria;


  end;
const
    TOKEN: string = 'WN/3B]QxZUTY7~N&';

procedure Register;

implementation

uses
  untBase64, untConector, untUtils, untFormRestrito, IdBaseComponent, Math;

procedure Register;
begin
  RegisterComponents('EngeLib', [TEngeAutenticador]);
end;

{ TEngeAutenticador }

constructor TEngeAutenticador.Create(AOwner: TComponent);
begin
  inherited;
  Self.FWaitOnLocks := false;
end;

procedure TEngeAutenticador.Autenticar;
var
  dXml: TXMLDocument;
  i, j: Byte;
  node, ChildNode: IXmlNode;
  fXml: TstringList;
  sToken: string;
  conector: TConector;
begin
  FUsaServicoAuditoria := false; //por default, serviço de auditoria será desabilitado

  if ((Self.Autenticado) or (FConexao = nil)) then
    Exit;
  try
  begin
    if (Assigned(FOnAntesAutenticar)) then
      FOnAntesAutenticar(self);

    if(FTipoAutenticacao in [taLauncher]) then
    begin
      if (trim(FStringAutenticacao) = '') then
        raise Exception.Create('O sistema não recebeu os dados para autenticação do Launcher!');
      try
      begin
        FStringXml := Base64Decode(FStringAutenticacao);

        if(trim(FStringXml) = EmptyStr) then
          raise Exception.Create('Erro ao ler string de autenticação: Conversão de base64 não retornou os dados corretamente!');

        dXml := TXMLDocument.Create(self);

        dXml.LoadFromStream(TStringStream.Create(FStringXml));

        dXml.Active := True;

        for i := 0 to Pred(dXml.ChildNodes.Count) do
        begin
          node := dXml.ChildNodes[i];

          if (Assigned(node)) then
          begin
            if (node.NodeName = 'Login') then
            begin
              for j := 0 to Pred(node.ChildNodes.Count) do
              begin
                ChildNode := node.ChildNodes[j];

                if (Assigned(ChildNode)) then
                begin
                  if (ChildNode.NodeName = 'TipoConexao') then
                    FTipoConexao := TTipoConexao(ChildNode.NodeValue);
                  if (ChildNode.NodeName = 'StringConexao') then
                    FStringConexao := String(ChildNode.NodeValue);
                  if (ChildNode.NodeName = 'UsuarioDb') then
                    FUsuarioDb := String(ChildNode.NodeValue);
                  if (ChildNode.NodeName = 'SenhaDb') then
                    FSenhaDb := String(ChildNode.NodeValue);
                  if (ChildNode.NodeName = 'UsuarioId') then
                    FUsuarioId := String(ChildNode.NodeValue);
                  if (ChildNode.NodeName = 'Token') then
                    FToken := String(ChildNode.NodeValue);
                  if (ChildNode.NodeName = 'UsaServicoAuditoria') then
                      FUsaServicoAuditoria := UpperCase(String(ChildNode.NodeValue)) = 'TRUE';
                end;
              end;
            end;
          end;
        end;
      end;
      except
        on e: Exception do
        begin
          raise Exception.Create('Erro ao ler XML de autenticação: ' + e.message);
        end;
      end;

      //validação: credencial do token no XML

      sToken := GetToken();

      if(FToken <> sToken) then
        raise Exception.Create('Credenciais do launcher estão incorretas.');
    end;

    conector := TConectorFactory.GetInstancia(FSistema, Self);
    try
    begin
      try
      begin
        conector.Conectar();
      end;
      except
        on e:Exception do
        begin
          Raise Exception.Create('Erro ao tentar autenticar no sistema: ' + e.message);
        end;
      end;
    end;
    finally
      FreeAndNil(conector);
    end;

    if not Autenticado then
      raise Exception.Create('Os Dados de conexão com o banco de dados estão incorretos.');

    if Assigned(FOnDepoisAutenticar) then
      FOnDepoisAutenticar(self);
  end;
  except
    on e: Exception do
    begin
      FConexao.Close();
      if (Assigned(FOnErro)) then
        FOnErro(e)
      else
        raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TEngeAutenticador.SetConnection(const value: TSQLConnection);
begin
  if (value <> nil) then
    FConexao := value;
end;

function TEngeAutenticador.GetAutenticado: Boolean;
begin
  if (FConexao <> nil) then
    Result := FConexao.Connected
  else
    Result := False;
end;

function TEngeAutenticador.GetToken(): string;
begin
  result := TUtils.MD5(TOKEN + FormatDateTime('yyyyMMddHH', Now));
end;

procedure TEngeAutenticador.ExibeAcessoRestrito;
begin
  if(Assigned(FOnExibirAcessoRestrito)) then
    FOnExibirAcessoRestrito(self);

  FForm := TfrmRestrito.Create(self);
  try
    if(FForm <> nil) then
      FForm.Showmodal();
  finally
    freeAndNil(FForm);
  end;
end;

function TEngeAutenticador.GetContext: string;
var conector: TConector;
begin
  if((self.Conexao <> nil) and (self.Conexao.Connected)) then
  begin
    conector := TConectorFactory.GetInstancia(FSistema, Self);
    result := conector.getContext();
  end;
end;

end.
