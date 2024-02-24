unit ConnectionModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat;

type
  TDBModule = class(TDataModule)
    Connection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DBModule: TDBModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TDBModule.DataModuleCreate(Sender: TObject);
begin
  Connection.Params.AddPair('Database', 'db.db');
  Connection.Params.AddPair('DriverID', 'SQLite');
  Connection.LoginPrompt := False;
  Connection.Open;
end;

end.
