object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = #1057#1077#1088#1074#1077#1088
  ClientHeight = 333
  ClientWidth = 566
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 273
    Height = 313
    Caption = #1054#1085#1083#1072#1081#1085': 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object UsersListBox: TListBox
      Left = 16
      Top = 24
      Width = 241
      Height = 268
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 18
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 287
    Top = 8
    Width = 241
    Height = 145
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 39
      Height = 18
      Caption = #1055#1086#1088#1090':'
    end
    object PortEdit: TEdit
      Left = 61
      Top = 21
      Width = 124
      Height = 26
      TabOrder = 0
      Text = '1337'
    end
    object offbtn: TBitBtn
      Left = 16
      Top = 95
      Width = 169
      Height = 36
      Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100
      TabOrder = 1
      OnClick = offbtnClick
    end
    object onbtn: TBitBtn
      Left = 16
      Top = 53
      Width = 169
      Height = 36
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100
      TabOrder = 2
      OnClick = onbtnClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 287
    Top = 159
    Width = 241
    Height = 165
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1073#1086#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 60
      Height = 18
      Caption = #1050#1088#1077#1089#1090#1080#1082':'
    end
    object Label3: TLabel
      Left = 16
      Top = 56
      Width = 46
      Height = 18
      Caption = #1053#1086#1083#1080#1082':'
    end
    object Edit1: TEdit
      Left = 82
      Top = 24
      Width = 121
      Height = 26
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 82
      Top = 56
      Width = 121
      Height = 26
      TabOrder = 1
    end
    object Button1: TButton
      Left = 128
      Top = 88
      Width = 81
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 16
      Top = 88
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnAccept = ServerSocket1Accept
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    Left = 488
    Top = 48
  end
end
