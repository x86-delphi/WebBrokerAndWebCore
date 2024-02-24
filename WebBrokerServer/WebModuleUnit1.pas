unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp,
  System.IOUtils, System.Net.Mime, Customers_Controller;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FModulePath: String;
    FMimeTypes: TMimeTypes;
  public
    { Public declarations }
    function GetMimeType(const FileName: String): String;
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

uses
  ConnectionModule, CommonTypes;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function TWebModule1.GetMimeType(const FileName: String): String;
var
  MimeKind: TMimeTypes.TKind;
begin
  FMimeTypes.GetFileInfo(FileName, Result, MimeKind);
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  var FileName := TPath.Combine(FModulePath, TPath.GetFileName(Request.PathInfo));
  if TFile.Exists(FileName) then
  begin
    var Stream := TStringStream.Create;
    Stream.LoadFromFile(FileName);
    Response.ContentType := GetMimeType(TPath.GetFileName(FileName)) + ';charset="UTF-8"';
    Response.ContentStream := Stream;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  CustomersController: TCustomersController;
  ControllerResult: TControllerResult;
begin
  if Request.MethodType in [mtGet, mtPost, mtPut, mtDelete] then
  begin

    CustomersController := TCustomersController.Create;
    try
      var ActionPath := TWebActionItem(Sender).PathInfo.Replace('*', '');
      var id := Request.PathInfo.Replace(ActionPath, '').Replace('/', '');

      case Request.MethodType of
        mtGet:
          ControllerResult := CustomersController.Select(id);

        mtPut:
          ControllerResult := CustomersController.Update(id, Request.Content);

        mtPost:
          ControllerResult := CustomersController.Insert(Request.Content);

        mtDelete:
          ControllerResult := CustomersController.Delete(id);
      end;

      Response.ContentType := 'application/json';
      Response.StatusCode := ControllerResult.StatusCode;
      Response.ContentStream := TStringStream.Create(ControllerResult.JSON);
    finally
      CustomersController.Free;
    end;

  end
  else
    Response.StatusCode := 405;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  FModulePath := TPath.GetDirectoryName(GetModuleName(HInstance));
  FMimeTypes := TMimeTypes.Create;
  FMimeTypes.AddDefTypes;

  DBModule := TDBModule.Create(nil);
end;

procedure TWebModule1.WebModuleDestroy(Sender: TObject);
begin
  FMimeTypes.Free;
  DBModule.Free;
end;

end.
