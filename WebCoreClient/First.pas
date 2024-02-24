unit First;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.StdCtrls, WEBLib.StdCtrls, Vcl.Controls,
  WEBLib.ExtCtrls, Types, Vcl.Grids, WEBLib.Grids, DB, WEBLib.DBCtrls,
  WEBLib.WebCtrls, WEBLib.Country, WEBLib.REST, WebLib.JSON;

type
  TForm1 = class(TWebForm)
    WebHTMLDiv1: TWebHTMLDiv;
    cmbCustomers: TWebComboBox;
    WebHTMLDiv2: TWebHTMLDiv;
    WebHTMLDiv3: TWebHTMLDiv;
    WebHTMLDiv4: TWebHTMLDiv;
    edtFirstName: TWebEdit;
    edtLastName: TWebEdit;
    WebHTMLDiv5: TWebHTMLDiv;
    btnUpdate: TWebButton;
    btnDelete: TWebButton;
    btnAdd: TWebButton;
    btnGet: TWebButton;
    btnCancel: TWebButton;
    btnSave: TWebButton;
    cmbCountry: TWebCountryComboBox;
    HttpRequest: TWebHttpRequest;
    procedure WebFormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cmbCustomersChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure HttpRequestRequestResponse(Sender: TObject;
      ARequest: TJSXMLHttpRequestRecord; AResponse: string);
  private
    { Private declarations }
    FURI: String;
    function GetId: String;
  public
    { Public declarations }
    procedure ViewerMode(const Mode: Boolean);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnAddClick(Sender: TObject);
begin
  edtFirstName.Clear;
  edtLastName.Clear;
  cmbCustomers.ItemIndex := 0;
  HttpRequest.URL := FURI;
  HttpRequest.Command := httpPost;
  ViewerMode(false);
end;

procedure TForm1.btnCancelClick(Sender: TObject);
begin
  HttpRequest.URL := FURI;
  HttpRequest.Command := httpGet;
  ViewerMode(true);
end;

procedure TForm1.btnDeleteClick(Sender: TObject);
begin
  MessageDlg('Silmek istiyor musunuz', mtConfirmation, [mbYes,mbNo],
    procedure(AValue: TModalResult)
    begin
      if AValue = mrYes then
      begin
        HttpRequest.URL := FURI + '/' + GetId;
        HttpRequest.Command := httpDelete;
        HttpRequest.Execute(
          procedure(AResponse: string; ARequest: TJSXMLHttpRequest)
          begin
            if ARequest.Status = 204 then
            begin
              cmbCustomers.Items.Delete(cmbCustomers.ItemIndex);
              ShowMessage('Ýþlem Baþarýlý');
              cmbCustomers.ItemIndex := 0;
              edtFirstName.Clear;
              edtLastName.Clear;
            end;
          end
        );
      end;
    end
  );
end;

procedure TForm1.btnGetClick(Sender: TObject);
var
  JArray: TJSONArray;
  JItem: TJSONObject;
  Ind: Integer;
  FullName, id: String;
begin
  HttpRequest.URL := FURI;
  HttpRequest.Command := httpGet;
  HttpRequest.Execute(
    procedure(AResponse: string; ARequest: TJSXMLHttpRequest)
    begin
      cmbCustomers.Clear;
      cmbCustomers.Items.AddPair('-- Customers List --', '');
      if ARequest.Status = 204 then
        ShowMessage('Ýçerik Yok')
      else
      begin
        JArray := TJSONArray(TJSONObject.ParseJSONValue(ARequest.responseText));
        for Ind := 0 to JArray.Count -1 do
        begin
          FullName := TJSONObject(JArray.Items[Ind]).GetValue('firstname').Value + ' ' + TJSONObject(JArray.Items[Ind]).GetValue('lastname').Value;
          id := TJSONObject(JArray.Items[Ind]).GetValue('id').Value;
          cmbCustomers.Items.AddPair(FullName, id);
        end;
      end;
    end
  );
end;

procedure TForm1.btnSaveClick(Sender: TObject);
var
  JObject: TJSONObject;
begin
  JObject := TJSONObject.Create;
  JObject.AddPair('firstname', TJSONString.Create(edtFirstName.Text));
  JObject.AddPair('lastname', TJSONString.Create(edtLastName.Text));
  JObject.AddPair('country', TJSONString.Create(cmbCountry.Text));

  HttpRequest.PostData := JObject.ToJSON;
  HttpRequest.Execute(
    procedure(AResponse: string; ARequest: TJSXMLHttpRequest)
    begin
      if ARequest.Status in [200, 201] then
        ShowMessage('Ýþlem Baþarýlý')
      else if ARequest.Status in [400..499] then
        ShowMessage('Ýstemci taraflý hata oluþtu')
      else if ARequest.Status >= 500 then
        ShowMessage('Sunucu taraflý hata oluþtu');
      ViewerMode(true);
    end
  );
end;

procedure TForm1.btnUpdateClick(Sender: TObject);
begin
  if cmbCustomers.ItemIndex = 0 then
    Exit;
  cmbCustomers.Enabled := False;
  HttpRequest.URL := FURI + '/' + GetId;
  HttpRequest.Command := httpPut;
  ViewerMode(false);
end;

procedure TForm1.cmbCustomersChange(Sender: TObject);
var
  JObject: TJSONObject;
begin
  if cmbCustomers.ItemIndex = 0 then
    Exit;
  HttpRequest.URL := FURI + '/' + GetId;
  HttpRequest.Command := httpGet;
  HttpRequest.Execute(
    procedure(AResponse: string; ARequest: TJSXMLHttpRequest)
    begin
      if ARequest.Status = 200 then
      begin
        JObject := TJSONObject(TJSONObject.ParseJSONValue(ARequest.responseText));
        try
          edtFirstName.Text := JObject.GetValue('firstname').Value;
          edtLastName.Text := JObject.GetValue('lastname').Value;
          cmbCountry.Text := JObject.GetValue('country').Value;
        finally
          JObject.Free;
        end;
      end
      else if ARequest.Status = 204 then
        ShowMessage('Ýçerik Yok')
      else if ARequest.Status in [400..499] then
        ShowMessage('Ýstemci taraflý hata oluþtu')
      else if ARequest.Status in [500..530] then
        ShowMessage('Sunucu taraflý hata oluþtu');
      ViewerMode(true);
    end
  );
end;

function TForm1.GetId: String;
begin
  if cmbCustomers.ItemIndex = 0 then
    Exit;
  Result := cmbCustomers.Values[cmbCustomers.ItemIndex];
end;

procedure TForm1.ViewerMode(const Mode: Boolean);
begin
  btnSave.Visible := not Mode;
  btnCancel.Visible := not Mode;
  btnAdd.Visible := Mode;
  btnUpdate.Visible := Mode;
  btnDelete.Visible := Mode;
  btnGet.Visible := Mode;
  cmbCustomers.Enabled := Mode;
end;

procedure TForm1.WebFormCreate(Sender: TObject);
begin
  FURI := window.location.protocol + '//' + window.location.host + '/api/customers';
  TJSHTMLElement(edtFirstName.ElementHandle)['placeholder'] := 'FirstName';
  TJSHTMLElement(edtLastName.ElementHandle)['placeholder'] := 'LastName';
  ViewerMode(true);
end;

procedure TForm1.HttpRequestRequestResponse(Sender: TObject;
  ARequest: TJSXMLHttpRequestRecord; AResponse: string);
begin
  TWebHttpRequest(Sender).PostData := '';
end;

end.
