unit QueryHelperClass;

interface

uses
  System.JSON, System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TFDQueryHelper = class helper for TFDQuery
    function ToJSONArray: String;
    function ToJSONObject: String;
  end;

implementation

{ TFDQueryHelper }

function TFDQueryHelper.ToJSONArray: String;
var
  JArray: TJSONArray;
begin
  JArray := TJSONArray.Create;
  try
    First;
    while not EOF do
    begin
      var JObj := TJSONObject.Create;
      for var Ind := 0 to FieldCount -1 do
        JObj.AddPair(Fields[Ind].FieldName, TJSONString.Create(Fields[Ind].AsString));
      JArray.Add(JObj);
      Next;
    end;
    Result := JArray.ToJSON;
  finally
    FreeAndNil(JArray);
  end;
end;

function TFDQueryHelper.ToJSONObject: String;
var
  JObject: TJSONObject;
  Ind: Integer;
begin
  JObject := TJSONObject.Create;
  try
    First;
    for Ind := 0 to FieldCount -1 do
      JObject.AddPair(Fields[Ind].FieldName, TJSONString.Create(Fields[Ind].AsString));
    Result := JObject.ToJSON;
  finally
    FreeAndNil(JObject);
  end;
end;

end.
