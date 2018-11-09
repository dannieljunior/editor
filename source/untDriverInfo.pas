unit untDriverInfo;

interface

uses
  Windows, Classes, sysUtils, Forms, untEngeEnumerados;
Type
  TDriverInfo = class(TComponent)
    protected
      FParametros: TStrings;
      procedure SetParametros(vpTipoConexao: TTipoConexao); virtual;
    public
      constructor Create(vpTipoConexao: TTipoConexao);  virtual;
    published
      property Parametros: TStrings read FParametros write FParametros;
  end;

  TDriverInfoDevArt = class(TDriverInfo)
    protected
      procedure SetParametros(vpTipoConexao: TTipoConexao); override;
    public
      constructor Create(vpTipoConexao: TTipoConexao); override;
    published
      property Parametros: TStrings read FParametros write FParametros;
  end;

  TDriverFactory = class(TObject)
    public
      class function GetInstancia(vpTipoDriver: TTipoDriver; vpTipoConexao: TTipoConexao): TDriverInfo;
  end;



implementation

{ TDriverInfo }

constructor TDriverInfo.Create(vpTipoConexao: TTipoConexao);
begin
  FParametros := TStringList.Create();
  SetParametros(vpTipoConexao);
end;

procedure TDriverInfo.SetParametros(vpTipoConexao: TTipoConexao);
begin
  case vpTipoConexao of
    tcFirebird: begin //ok
      self.FParametros.Values['DriverName']    := 'Interbase';
      self.FParametros.Values['LibraryName']   := 'dbexpint.dll';
      self.FParametros.Values['getDriverFunc'] := 'getSQLDriverINTERBASE';
      self.FParametros.Values['VendorLib']     := 'GDS32.DLL';
    end;
    tcMSSQL: begin    //ok
      self.FParametros.Values['DriverName']    := 'SQLServer';
      self.FParametros.Values['LibraryName']   := 'dbexpsda.dll';
      self.FParametros.Values['getDriverFunc'] := 'getSQLDriverSQLServer';
      self.FParametros.Values['VendorLib']     := 'sqloledb.dll';
    end;
    tcOracle: begin   //ok
      self.FParametros.Values['DriverName']    := 'Oracle';
      self.FParametros.Values['LibraryName']   := 'dbexpora.dll';
      self.FParametros.Values['getDriverFunc'] := 'getSQLDriverORACLE';
      self.FParametros.Values['VendorLib']     := 'OCI.DLL';
    end;
  end;
end;

{ TDriverInfoDevArt }

constructor TDriverInfoDevArt.Create(vpTipoConexao: TTipoConexao);
begin
  FParametros := TStringList.Create();
  SetParametros(vpTipoConexao);
end;

procedure TDriverInfoDevArt.SetParametros(vpTipoConexao: TTipoConexao);
begin
  case vpTipoConexao of
    tcFirebird: begin    //ok
      self.FParametros.Values['DriverName']    := 'DevartInterBase';
      self.FParametros.Values['LibraryName']   := 'dbexpida.dll';
      self.FParametros.Values['getDriverFunc'] := 'getSQLDriverInterBase';
      self.FParametros.Values['VendorLib']     := ExtractFilePath(Application.ExeName) + 'fbclient.dll';
    end;
    tcMSSQL: begin     //ok
      self.FParametros.Values['DriverName']    := 'DevartSQLServer';
      self.FParametros.Values['LibraryName']   := 'dbexpsda.dll';
      self.FParametros.Values['getDriverFunc'] := 'getSQLDriverSQLServer';
      self.FParametros.Values['VendorLib']     := 'sqloledb.dll';
    end;
    tcOracle: begin
      self.FParametros.Values['DriverName']    := 'DevartOracleDirect'; // 'DevartOracle';    
      self.FParametros.Values['LibraryName']   := 'dbexpoda.dll';
      self.FParametros.Values['getDriverFunc'] := 'getSQLDriverORADirect';
      self.FParametros.Values['VendorLib']     := 'dbexpoda.dll';
    end;
  end;
end;

{ TDriverFactory }

class function TDriverFactory.GetInstancia(
  vpTipoDriver: TTipoDriver; vpTipoConexao: TTipoConexao): TDriverInfo;
begin
  case vpTipoDriver of
    (* Driver Nativo *)
    tdNativo:  result := TDriverInfo.Create(vpTipoConexao);
    (* Driver DevArt *)
    tdDevart:  result := TDriverInfoDevArt.Create(vpTipoConexao);
  end;
end;

end.
