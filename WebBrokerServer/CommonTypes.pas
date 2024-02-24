unit CommonTypes;

interface

uses
  System.Classes,
  System.SysUtils;

type
  TControllerResult = record
    StatusCode: Integer;
    JSON: String;
  end;

function CreateGuid: String;

implementation

function CreateGuid: String;
begin
  Result := GuidToString(TGUID.NewGuid).ToLower.Replace('-', '').Replace('{', '').Replace('}', '');
end;

end.
