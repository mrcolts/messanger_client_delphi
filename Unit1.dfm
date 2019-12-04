object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'Messanger | '#1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
  ClientHeight = 184
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 258
    Height = 27
    Caption = #1042#1093#1086#1076' '#1074' '#1091#1095#1077#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'HelveticaNeueCyr'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 12
    Top = 52
    Width = 258
    Height = 117
    TabOrder = 0
    object Label2: TLabel
      Left = 64
      Top = 22
      Width = 31
      Height = 12
      Caption = #1051#1086#1075#1080#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'HelveticaNeueCyr'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 64
      Top = 40
      Width = 121
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'HelveticaNeueCyr'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = Edit1KeyPress
    end
    object Button1: TButton
      Left = 76
      Top = 72
      Width = 89
      Height = 25
      Caption = #1042#1086#1081#1090#1080
      TabOrder = 1
      OnClick = Button1Click
    end
  end
end
