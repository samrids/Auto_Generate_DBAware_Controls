object frmViewData: TfrmViewData
  Left = 0
  Top = 0
  Width = 1055
  Height = 596
  Caption = 'Item informations.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 516
    Width = 1039
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1039
      41)
    object Label1: TLabel
      Left = 96
      Top = 8
      Width = 193
      Height = 13
      Caption = 'Close the form by pressing the ESC key.'
    end
    object Button2: TButton
      Left = 954
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'C&lose'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 9
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Set&ting'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object cxScrollBox1: TcxScrollBox
    Left = 0
    Top = 0
    Width = 1039
    Height = 516
    Align = alClient
    TabOrder = 1
  end
  object DataSource1: TDataSource
    Left = 688
    Top = 104
  end
  object ActionList1: TActionList
    Left = 816
    Top = 232
    object SaveAction: TAction
      Caption = '&Save'
      ShortCut = 16467
    end
    object DeleteAction: TAction
      Caption = 'Delete'
      ShortCut = 16452
    end
  end
end
