program WebCoreClient;

uses
  Vcl.Forms,
  WEBLib.Forms,
  First in 'First.pas' {Form1: TWebForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
