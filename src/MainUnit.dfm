object MainForm: TMainForm
  Left = 192
  Top = 114
  Width = 1119
  Height = 772
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
  object Splitter1: TSplitter
    Left = 0
    Top = 417
    Width = 1111
    Height = 12
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
  end
  object OpenDTAButton: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Open DTA'
    TabOrder = 0
    OnClick = OpenDTAButtonClick
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 1111
    Height = 417
    ActivePage = TabSheet4
    Align = alClient
    MultiLine = True
    TabIndex = 3
    TabOrder = 1
    Visible = False
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
      object SectionsStringGrid: TStringGrid
        Left = 8
        Top = 80
        Width = 353
        Height = 249
        DefaultRowHeight = 18
        RowCount = 2
        TabOrder = 0
        OnSelectCell = SectionsStringGridSelectCell
      end
      object GroupBox11: TGroupBox
        Left = 694
        Top = 283
        Width = 106
        Height = 34
        Caption = ' TGEN '
        TabOrder = 1
        object TGENCB: TCheckBox
          Left = 14
          Top = 13
          Width = 87
          Height = 17
          Caption = 'Process TGEN'
          TabOrder = 0
        end
      end
      object GroupBox10: TGroupBox
        Left = 655
        Top = 258
        Width = 145
        Height = 59
        Caption = ' TNAM '
        TabOrder = 2
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
      object GroupBox9: TGroupBox
        Left = 600
        Top = 283
        Width = 106
        Height = 34
        Caption = ' CAUX '
        TabOrder = 3
        object CAUXCB: TCheckBox
          Left = 14
          Top = 13
          Width = 87
          Height = 17
          Caption = 'Process CAUX'
          TabOrder = 0
        end
      end
      object GroupBox8: TGroupBox
        Left = 560
        Top = 283
        Width = 106
        Height = 34
        Caption = ' CHWP '
        TabOrder = 4
        object CHWPCB: TCheckBox
          Left = 14
          Top = 13
          Width = 87
          Height = 17
          Caption = 'Process CHWP'
          TabOrder = 0
        end
      end
      object GroupBox7: TGroupBox
        Left = 448
        Top = 283
        Width = 106
        Height = 34
        Caption = ' CHAR '
        TabOrder = 5
        object CHARCB: TCheckBox
          Left = 14
          Top = 13
          Width = 87
          Height = 17
          Caption = 'Process CHAR'
          TabOrder = 0
        end
      end
      object GroupBox6: TGroupBox
        Left = 336
        Top = 283
        Width = 106
        Height = 34
        Caption = ' PUZ2 '
        TabOrder = 6
        object PUZ2CB: TCheckBox
          Left = 14
          Top = 13
          Width = 87
          Height = 17
          Caption = 'Process PUZ2'
          TabOrder = 0
        end
      end
      object Button2: TButton
        Left = 80
        Top = 292
        Width = 75
        Height = 25
        Caption = 'LoadBMP'
        TabOrder = 7
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = -8
        Top = 292
        Width = 75
        Height = 25
        Caption = 'Process DTA'
        TabOrder = 8
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Title screen'
      ImageIndex = 1
      object TitleImage: TImage
        Left = 256
        Top = 8
        Width = 288
        Height = 288
      end
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
      object TileImage: TImage
        Left = 16
        Top = 160
        Width = 32
        Height = 32
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
      object TilesDrawGrid: TDrawGrid
        Left = 440
        Top = 16
        Width = 585
        Height = 361
        Color = clBtnFace
        ColCount = 16
        DefaultColWidth = 32
        DefaultRowHeight = 32
        DragMode = dmAutomatic
        FixedCols = 0
        FixedRows = 0
        GridLineWidth = 2
        Options = [goVertLine, goHorzLine, goDrawFocusSelected]
        TabOrder = 9
        OnDrawCell = TilesDrawGridDrawCell
      end
      object Memo1: TMemo
        Left = 128
        Top = 208
        Width = 185
        Height = 89
        DragKind = dkDock
        DragMode = dmAutomatic
        Lines.Strings = (
          'Memo1')
        TabOrder = 10
        OnDragDrop = Memo1DragDrop
        OnDragOver = Memo1DragOver
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
      object MapImage: TImage
        Left = 216
        Top = 7
        Width = 288
        Height = 288
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
      object MapsStringGrid: TStringGrid
        Left = 8
        Top = 80
        Width = 1089
        Height = 249
        ColCount = 18
        DefaultColWidth = 58
        DefaultRowHeight = 18
        RowCount = 2
        TabOrder = 6
        OnSelectCell = MapsStringGridSelectCell
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
  object BottomPageControl: TPageControl
    Left = 0
    Top = 429
    Width = 1111
    Height = 290
    ActivePage = TabSheet9
    Align = alBottom
    TabIndex = 1
    TabOrder = 2
    object TabSheet8: TTabSheet
      Caption = 'Log'
      object LogMemo: TMemo
        Left = 0
        Top = 0
        Width = 1103
        Height = 262
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'HEX viewer'
      ImageIndex = 1
      object HEX: TMPHexEditor
        Left = 0
        Top = 0
        Width = 1103
        Height = 262
        Cursor = crIBeam
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Style = []
        OnKeyUp = HEXKeyUp
        OnMouseUp = HEXMouseUp
        ParentFont = False
        TabOrder = 0
        BytesPerRow = 16
        Translation = tkAsIs
        OffsetFormat = '-!10:0x|'
        Colors.Background = clWindow
        Colors.ChangedBackground = 11075583
        Colors.ChangedText = clMaroon
        Colors.CursorFrame = clNavy
        Colors.Offset = clBlack
        Colors.OddColumn = clBlue
        Colors.EvenColumn = clNavy
        Colors.CurrentOffsetBackground = clBtnShadow
        Colors.OffsetBackground = clBtnFace
        Colors.CurrentOffset = clBtnHighlight
        Colors.Grid = clBtnFace
        Colors.NonFocusCursorFrame = clAqua
        Colors.ActiveFieldBackground = clWindow
        FocusFrame = True
        DrawGridLines = False
        Version = 'september 30, 2007; '#169' markus stephany, vcl[at]mirkes[dot]de'
        ShowRuler = True
        ShowPositionIfNotFocused = True
        OnSelectionChanged = HEXSelectionChanged
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 719
    Width = 1111
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object OpenDTADialog: TOpenDialog
    DefaultExt = '*.dta'
    Filter = 'Desktop Adventures|*.dta;*.daw|All files|*.*'
    Left = 832
    Top = 120
  end
end
