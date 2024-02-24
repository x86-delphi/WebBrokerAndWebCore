object Form1: TForm1
  Width = 596
  Height = 266
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  ElementPosition = epIgnore
  OnCreate = WebFormCreate
  object WebHTMLDiv1: TWebHTMLDiv
    Left = 8
    Top = 16
    Width = 577
    Height = 41
    ElementPosition = epIgnore
    ElementFont = efCSS
    Role = ''
    object cmbCustomers: TWebComboBox
      Left = 0
      Top = 0
      Width = 577
      Height = 23
      Align = alClient
      ElementClassName = 'form-select'
      ElementFont = efCSS
      ElementPosition = epIgnore
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      Text = 'cmbCustomers'
      WidthPercent = 100.000000000000000000
      OnChange = cmbCustomersChange
      ItemIndex = -1
    end
  end
  object WebHTMLDiv2: TWebHTMLDiv
    Left = 8
    Top = 63
    Width = 577
    Height = 40
    ChildOrder = 1
    ElementPosition = epIgnore
    ElementFont = efCSS
    Role = ''
    object edtFirstName: TWebEdit
      Left = 0
      Top = 0
      Width = 577
      Height = 40
      Align = alClient
      ChildOrder = 1
      ElementClassName = 'form-control'
      ElementFont = efCSS
      ElementPosition = epIgnore
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      Required = True
      RequiredText = 'FirstName'
      WidthStyle = ssAuto
      WidthPercent = 100.000000000000000000
    end
  end
  object WebHTMLDiv3: TWebHTMLDiv
    Left = 8
    Top = 109
    Width = 577
    Height = 40
    ChildOrder = 2
    ElementPosition = epIgnore
    ElementFont = efCSS
    Role = ''
    object edtLastName: TWebEdit
      Left = 0
      Top = 0
      Width = 577
      Height = 40
      Align = alClient
      ChildOrder = 2
      ElementClassName = 'form-control'
      ElementFont = efCSS
      ElementPosition = epIgnore
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      Required = True
      RequiredText = 'LastName'
      WidthStyle = ssAuto
      WidthPercent = 100.000000000000000000
    end
  end
  object WebHTMLDiv4: TWebHTMLDiv
    Left = 8
    Top = 155
    Width = 577
    Height = 40
    ChildOrder = 3
    ElementPosition = epIgnore
    ElementFont = efCSS
    Role = ''
    object cmbCountry: TWebCountryComboBox
      Left = 0
      Top = 0
      Width = 577
      Height = 23
      Align = alClient
      ElementClassName = 'form-select'
      ElementFont = efCSS
      ElementPosition = epIgnore
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      ItemIndex = -1
    end
  end
  object WebHTMLDiv5: TWebHTMLDiv
    Left = 8
    Top = 208
    Width = 577
    Height = 41
    ElementID = 'button-group'
    HeightStyle = ssAuto
    WidthStyle = ssAuto
    ChildOrder = 4
    ElementPosition = epIgnore
    ElementFont = efCSS
    Role = ''
    object btnUpdate: TWebButton
      Left = 96
      Top = 0
      Width = 96
      Height = 41
      Align = alLeft
      Caption = 'G'#252'ncelle'
      ChildOrder = 1
      ElementClassName = 'btn btn-warning'
      ElementFont = efCSS
      ElementPosition = epIgnore
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      WidthStyle = ssAuto
      WidthPercent = 100.000000000000000000
      OnClick = btnUpdateClick
    end
    object btnDelete: TWebButton
      Left = 192
      Top = 0
      Width = 96
      Height = 41
      Align = alLeft
      Caption = 'Sil'
      ChildOrder = 2
      ElementClassName = 'btn btn-danger'
      ElementFont = efCSS
      ElementPosition = epIgnore
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      WidthStyle = ssAuto
      WidthPercent = 100.000000000000000000
      OnClick = btnDeleteClick
    end
    object btnAdd: TWebButton
      Left = 0
      Top = 0
      Width = 96
      Height = 41
      Align = alLeft
      Caption = 'Ekle'
      ElementClassName = 'btn btn-success'
      ElementFont = efCSS
      ElementPosition = epIgnore
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      WidthStyle = ssAuto
      WidthPercent = 100.000000000000000000
      OnClick = btnAddClick
    end
    object btnGet: TWebButton
      Left = 288
      Top = 0
      Width = 96
      Height = 41
      Align = alLeft
      Caption = 'Listele'
      ChildOrder = 3
      ElementClassName = 'btn btn-primary'
      ElementFont = efCSS
      ElementPosition = epIgnore
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      WidthStyle = ssAuto
      WidthPercent = 100.000000000000000000
      OnClick = btnGetClick
    end
    object btnCancel: TWebButton
      Left = 480
      Top = 0
      Width = 96
      Height = 41
      Align = alLeft
      Caption = 'Vazge'#231
      ChildOrder = 5
      ElementClassName = 'btn btn-warning'
      ElementFont = efCSS
      ElementPosition = epIgnore
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      Visible = False
      WidthStyle = ssAuto
      WidthPercent = 100.000000000000000000
      OnClick = btnCancelClick
    end
    object btnSave: TWebButton
      Left = 384
      Top = 0
      Width = 96
      Height = 41
      Align = alLeft
      Caption = 'Kaydet'
      ChildOrder = 4
      ElementClassName = 'btn btn-success'
      ElementFont = efCSS
      ElementPosition = epIgnore
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      Visible = False
      WidthStyle = ssAuto
      WidthPercent = 100.000000000000000000
      OnClick = btnSaveClick
    end
  end
  object HttpRequest: TWebHttpRequest
    OnRequestResponse = HttpRequestRequestResponse
    Left = 40
    Top = 72
  end
end
