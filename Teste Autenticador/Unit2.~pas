unit Unit2;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, untEngeAutenticador, Dialogs,
  IBDatabase;

type
  TDataModule2 = class(TDataModule)
    procedure AutenticadorAntesAutenticar(Sender: TObject);
    procedure AutenticadorDepoisAutenticar(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation

{$R *.dfm}

procedure TDataModule2.AutenticadorAntesAutenticar(Sender: TObject);
begin
  ShowMessage('Antes de autenticar');
end;

procedure TDataModule2.AutenticadorDepoisAutenticar(Sender: TObject);
begin
  ShowMessage('Após autenticar');
end;

end.
