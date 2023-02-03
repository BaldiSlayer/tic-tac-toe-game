unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.StdCtrls,
  Vcl.Buttons;

type
  PPacket = ^Packet; {��������� �� ������}
  Packet = record    {������ � ������� � ������������}
    Nick: string;
end;
//
//type
//  TBattle = record
//    playing_field: array [1 .. 9] of byte;
//    id: integer;
//    cross, zero: string;
//    Enabled: boolean;
//end;


type
  TMainForm = class(TForm)
    ServerSocket1: TServerSocket;
    UsersListBox: TListBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    PortEdit: TEdit;
    Label1: TLabel;
    offbtn: TBitBtn;
    onbtn: TBitBtn;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ServerSocket1Accept(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure onbtnClick(Sender: TObject);
    procedure offbtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  Stat = '������: ';
  Get_Nick_Cmd = 1000;

var
  MainForm: TMainForm;
  users_cnt: integer;
  playing_field: array [1 .. 9] of byte;

implementation

{$R *.dfm}

function Cheking(): byte;
var value: byte;
begin
  value := 0;
  if ((playing_field[1] = playing_field[4]) and ((playing_field[1] = playing_field[7]))) Then
    value := playing_field[1];

  if ((playing_field[2] = playing_field[5]) and ((playing_field[2] = playing_field[8]))) Then
    value := playing_field[2];

  if ((playing_field[3] = playing_field[6]) and ((playing_field[3] = playing_field[9]))) Then
    value := playing_field[3];

  if ((playing_field[1] = playing_field[2]) and ((playing_field[1] = playing_field[3]))) Then
    value := playing_field[1];

  if ((playing_field[4] = playing_field[5]) and ((playing_field[4] = playing_field[6]))) Then
    value := playing_field[4];

  if ((playing_field[7] = playing_field[8]) and ((playing_field[7] = playing_field[9]))) Then
    value := playing_field[7];

  if ((playing_field[1] = playing_field[5]) and ((playing_field[1] = playing_field[9]))) Then
    value := playing_field[1];

  if ((playing_field[3] = playing_field[5]) and ((playing_field[3] = playing_field[7]))) Then
    value := playing_field[1];


  if value <> 0 then
    Cheking := value;
end;

procedure SendTo(name, text: string);
var i: integer;
begin
  for i := 0 to MainForm.ServerSocket1.Socket.ActiveConnections - 1 do
    if (PPacket(MainForm.ServerSocket1.Socket.Connections[i].Data).Nick) = name Then
    begin
      MainForm.ServerSocket1.Socket.Connections[i].SendText(text);
    end;
end;

//����� �������
procedure ClientExit(Data: PPacket);
var i: Word;
begin
  //ShowMessage(Data^.Nick);
  {���� ��� � ������ � �������}
  for i := 0 to MainForm.UsersListBox.Items.Count - 1 do
    if (Data^.Nick = MainForm.UsersListBox.Items[i]) then
      begin
        MainForm.UsersListBox.Items.Delete(i);
        break;
      end;

  users_cnt := users_cnt - 1;
  MainForm.GroupBox1.Caption := '������: ' + IntToStr(users_cnt);
  Dispose(Data); {����������� ���������� ������}
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  Edit1.Clear;
  Edit2.Clear;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  SendTo(Edit1.Text, '99991' + Edit2.Text);
  SendTo(Edit2.Text, '99992' + Edit1.Text);

  Button1.Click;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  with MainForm do
    begin
      onbtn.Click;
    end;
  users_cnt := 0;
end;

procedure TMainForm.offbtnClick(Sender: TObject);
begin
  with MainForm do
    begin
      ServerSocket1.Close;
      offbtn.Enabled := False;
      onbtn.Enabled := True;
    end;
end;

procedure TMainForm.onbtnClick(Sender: TObject);
begin
  with ServerSocket1 do
    begin
      Port := StrToInt(PortEdit.Text);
      Open;
    end;
  with MainForm do
    begin
      onbtn.Enabled := False;
      offbtn.Enabled := True;
    end;
end;

procedure TMainForm.ServerSocket1Accept(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Socket.SendText(IntToStr(Get_Nick_Cmd));
end;

procedure TMainForm.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  ClientExit(PPacket(Socket.Data)); {������ ����������}
end;

procedure TMainForm.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var Msg, Text, old: string;
    Cmd, _Pos, i, case_, a, answer: integer;
    NewClient: PPacket;

begin
  Msg := Socket.ReceiveText; {������� ���������}
  Cmd := StrToInt(Copy(Msg, 1, 4));      {���������� ������ 4 �������. ������� ������� �� 4-� ��������}
  Delete(Msg, 1, 4);
  case cmd of
    1000: //���������� ������������
      begin
        {�������� ������ ��� ������ �������}
        New(NewClient);
        {���������� ��� ���}
        NewClient^.Nick := Msg;
        {��������� �� ������ (Data) ������ �������� ������� ����� �������� ������� ���������� ������� ������}
        Socket.Data := NewClient;
        MainForm.UsersListBox.Items.Add(Msg);
        users_cnt := users_cnt + 1;
        GroupBox1.Caption := '������: ' + IntToStr(users_cnt);
      end;
    5555: //��� ���
      begin
        //'' + IntToStr(i) + enemy_nick
        old := '5555' + Msg;

        case_ := StrToInt(Copy(Msg, 1, 1));
        Delete(Msg, 1, 1);

        i := StrToInt(Copy(Msg, 1, 1));
        Delete(Msg, 1, 1);

        if playing_field[i] = 0 then
        begin
          playing_field[i] := case_;

          a := Cheking();

          Delete(old, 7, length(old) - 6);
          SendTo(Msg, old);

          if a <> 0 then
          begin
            //(PPacket(Socket.Data))^.Nick, msg
            SendTo(Msg, '1001' + IntToStr(a));
            SendTo(((PPacket(Socket.Data))^.Nick), '1001' + IntToStr(a));
          end;
        end;
      end;
  end;
end;

end.
