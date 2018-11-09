unit untFormRestrito;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage;

type
  TfrmRestrito = class(TForm)
    Image2: TImage;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRestrito: TfrmRestrito;

implementation

{$R *.dfm}

procedure TfrmRestrito.Button1Click(Sender: TObject);
begin
  Self.Close();
end;

procedure TfrmRestrito.Image2Click(Sender: TObject);
begin
  self.Close();
end;

procedure TfrmRestrito.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(self.Handle, WM_SYSCOMMAND, 61458, 0) ;
end;

end.
