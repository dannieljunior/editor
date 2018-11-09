unit untEditorComponente;

interface

uses
  Classes, DesignIntf, DesignEditors, untEngeAutenticador;

type
  TEngeAutenticadorEditor=class(TComponentEditor)
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  const
    ANO:string = '2018';
    VERSAO = '2018.11.0';

  procedure Register;

implementation

procedure Register;
begin
  RegisterComponentEditor(TEngeAutenticador, TEngeAutenticadorEditor);
end;

{ TEngeAutenticadorEditor }

procedure TEngeAutenticadorEditor.ExecuteVerb(Index: Integer);
begin
  //do nothing...

end;

function TEngeAutenticadorEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: result := char(169) + ANO + ' Engegraph Sistemas';
    1: result := 'EngeLib. Versão: ' + VERSAO;
  end;
end;

function TEngeAutenticadorEditor.GetVerbCount: Integer;
begin
  result := 2;
end;

end.
