object frmDBWareSetting: TfrmDBWareSetting
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Generation DBAware controls option.'
  ClientHeight = 211
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 68
    Width = 69
    Height = 13
    Caption = 'Column &count:'
    FocusControl = Edit1
  end
  object btnApply: TButton
    Left = 350
    Top = 178
    Width = 75
    Height = 25
    Caption = '&Save'
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 431
    Top = 178
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
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 32
    Top = 87
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    Text = '8'
  end
end
