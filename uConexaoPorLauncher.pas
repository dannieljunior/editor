unit uConexaoPorLauncher;

interface
uses
  Windows, SysUtils, Classes, Types, Forms, StrUtils, Dialogs, untEngeEnumerados;

  procedure  CarregarValoresPadroes(taAutenticar: TTipoAutenticacao);
  function  ValidarAutenticacao(taAutenticar: TTipoAutenticacao):Boolean;

implementation


procedure CarregarValoresPadroes(taAutenticar: TTipoAutenticacao);
begin
  if dtmRotinasGerais.Autenticador.TipoConexao = tcOracle then
  begin
    dtmRotinasGerais.SQLConnection.DriverName                            := 'DevartInterBase';
    dtmRotinasGerais.SQLConnection.LibraryName                           := 'dbexpida.dll';
    dtmRotinasGerais.SQLConnection.GetDriverFunc                         := 'getSQLDriverInterBase';
    dtmRotinasGerais.SQLConnection.VendorLib                             := ExtractFilePath(Application.ExeName) + 'GDS32.DLL';
    dtmRotinasGerais.SQLConnection.Params.Values['BlobSize']             := '-1';
    dtmRotinasGerais.SQLConnection.Params.Values['LocaleCode']           := '0000';
    dtmRotinasGerais.SQLConnection.Params.Values['OracleTransIsolation'] := '';
  end
  else
  begin
    if dtmRotinasGerais.Autenticador.TipoConexao = tcMSSQL then
    begin
      dtmRotinasGerais.SQLConnection.DriverName                           := 'Devart SQL Server';
      dtmRotinasGerais.SQLConnection.LibraryName                          := 'dbexpsda.dll';
      dtmRotinasGerais.SQLConnection.getDriverFunc                        := 'getSQLDriverSQLServer';
      dtmRotinasGerais.SQLConnection.VendorLib                            := ExtractFilePath(Application.ExeName) + 'sqloledb.dll';
      dtmRotinasGerais.SQLConnection.Params.Values['RoleName']            := 'RoleName';
      dtmRotinasGerais.SQLConnection.Params.Values['BlobSize']            := '-1';
      dtmRotinasGerais.SQLConnection.Params.Values['LongStrings']         := 'True';
      dtmRotinasGerais.SQLConnection.Params.Values['EnableBCD']           := 'True';
      dtmRotinasGerais.SQLConnection.Params.Values['FetchAll']            := 'True';
      dtmRotinasGerais.SQLConnection.Params.Values['ErrorResourceFile']   := '';
      dtmRotinasGerais.SQLConnection.Params.Values['LocaleCode']          := '0000';
      dtmRotinasGerais.SQLConnection.Params.Values['MSSQLTransIsolation'] := 'ReadCommited';
      dtmRotinasGerais.SQLConnection.Params.Values['OSAuthentication']    := 'False';
    end
    else
    begin
      if dtmRotinasGerais.Autenticador.TipoConexao = tcFirebird then
      begin
        dtmRotinasGerais.SQLConnection.DriverName                               := 'DevartInterBase';
        dtmRotinasGerais.SQLConnection.LibraryName                              := 'dbexpida.dll';
        dtmRotinasGerais.SQLConnection.getDriverFunc                            := 'getSQLDriverInterBase';
        dtmRotinasGerais.SQLConnection.VendorLib                                := ExtractFilePath(Application.ExeName) + 'GDS32.DLL';

        //falta tratar a conexao com o RI
        //dtmRotinasGerais.SQLConnection.Params.Values['DatabaseRI']              := Ini.ReadString('IBLOCAL', 'DatabaseRI', '');

        //Sérgio Vaz - 01/04/2016 a pedido do Sr. Paulo
        dtmRotinasGerais.SQLConnection.Params.Values['ServerCharSet']           := 'None';
        dtmRotinasGerais.SQLConnection.Params.Values['BlobSize']                := '-1';
        dtmRotinasGerais.SQLConnection.Params.Values['CommitRetain']            := 'False';
        dtmRotinasGerais.SQLConnection.Params.Values['ErrorResourceFile']       := '';
        dtmRotinasGerais.SQLConnection.Params.Values['LocaleCode']              := '0000';
        dtmRotinasGerais.SQLConnection.Params.Values['RoleName']                := 'RoleName';
        //Sérgio Vaz - 01/04/2016 a pedido do Sr. Paulo
        //ServerCharSet           := 'none';
        dtmRotinasGerais.SQLConnection.Params.Values['SQLDialect']              := '3';
        dtmRotinasGerais.SQLConnection.Params.Values['InterbaseTransIsolation'] := 'ReadCommited';
        dtmRotinasGerais.SQLConnection.Params.Values['WaitOnLocks']             := 'True';
      end;
    end;
  end;

  dtmRotinasGerais.Autenticador.TipoAutenticacao := taAutenticar;
  dtmRotinasGerais.Autenticador.Sistema := siNtcs;
  dtmRotinasGerais.Autenticador.Conexao := dtmRotinasGerais.SQLConnection;

  if taAutenticar = taLauncher then
  //  dtmRotinasGerais.Autenticador.StringAutenticacao := StrParams();
  else
  begin
    dtmRotinasGerais.Autenticador.StringAutenticacao := '';
//    dtmRotinasGerais.Autenticador.UsuarioId := '999998';
  end;

  ValidarAutenticacao(taAutenticar);
end;

function  ValidarAutenticacao(taAutenticar: TTipoAutenticacao):Boolean;
begin
  Result := True;

  if taAutenticar = taDebug then
  begin
    if dtmRotinasGerais.Autenticador.UsuarioDb = '' then
    begin
      ShowMessage('Informe o usuario do banco.' + #13 + #13 +
                  'Encerre o modo debug' + #13 + #13 +
                  'Corrija a propriedade UsuarioDb do componente EngeAutenticador');
      Result := False;
    end;
    if dtmRotinasGerais.Autenticador.SenhaDb = '' then
    begin
      ShowMessage('Informe a senha do banco' + #13 + #13 +
                  'Encerre o modo debug' + #13 + #13 +
                  'Corrija a propriedade SenhaDb do componente EngeAutenticador');
      Result := False;
    end;
    if dtmRotinasGerais.Autenticador.StringConexao = '' then
    begin
      ShowMessage('Informe a string de conexão' + #13 + #13 +
                  'Encerre o modo debug' + #13 + #13 +
                  'Corrija a propriedade StringConexao do componente EngeAutenticador');
      Result := False;
    end;
  end;
end;

end.
