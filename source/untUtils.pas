unit untUtils;

interface

uses classes, IdHashMessageDigest;

type
  TUtils = class(TObject)
  class procedure SplitStr(pString, pDelimitador: string; var pLista: TStringList);
  class function MD5(pString: string): string;
end;

implementation

{ TUtils }

class function TUtils.MD5(pString: string): string;
begin
  with TIdHashMessageDigest5.Create do
  try
      Result := HashStringAsHex(pstring);
  finally
      Free;
  end;
end;

class procedure TUtils.SplitStr(pString, pDelimitador: string; var pLista: TStringList);
var
  PosDel: integer;
  Aux: string;
begin
  Aux := pString;
    repeat
    PosDel := Pos(pDelimitador, Aux) - 1;
    if PosDel = -1 then
    begin
      pLista.Add(Aux);
      break;
    end;
    pLista.Add(copy(Aux, 1, PosDel));
    delete(Aux, 1, PosDel + Length(pDelimitador));
  until Aux = '';
end;

end.
