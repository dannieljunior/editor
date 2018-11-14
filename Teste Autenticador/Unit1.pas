unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untEngeAutenticador, DB, SqlExpr, DBXpress, ExtCtrls, untEngeEnumerados,
  DBClient, SimpleDS, Grids, DBGrids, untEngeEditor;

type
  TForm1 = class(TForm)
    Panel: TPanel;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    SimpleDataSet1: TSimpleDataSet;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Button1: TButton;
    SQLConnection1: TSQLConnection;
    autenticador: TEngeAutenticador;
    EngeEditor1: TEngeEditor;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Erro(e: Exception);
    procedure autenticadorDepoisAutenticar(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Unit2;

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
var s: AnsiString;
    teste: string;
begin

      (*autenticador.Sistema := siRics;
      autenticador.TipoConexao := tcOracle;

      if(Trim(ParamStr(1)) <> EmptyStr) then
      begin
        ShowMessage(ParamStr(1));
        autenticador.StringAutenticacao := ParamStr(1);
        autenticador.TipoAutenticacao := taLauncher;
      end;

      autenticador.OnErro := Erro;
      try
      begin
         autenticador.Autenticar();
         if(autenticador.Autenticado) then
         begin
            //Panel1.Caption := 'Autenticado com sucesso!';
            Panel1.Color := clGreen;
            SimpleDataSet1.DataSet.CommandText := 'SELECT * FROM FUNCIONARIOS';
            SimpleDataSet1.Open;
         end;



      end
      except
        on e: Exception do
        begin
          ShowMessage(e.Message);
        end;
      end   *)

               EngeEditor1.Load(Panel1);


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Self.Close();
end;

procedure TForm1.Erro(e: Exception);
begin
  ShowMessage(e.Message);
  Panel1.Caption := 'Não Autenticado!' + #13 + 'Erro: ' + e.Message;
  Panel1.Color := clRed
end;

procedure TForm1.autenticadorDepoisAutenticar(Sender: TObject);
begin
  Panel1.Caption := 'Contexto: ' + autenticador.GetContext;
end;

end.

