unit Customers_Controller;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.JSON, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  CommonTypes, SQLQueries;

type
  TCustomersController = class
  private
    FQuery: TFDQuery;
    function IsValidJSON(const JText: String): Boolean;
    function IsValidGuid(const Guid: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Insert(const JText: String): TControllerResult;
    function Delete(const id: String): TControllerResult;
    function Update(const id, JText: String): TControllerResult;
    function Select(const id: String): TControllerResult;
  end;

implementation

uses
  QueryHelperClass, ConnectionModule;

constructor TCustomersController.Create;
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := DBModule.Connection;
end;

function TCustomersController.Delete(const id: String): TControllerResult;
Var
  Val: Integer;
begin
  if (ID = '') or (Length(id) <> 32) then
    Result.StatusCode := 400
  else
  begin
    FQuery.SQL.Text := Customers_Delete;
    FQuery.ParamByName('id').Value := ID;
    FQuery.ExecSQL;
    Result.StatusCode := 204;
  end;
end;

destructor TCustomersController.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

function TCustomersController.Insert(const JText: String): TControllerResult;
var
  JObject: TJSONObject;
  id: String;
begin
  if not IsValidJSON(JText) then
    Result.StatusCode := 400
  else
  begin
    JObject := TJSONObject(TJSONObject.ParseJSONValue(JText));
    try
      id := CreateGuid;
      FQuery.SQL.Text := Customers_Insert;
      FQuery.ParamByName('id').Value := id;
      FQuery.ParamByName('firstname').Value := JObject.GetValue<String>('firstname');
      FQuery.ParamByName('lastname').Value := JObject.GetValue<String>('lastname');
      FQuery.ParamByName('country').Value := JObject.GetValue<String>('country');
      FQuery.ExecSQL;
      JObject.AddPair('id', TJSONString.Create(id));
      Result.JSON := JObject.ToJSON;
      Result.StatusCode := 201;
    finally
      JObject.Free;
    end;
  end;
end;

function TCustomersController.IsValidGuid(const Guid: String): Boolean;
begin
  FQuery.SQL.Text := Customers_Select2;
  FQuery.ParamByName('id').Value := Guid;
  FQuery.Open();
  Result := not FQuery.IsEmpty;
end;

function TCustomersController.IsValidJSON(const JText: String): Boolean;
var
  JValue: TJSONValue;
begin
  JValue := TJSONObject.ParseJSONValue(JText);
  if (JValue is TJSONObject) or (JValue is TJSONArray) then
    Result := True;
  JValue.Free;
end;

function TCustomersController.Select(const id: String): TControllerResult;
begin
  if (ID <> '') and (Length(id) <> 32) then
    Result.StatusCode := 400
  else
  begin
    FQuery.SQL.Text := IfThen(ID = '', Customers_Select, Customers_Select2);
    if FQuery.FindParam('id') <> nil then
      FQuery.ParamByName('id').Value := id;
    FQuery.Open();
    Result.StatusCode := IfThen(FQuery.IsEmpty, '204', '200').ToInteger;
    Result.JSON := IfThen(id = '', FQuery.ToJSONArray, FQuery.ToJSONObject);
  end;
end;

function TCustomersController.Update(const id, JText: String): TControllerResult;
Var
  JObject: TJSONObject;
  FirstName, LastName, Country: String;
begin
  if (id = '') or (Length(id) <> 32) or (not IsValidJSON(JText)) or (not IsValidGuid(id)) then
    Result.StatusCode := 400
  else
  begin
    JObject := TJSONObject(TJSONObject.ParseJSONValue(JText));
    try
      FQuery.SQL.Text := Customers_Update;
      FQuery.ParamByName('id').Value := id;

      if not JObject.TryGetValue<String>('firstname', FirstName) then
        FQuery.SQL.Text := FQuery.SQL.Text.Replace(':firstname', 'firstname')
      else
        FQuery.ParamByName('firstname').Value := FirstName;

      if not JObject.TryGetValue<String>('lastname', LastName) then
        FQuery.SQL.Text := FQuery.SQL.Text.Replace(':lastname', 'lastname')
      else
        FQuery.ParamByName('lastname').Value := LastName;

      if not JObject.TryGetValue<String>('country', Country) then
        FQuery.SQL.Text := FQuery.SQL.Text.Replace(':country', 'country')
      else
        FQuery.ParamByName('country').Value := Country;

      FQuery.ExecSQL;
      JObject.AddPair('id', TJSONString.Create(id));
      Result.JSON := JObject.ToJSON;
      Result.StatusCode := 200;
    finally
      JObject.Free;
    end;
  end;
end;

end.
