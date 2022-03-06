object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1058#1077#1089#1090' '#1054#1054#1055
  ClientHeight = 554
  ClientWidth = 1002
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grp_Product: TGroupBox
    Left = 0
    Top = 0
    Width = 385
    Height = 554
    Align = alLeft
    Caption = #1055#1088#1086#1076#1091#1082#1094#1080#1103
    TabOrder = 0
    object gp_product: TGridPanel
      Left = 2
      Top = 15
      Width = 381
      Height = 537
      Align = alClient
      Caption = 'gp_product'
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = tv_Product
          Row = 0
        end
        item
          Column = 0
          Control = grp_Specifications
          Row = 1
        end
        item
          Column = 0
          Control = pnl_product_buy
          Row = 2
        end>
      RowCollection = <
        item
          Value = 70.126227208976160000
        end
        item
          Value = 29.873772791023840000
        end
        item
          SizeStyle = ssAbsolute
          Value = 30.000000000000000000
        end>
      TabOrder = 0
      object tv_Product: TTreeView
        Left = 1
        Top = 1
        Width = 379
        Height = 354
        Align = alClient
        Indent = 19
        ReadOnly = True
        TabOrder = 0
        OnChange = tv_ProductChange
      end
      object grp_Specifications: TGroupBox
        Left = 1
        Top = 355
        Width = 379
        Height = 150
        Align = alClient
        Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
        TabOrder = 1
        object mmo_Characteristics: TMemo
          Left = 2
          Top = 15
          Width = 375
          Height = 133
          Align = alClient
          Lines.Strings = (
            '')
          ReadOnly = True
          TabOrder = 0
        end
      end
      object pnl_product_buy: TPanel
        Left = 1
        Top = 505
        Width = 379
        Height = 30
        Align = alClient
        TabOrder = 2
        object lbl_PersonalPrise: TLabel
          Left = 1
          Top = 1
          Width = 255
          Height = 28
          Align = alClient
          AutoSize = False
          BiDiMode = bdLeftToRight
          Caption = #1055#1077#1088#1089#1086#1085#1072#1083#1100#1085#1072#1103' '#1094#1077#1085#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
          Layout = tlCenter
          ExplicitLeft = 56
          ExplicitTop = 16
          ExplicitWidth = 80
          ExplicitHeight = 13
        end
        object btn_buy: TButton
          Left = 256
          Top = 1
          Width = 122
          Height = 28
          Action = a_buy
          Align = alRight
          TabOrder = 0
        end
      end
    end
  end
  object pnl_Right: TPanel
    Left = 728
    Top = 0
    Width = 274
    Height = 554
    Align = alRight
    Caption = 'pnl_Right'
    TabOrder = 1
    object grp_cart: TGroupBox
      Left = 1
      Top = 73
      Width = 272
      Height = 480
      Align = alClient
      Caption = #1050#1086#1088#1079#1080#1085#1072
      TabOrder = 0
      object tv_cart: TTreeView
        Left = 2
        Top = 15
        Width = 268
        Height = 463
        Align = alClient
        Indent = 19
        ReadOnly = True
        TabOrder = 0
        OnChange = tv_ProductChange
      end
    end
    object grp_user: TGroupBox
      Left = 1
      Top = 1
      Width = 272
      Height = 72
      Align = alTop
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      TabOrder = 1
      object lbl_user_balance: TLabel
        Left = 2
        Top = 41
        Width = 268
        Height = 26
        Align = alTop
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = #1041#1072#1083#1072#1085#1089':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        Layout = tlCenter
        ExplicitTop = 15
        ExplicitWidth = 302
      end
      object lbl_user_name: TLabel
        Left = 2
        Top = 15
        Width = 268
        Height = 26
        Align = alTop
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 4
        ExplicitTop = 23
        ExplicitWidth = 302
      end
    end
  end
  object al_main: TActionList
    Left = 568
    Top = 272
    object a_buy: TAction
      Caption = #1050#1091#1087#1080#1090#1100
      OnExecute = a_buyExecute
    end
  end
end
