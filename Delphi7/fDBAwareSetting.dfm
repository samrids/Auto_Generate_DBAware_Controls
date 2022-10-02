object frmDBWareSetting: TfrmDBWareSetting
  Left = 689
  Top = 331
  BorderStyle = bsDialog
  Caption = 'Setting'
  ClientHeight = 186
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 68
    Width = 68
    Height = 13
    Caption = 'Column &count:'
    FocusControl = Edit1
  end
  object btnApply: TButton
    Left = 30
    Top = 122
    Width = 75
    Height = 25
    Caption = '&Save'
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 119
    Top = 122
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object UpDownRowCount: TUpDown
    Left = 153
    Top = 87
    Width = 16
    Height = 21
    Associate = Edit1
    Min = 5
    Max = 25
    Position = 8
    TabOrder = 2
  end
  object Chx_UseMultiColumn: TCheckBox
    Left = 32
    Top = 32
    Width = 137
    Height = 17
    Caption = 'Use &Multiple column'
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 32
    Top = 87
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '8'
  end
end
