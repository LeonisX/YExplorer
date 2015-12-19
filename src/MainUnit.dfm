object MainForm: TMainForm
  Left = 192
  Top = 114
  Width = 667
  Height = 671
  Caption = 'Yoda Stories Explorer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 336
    Top = 8
    Width = 313
    Height = 297
  end
  object Button1: TButton
    Left = 16
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Process DTA'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 96
    Top = 8
    Width = 75
    Height = 25
    Caption = 'LoadBMP'
    TabOrder = 1
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 106
    Height = 34
    Caption = ' STUP '
    TabOrder = 2
    object STUPCB: TCheckBox
      Left = 14
      Top = 13
      Width = 87
      Height = 17
      Caption = 'Save to BMP'
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 74
    Width = 106
    Height = 34
    Caption = ' SNDS '
    TabOrder = 3
    object SNDSCB: TCheckBox
      Left = 14
      Top = 13
      Width = 87
      Height = 17
      Caption = 'List in LOG'
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 280
    Width = 321
    Height = 353
    Caption = ' LOG '
    TabOrder = 4
    object LogMemo: TRichEdit
      Left = 2
      Top = 15
      Width = 317
      Height = 336
      Align = alClient
      TabOrder = 0
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 108
    Width = 106
    Height = 34
    Caption = ' TILE '
    TabOrder = 5
    object TILECB: TCheckBox
      Left = 14
      Top = 13
      Width = 87
      Height = 17
      Caption = 'Save to BMP'
      TabOrder = 0
    end
  end
  object GroupBox5: TGroupBox
    Left = 120
    Top = 40
    Width = 145
    Height = 129
    Caption = ' ZONE '
    TabOrder = 6
    object ZONECB: TCheckBox
      Left = 14
      Top = 13
      Width = 123
      Height = 17
      Caption = 'Process ZONE'
      TabOrder = 0
    end
    object IZONCB: TCheckBox
      Left = 14
      Top = 29
      Width = 123
      Height = 17
      Caption = 'Save IZON to BMP'
      TabOrder = 1
    end
    object IZAXCB: TCheckBox
      Left = 14
      Top = 45
      Width = 87
      Height = 17
      Caption = 'Process IZAX'
      TabOrder = 2
    end
    object IZX2CB: TCheckBox
      Left = 14
      Top = 61
      Width = 87
      Height = 17
      Caption = 'Process IZX2'
      TabOrder = 3
    end
    object IZX3CB: TCheckBox
      Left = 14
      Top = 77
      Width = 87
      Height = 17
      Caption = 'Process IZX3'
      TabOrder = 4
    end
    object IZX4CB: TCheckBox
      Left = 14
      Top = 93
      Width = 87
      Height = 17
      Caption = 'Process IZX4'
      TabOrder = 5
    end
    object IACTCB: TCheckBox
      Left = 14
      Top = 109
      Width = 87
      Height = 17
      Caption = 'Process IACT'
      TabOrder = 6
    end
  end
  object GroupBox6: TGroupBox
    Left = 8
    Top = 142
    Width = 106
    Height = 34
    Caption = ' PUZ2 '
    TabOrder = 7
    object PUZ2CB: TCheckBox
      Left = 14
      Top = 13
      Width = 87
      Height = 17
      Caption = 'Process PUZ2'
      TabOrder = 0
    end
  end
  object GroupBox7: TGroupBox
    Left = 8
    Top = 176
    Width = 106
    Height = 34
    Caption = ' CHAR '
    TabOrder = 8
    object CHARCB: TCheckBox
      Left = 14
      Top = 13
      Width = 87
      Height = 17
      Caption = 'Process CHAR'
      TabOrder = 0
    end
  end
  object GroupBox8: TGroupBox
    Left = 8
    Top = 211
    Width = 106
    Height = 34
    Caption = ' CHWP '
    TabOrder = 9
    object CHWPCB: TCheckBox
      Left = 14
      Top = 13
      Width = 87
      Height = 17
      Caption = 'Process CHWP'
      TabOrder = 0
    end
  end
  object GroupBox9: TGroupBox
    Left = 8
    Top = 246
    Width = 106
    Height = 34
    Caption = ' CAUX '
    TabOrder = 10
    object CAUXCB: TCheckBox
      Left = 14
      Top = 13
      Width = 87
      Height = 17
      Caption = 'Process CAUX'
      TabOrder = 0
    end
  end
  object GroupBox10: TGroupBox
    Left = 120
    Top = 174
    Width = 145
    Height = 59
    Caption = ' TNAM '
    TabOrder = 11
    object TNAMCB: TCheckBox
      Left = 14
      Top = 13
      Width = 107
      Height = 17
      Caption = 'Process TNAM'
      TabOrder = 0
    end
    object CTCB: TCheckBox
      Left = 14
      Top = 29
      Width = 87
      Height = 17
      Caption = 'Copy tiles'
      TabOrder = 1
    end
  end
  object GroupBox11: TGroupBox
    Left = 120
    Top = 235
    Width = 106
    Height = 34
    Caption = ' TGEN '
    TabOrder = 12
    object TGENCB: TCheckBox
      Left = 14
      Top = 13
      Width = 87
      Height = 17
      Caption = 'Process TGEN'
      TabOrder = 0
    end
  end
  object OpenDTAButton: TButton
    Left = 216
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Open DTA'
    TabOrder = 13
    OnClick = OpenDTAButtonClick
  end
  object SaveSTUPButton: TButton
    Left = 288
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Save STUP'
    TabOrder = 14
    OnClick = SaveSTUPButtonClick
  end
  object ListSNDSButton: TButton
    Left = 288
    Top = 104
    Width = 75
    Height = 25
    Caption = 'List SNDS'
    TabOrder = 15
    OnClick = ListSNDSButtonClick
  end
  object SaveTextMemo: TMemo
    Left = 368
    Top = 464
    Width = 185
    Height = 89
    TabOrder = 16
    Visible = False
  end
  object OpenDTADialog: TOpenDialog
    DefaultExt = '*.dta'
    Filter = 'DTA files|*.dta|All files|*.*'
    Left = 296
    Top = 16
  end
end
