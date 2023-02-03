unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  System.Win.ScktComp;

type
  TMainForm = class(TForm)
    ChatRichEdit: TRichEdit;
    MessageEdit: TEdit;
    SendButton: TButton;
    ClientSocket1: TClientSocket;
    procedure FormCreate(Sender: TObject);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  ID: string;

implementation

{$R *.dfm}

procedure TMainForm.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  if ErrorCode = 10061 then
    ShowMessage('Сервер выключен')
  else
    ShowMessage('Ошибка і = ' + IntToStr(ErrorCode));
  ErrorCode := 0;
end;

procedure TMainForm.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
var Msg: string;
    Cmd: integer;
begin
  Msg := Socket.ReceiveText; {Забрать сообщение}
  Cmd := StrToInt(Copy(Msg, 1, 4));      {Копировать первые 4 символа. Команда состоит из 4-х символов}
  Delete(Msg, 1, 4);
  case cmd of
    1000: //Добавление пользователя
      begin
        Socket.SendText('1000' + ID);
      end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  with MainForm do
    begin
      ChatRichEdit.Text := '';
      MessageEdit.Text := '';
      with ClientSocket1 do
        begin
          Port := 1337;
          Address := '127.0.0.1';
          Open;
        end;
      ID := '10101010102';
    end;
end;

end.
