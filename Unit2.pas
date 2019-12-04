unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Win.ScktComp,
  Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.JSON;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    connecting_status: TLabel;
    nickname: TLabel;
    Panel2: TPanel;
    RichEdit1: TRichEdit;
    Panel3: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    ClientSocket1: TClientSocket;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Connecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    ClientUserName: RawByteString;
  end;

var
  Form2: TForm2;
  Connected: Boolean = False;
  MessageField: TRichEdit;
  MessageWriteField: TEdit;
  Connecting_Status: TLabel;
  Client: TClientSocket;

implementation

{$R *.dfm}

procedure ScrollToEnd(ARichEdit: TRichEdit);
var
  isSelectionHidden: Boolean;
begin
  with ARichEdit do
  begin
    SelStart := Perform( EM_LINEINDEX, Lines.Count, 0);//Set caret at end
    isSelectionHidden := HideSelection;
    try
      HideSelection := False;
      Perform( EM_SCROLLCARET, 0, 0);  // Scroll to caret
    finally
      HideSelection := isSelectionHidden;
    end;
  end;
end;

procedure addMessage(Who: String; Text: AnsiString);
var
  Title: string;
  CurrentTime: string;
begin
  Title := Who + ' (' + DateToStr(Date()) + ' ' + TimeToStr(Now()) + '):';
  MessageField.SelAttributes.Style := [fsBold];
  MessageField.Lines.Add(Title);
  MessageField.Lines.Add(Text);
  MessageField.Lines.Add('');
  ScrollToEnd(MessageField);
  MessageWriteField.Clear;
end;

function prepareRequest(UserName: string; Msg: AnsiString = ''): TJSONObject;
var
  JSONData: TJSONObject;
begin
  JSONData := TJSONObject.Create;
  JSONData.AddPair('username', UserName );
  JSONData.AddPair('message', Msg);
  prepareRequest := JSONData;
end;

procedure sendRequest(Data: TJSONObject);
begin
  Client.Socket.SendText(Data.ToString)
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  PreparedData: TJSONObject;
begin
  if (Connected = False ) OR (Text = '') then Exit;
  PreparedData := prepareRequest(ClientUserName, Edit1.Text);
  sendRequest(PreparedData);
  addMessage('Вы', Edit1.Text); 
end;

procedure TForm2.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  PreparedData: TJSONObject;  
begin
  connecting_status.Caption := '';
  PreparedData := prepareRequest(ClientUserName);
  sendRequest(PreparedData);
  Connected := True;
end;

procedure TForm2.ClientSocket1Connecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  connecting_status.Caption := 'Идёт подключение';
end;

procedure TForm2.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  connecting_status.Caption := 'Disconnected';
  Connected := False;
end;

procedure TForm2.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  connecting_status.Caption := 'Какая-то странная ошибка. Лучше позови Нурхата';
  Connected := False;
end;

procedure TForm2.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var
  StringMessage: string;
  Action: string;
  UserName: string;
  MessageFrom: string;
  JSONMessage: TJSONObject;
begin
  JSONMessage := TJSONObject.Create;
  StringMessage := Socket.ReceiveText;
  try
    JSONMessage.Parse(TEncoding.UTF8.GetBytes(StringMessage), 0);
    Action := JSONMessage.GetValue('action').Value;
    UserName := JSONMessage.GetValue('username').Value;
    MessageFrom := JSONMessage.GetValue('message').Value;
  finally
    JSONMessage.Free;
  end;
  addMessage(UserName, MessageFrom);
end;
procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
var
  PreparedData: TJSONObject;
begin
  if Ord(Key) = VK_RETURN then
  begin
    Button1.Click;
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Client.Socket.Close;
  Application.Terminate;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  Connecting_Status := connecting_status;
  MessageField := RichEdit1;
  MessageWriteField := Edit1;
  Client := ClientSocket1;

  nickname.Caption := ClientUserName;

  Client.Host := '207.180.208.165';
  Client.Port := 4141;
  Client.Active := True;
end;

end.
