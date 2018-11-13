unit untFormEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WPRuler, WPCTRRich, WPTbar, WPRTEDefs, WPCTRMemo;

type
  TfrmEditor = class(TForm)
    wpReguaH: TWPRuler;
    wpReguaV: TWPVertRuler;
    wpToolbar: TWPToolbar;
    WPRichText1: TWPRichText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditor: TfrmEditor;

implementation

{$R *.dfm}

end.
