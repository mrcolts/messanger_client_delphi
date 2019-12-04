unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Unit2;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure openMainPage();
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  MainForm: TForm2;
begin
  if (Length(Edit1.Text) < 1) then
  begin
    MessageBox(Handle, 'Поле с логином не может быть пустым!', 'Внимание!',
      MB_OK + MB_ICONWARNING);
    Exit;
  end;
  MainForm := TForm2.Create(self);
  MainForm.ClientUserName := AnsiToUtf8(Edit1.Text);
  MainForm.Show;
  Self.Hide;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = VK_RETURN then
  begin
    Button1.Click;
  end;
end;

end.
