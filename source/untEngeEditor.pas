unit untEngeEditor;

interface

uses
  Windows, Controls, Classes, untFormEditor;
type
  TEventoKeyDown =  procedure(Sender: TObject; var Key: Word; Shift: TShiftState) of object;

  TEngeEditor = class(TComponent)
  private
    FOnKeyDown: TEventoKeyDown;
    FEditor: TfrmEditor;
  public
    constructor Create(AOwner: TComponent); overload;
    procedure Load(pControl: TwinControl);
  protected

  published
    property OnKeyDown: TEventoKeyDown read FOnKeyDown write FOnKeyDown;
end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('EngeLib', [TEngeEditor]);
end;

{ TEngeEditor }

constructor TEngeEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TEngeEditor.Load(pControl: TwinControl);
begin
  FEditor := TfrmEditor.Create(pControl);
  //delegação dos eventos encapsulados
  if(assigned(FOnKeyDown)) then
      FEditor.OnKeyDown := FOnKeyDown;
  FEditor.Parent := pControl;
  FEditor.Align := alClient;
  FEditor.Show();
end;

end.
