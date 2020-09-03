object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'frmPrincipal'
  ClientHeight = 547
  ClientWidth = 843
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object redtJson: TJvRichEdit
    Left = 0
    Top = 76
    Width = 843
    Height = 471
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    SelText = ''
    TabOrder = 0
  end
  object btnVai: TButton
    Left = 8
    Top = 8
    Width = 157
    Height = 54
    Caption = 'Gerar'
    TabOrder = 1
    OnClick = btnVaiClick
  end
  object chkFormatado: TCheckBox
    Left = 200
    Top = 28
    Width = 97
    Height = 17
    Caption = 'Formatado'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
end
