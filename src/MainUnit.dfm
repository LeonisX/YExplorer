object MainForm: TMainForm
  Left = 192
  Top = 114
  Width = 910
  Height = 800
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
    Top = 328
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
  object GroupBox3: TGroupBox
    Left = 8
    Top = 216
    Width = 321
    Height = 545
    Caption = ' LOG '
    TabOrder = 2
    object LogMemo: TMemo
      Left = 2
      Top = 15
      Width = 317
      Height = 528
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object GroupBox6: TGroupBox
    Left = 8
    Top = 46
    Width = 106
    Height = 34
    Caption = ' PUZ2 '
    TabOrder = 3
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
    Top = 88
    Width = 106
    Height = 34
    Caption = ' CHAR '
    TabOrder = 4
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
    Top = 131
    Width = 106
    Height = 34
    Caption = ' CHWP '
    TabOrder = 5
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
    Top = 174
    Width = 106
    Height = 34
    Caption = ' CAUX '
    TabOrder = 6
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
    Top = 46
    Width = 145
    Height = 59
    Caption = ' TNAM '
    TabOrder = 7
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
    Top = 115
    Width = 106
    Height = 34
    Caption = ' TGEN '
    TabOrder = 8
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
    TabOrder = 9
    OnClick = OpenDTAButtonClick
  end
  object PageControl: TPageControl
    Left = 335
    Top = 8
    Width = 561
    Height = 313
    ActivePage = TabSheet5
    MultiLine = True
    TabIndex = 4
    TabOrder = 10
    object TabSheet1: TTabSheet
      Caption = 'Common information'
      object LabelCRC32: TLabel
        Left = 8
        Top = 24
        Width = 40
        Height = 13
        Caption = 'CRC-32:'
      end
      object LabelName: TLabel
        Left = 8
        Top = 40
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object CRC32Label: TLabel
        Left = 88
        Top = 24
        Width = 3
        Height = 13
      end
      object NameLabel: TLabel
        Left = 88
        Top = 40
        Width = 3
        Height = 13
      end
      object LabelSize: TLabel
        Left = 8
        Top = 8
        Width = 23
        Height = 13
        Caption = 'Size:'
      end
      object SizeLabel: TLabel
        Left = 88
        Top = 8
        Width = 3
        Height = 13
      end
      object VersionLabel: TLabel
        Left = 88
        Top = 56
        Width = 3
        Height = 13
      end
      object LabelVersion: TLabel
        Left = 8
        Top = 56
        Width = 75
        Height = 13
        Caption = 'Internal version:'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Title screen'
      ImageIndex = 1
      object SaveSTUPButton: TButton
        Left = 6
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Save to BMP'
        TabOrder = 0
        OnClick = SaveSTUPButtonClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Sounds'
      ImageIndex = 2
      object LabelSounds: TLabel
        Left = 8
        Top = 8
        Width = 69
        Height = 13
        Caption = 'Sounds count:'
      end
      object SoundsLabel: TLabel
        Left = 88
        Top = 8
        Width = 3
        Height = 13
      end
      object ListSNDSButton: TButton
        Left = 6
        Top = 32
        Width = 83
        Height = 25
        Caption = 'Save list to file'
        TabOrder = 0
        OnClick = ListSNDSButtonClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Tiles, sprites'
      ImageIndex = 3
      object TilesLabel: TLabel
        Left = 88
        Top = 8
        Width = 3
        Height = 13
      end
      object LabelTiles: TLabel
        Left = 8
        Top = 8
        Width = 55
        Height = 13
        Caption = 'Tiles count:'
      end
      object TilesProgressLabel: TLabel
        Left = 16
        Top = 160
        Width = 193
        Height = 13
        Alignment = taCenter
        AutoSize = False
      end
      object TilesProgressBar: TProgressBar
        Left = 16
        Top = 136
        Width = 193
        Height = 17
        Min = 0
        Max = 100
        Smooth = True
        Step = 1
        TabOrder = 8
      end
      object SaveTilesButton: TButton
        Left = 6
        Top = 32
        Width = 99
        Height = 25
        Caption = 'Save tiles to files'
        TabOrder = 0
        OnClick = SaveTilesButtonClick
      end
      object DecimalCheckBox: TCheckBox
        Left = 16
        Top = 64
        Width = 145
        Height = 17
        Caption = 'Decimal filenames'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object HexCheckBox: TCheckBox
        Left = 16
        Top = 88
        Width = 145
        Height = 17
        Caption = 'HEX filenames'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object AttrCheckBox: TCheckBox
        Left = 16
        Top = 112
        Width = 153
        Height = 17
        Caption = 'Group by attributes'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object ZeroColorRG: TRadioGroup
        Left = 232
        Top = 16
        Width = 201
        Height = 105
        Caption = ' "Zero" color '
        ItemIndex = 2
        Items.Strings = (
          'Black (original)'
          'White'
          'Fuchsia (transparent)')
        TabOrder = 4
      end
      object Panel1: TPanel
        Left = 374
        Top = 30
        Width = 48
        Height = 22
        Color = clBlack
        TabOrder = 5
      end
      object Panel2: TPanel
        Left = 374
        Top = 60
        Width = 48
        Height = 22
        Color = clWhite
        TabOrder = 6
      end
      object Panel3: TPanel
        Left = 374
        Top = 89
        Width = 48
        Height = 22
        Color = clFuchsia
        TabOrder = 7
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Zones (maps)'
      ImageIndex = 4
      object LabelMaps: TLabel
        Left = 8
        Top = 8
        Width = 59
        Height = 13
        Caption = 'Maps count:'
      end
      object MapsLabel: TLabel
        Left = 88
        Top = 8
        Width = 3
        Height = 13
      end
      object MapProgressLabel: TLabel
        Left = 16
        Top = 184
        Width = 193
        Height = 13
        Alignment = taCenter
        AutoSize = False
      end
      object SaveMapsButton: TButton
        Left = 6
        Top = 32
        Width = 99
        Height = 25
        Caption = 'Save maps to files'
        TabOrder = 0
        OnClick = SaveMapsButtonClick
      end
      object MapProgressBar: TProgressBar
        Left = 16
        Top = 160
        Width = 193
        Height = 17
        Min = 0
        Max = 100
        Smooth = True
        Step = 1
        TabOrder = 1
      end
      object MapPlanetSaveCheckBox: TCheckBox
        Left = 16
        Top = 112
        Width = 153
        Height = 17
        Caption = 'Group by planet type'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object MapFlagSaveCheckBox: TCheckBox
        Left = 16
        Top = 88
        Width = 145
        Height = 17
        Caption = 'Group by flags'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object MapSaveCheckBox: TCheckBox
        Left = 16
        Top = 64
        Width = 145
        Height = 17
        Caption = 'Normal save'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object ActionsCheckBox: TCheckBox
        Left = 16
        Top = 136
        Width = 145
        Height = 17
        Caption = 'Dump actions'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Puzzles'
      ImageIndex = 5
      object LabelPuzzles: TLabel
        Left = 8
        Top = 8
        Width = 69
        Height = 13
        Caption = 'Puzzles count:'
      end
      object PuzzlesLabel: TLabel
        Left = 88
        Top = 8
        Width = 3
        Height = 13
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Characters'
      ImageIndex = 6
      object LabelChars: TLabel
        Left = 8
        Top = 8
        Width = 84
        Height = 13
        Caption = 'Characters count:'
      end
      object CharsLabel: TLabel
        Left = 98
        Top = 8
        Width = 3
        Height = 13
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Names'
      ImageIndex = 9
      object LabelNames: TLabel
        Left = 8
        Top = 8
        Width = 66
        Height = 13
        Caption = 'Names count:'
      end
      object NamesLabel: TLabel
        Left = 88
        Top = 8
        Width = 3
        Height = 13
      end
    end
  end
  object OpenDTADialog: TOpenDialog
    DefaultExt = '*.dta'
    Filter = 'Desktop Adventures|*.dta;*.daw|All files|*.*'
    Left = 296
    Top = 16
  end
end
