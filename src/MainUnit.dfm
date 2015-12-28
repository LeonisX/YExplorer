object MainForm: TMainForm
  Left = 192
  Top = 114
  Width = 861
  Height = 847
  Caption = 'Yoda Stories Explorer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 444
    Width = 853
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
    Width = 853
    Height = 444
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
      object Button2: TButton
        Left = 80
        Top = 292
        Width = 75
        Height = 25
        Caption = 'LoadBMP'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button6: TButton
        Left = 16
        Top = 344
        Width = 75
        Height = 25
        Caption = 'Save DTA'
        TabOrder = 2
        OnClick = Button6Click
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
        Width = 83
        Height = 25
        Caption = 'Save to BMP'
        TabOrder = 0
        OnClick = SaveSTUPButtonClick
      end
      object Button7: TButton
        Left = 8
        Top = 40
        Width = 81
        Height = 25
        Caption = 'Load from BMP'
        TabOrder = 1
        OnClick = Button7Click
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
        Left = 296
        Top = 4
        Width = 3
        Height = 13
      end
      object LabelTiles: TLabel
        Left = 224
        Top = 4
        Width = 55
        Height = 13
        Caption = 'Tiles count:'
      end
      object TilesProgressLabel: TLabel
        Left = 8
        Top = 136
        Width = 193
        Height = 13
        Alignment = taCenter
        AutoSize = False
      end
      object TileImage: TImage
        Left = 176
        Top = 8
        Width = 32
        Height = 32
      end
      object Label1: TLabel
        Left = 816
        Top = 4
        Width = 75
        Height = 13
        Caption = 'Clipboard image'
      end
      object Label2: TLabel
        Left = 8
        Top = 216
        Width = 71
        Height = 13
        Caption = 'Tiles in a row:  '
      end
      object TilesProgressBar: TProgressBar
        Left = 8
        Top = 112
        Width = 193
        Height = 17
        Min = 0
        Max = 100
        Smooth = True
        Step = 1
        TabOrder = 4
      end
      object SaveTilesButton: TButton
        Left = 6
        Top = 8
        Width = 163
        Height = 25
        Caption = 'Save tiles to files (separate)'
        TabOrder = 0
        OnClick = SaveTilesButtonClick
      end
      object DecimalCheckBox: TCheckBox
        Left = 16
        Top = 40
        Width = 145
        Height = 17
        Caption = 'Decimal filenames'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object HexCheckBox: TCheckBox
        Left = 16
        Top = 64
        Width = 145
        Height = 17
        Caption = 'HEX filenames'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object AttrCheckBox: TCheckBox
        Left = 16
        Top = 88
        Width = 153
        Height = 17
        Caption = 'Group by attributes'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object TilesDrawGrid: TDrawGrid
        Left = 224
        Top = 24
        Width = 585
        Height = 385
        Color = clBtnFace
        ColCount = 16
        DefaultColWidth = 32
        DefaultRowHeight = 32
        FixedCols = 0
        FixedRows = 0
        Options = [goVertLine, goHorzLine, goDrawFocusSelected]
        TabOrder = 5
        OnDragDrop = TilesDrawGridDragDrop
        OnDragOver = TilesDrawGridDragOver
        OnDrawCell = TilesDrawGridDrawCell
        OnKeyDown = TilesDrawGridKeyUp
        OnKeyUp = TilesDrawGridKeyUp
        OnMouseDown = TilesDrawGridMouseDown
        OnMouseUp = TilesDrawGridMouseUp
        OnMouseWheelDown = TilesDrawGridMouseWheelDown
        OnMouseWheelUp = TilesDrawGridMouseWheelUp
        OnSelectCell = TilesDrawGridSelectCell
      end
      object Panel4: TPanel
        Left = 814
        Top = 24
        Width = 288
        Height = 288
        BevelOuter = bvLowered
        TabOrder = 6
        object ClipboardImage: TImage
          Left = 0
          Top = 0
          Width = 288
          Height = 288
          OnDragDrop = ClipboardImageDragDrop
          OnDragOver = ClipboardImageDragOver
          OnMouseDown = ClipboardImageMouseDown
        end
      end
      object Button3: TButton
        Left = 864
        Top = 320
        Width = 57
        Height = 25
        Caption = 'Save'
        TabOrder = 7
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 928
        Top = 320
        Width = 57
        Height = 25
        Caption = 'Load'
        TabOrder = 8
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 992
        Top = 320
        Width = 57
        Height = 25
        Caption = 'Clear'
        TabOrder = 9
        OnClick = Button5Click
      end
      object Button8: TButton
        Left = 6
        Top = 184
        Width = 163
        Height = 25
        Caption = 'Save tiles to one file'
        TabOrder = 10
        OnClick = Button8Click
      end
      object Edit1: TEdit
        Left = 80
        Top = 213
        Width = 41
        Height = 21
        TabOrder = 11
        Text = '16'
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
        Top = 240
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
        Top = 216
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
        TabOrder = 2
      end
      object MapFlagSaveCheckBox: TCheckBox
        Left = 16
        Top = 88
        Width = 145
        Height = 17
        Caption = 'Group by flags'
        TabOrder = 3
      end
      object MapSaveCheckBox: TCheckBox
        Left = 16
        Top = 64
        Width = 145
        Height = 17
        Caption = 'Normal save'
        TabOrder = 4
      end
      object ActionsCheckBox: TCheckBox
        Left = 16
        Top = 136
        Width = 145
        Height = 17
        Caption = 'Dump actions'
        TabOrder = 5
      end
      object MapsStringGrid: TStringGrid
        Left = 232
        Top = 112
        Width = 1089
        Height = 249
        ColCount = 18
        DefaultColWidth = 58
        DefaultRowHeight = 18
        RowCount = 2
        TabOrder = 6
        OnSelectCell = MapsStringGridSelectCell
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 184
        Width = 145
        Height = 17
        Caption = 'Save unused tiles'
        TabOrder = 7
      end
      object CheckBox2: TCheckBox
        Left = 16
        Top = 160
        Width = 145
        Height = 17
        Caption = 'Dump text'
        Checked = True
        State = cbChecked
        TabOrder = 8
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
      object Button9: TButton
        Left = 6
        Top = 32
        Width = 107
        Height = 25
        Caption = 'Save puzzles to files'
        TabOrder = 0
        OnClick = Button9Click
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
      object Button10: TButton
        Left = 6
        Top = 32
        Width = 123
        Height = 25
        Caption = 'Save characters to files'
        TabOrder = 0
        OnClick = Button10Click
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
      object Button11: TButton
        Left = 6
        Top = 32
        Width = 123
        Height = 25
        Caption = 'Save names to files'
        TabOrder = 0
        OnClick = Button11Click
      end
    end
  end
  object BottomPageControl: TPageControl
    Left = 0
    Top = 456
    Width = 853
    Height = 318
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
        Width = 845
        Height = 290
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
    Top = 774
    Width = 853
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object OpenDTADialog: TOpenDialog
    DefaultExt = '*.dta'
    Filter = 'Desktop Adventures|*.dta|All files|*.*'
    Left = 832
    Top = 104
  end
  object SaveClipboardDialog: TSaveDialog
    DefaultExt = '*.bmp'
    FileName = 'unnamed.bmp'
    Filter = 'Bitmaps|*.bmp'
    Left = 872
    Top = 104
  end
  object OpenClipboardDialog: TOpenDialog
    DefaultExt = '*.bmp'
    Filter = 'Bitmaps|*.bmp|All files|*.*'
    Left = 912
    Top = 104
  end
  object SaveDTADialog: TSaveDialog
    DefaultExt = '*.dta'
    Filter = 'Desktop Adventures|*.dta|All files|*.*'
    Left = 832
    Top = 144
  end
  object MainMenu1: TMainMenu
    Left = 248
    Top = 24
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
      end
    end
    object Settings1: TMenuItem
      Caption = 'Settings'
      object TransparentColorMenuItem: TMenuItem
        Caption = 'Transparent color'
        GroupIndex = 13
        object FuchsiaMenuItem: TMenuItem
          Tag = 16646398
          AutoCheck = True
          Bitmap.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
          Caption = 'Fuchsia'
          Checked = True
          Default = True
          GroupIndex = 13
          ImageIndex = 1
          RadioItem = True
          OnClick = WhiteMenuItemClick
        end
        object BlackMenuItem: TMenuItem
          Tag = 65793
          AutoCheck = True
          Bitmap.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          Caption = 'Black'
          GroupIndex = 13
          ImageIndex = 2
          RadioItem = True
          OnClick = WhiteMenuItemClick
        end
        object WhiteMenuItem: TMenuItem
          Tag = 16711422
          AutoCheck = True
          Bitmap.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            88888FFFFFFFFFFFFFF88FFFFFFFFFFFFFF88FFFFFFFFFFFFFF88FFFFFFFFFFF
            FFF88FFFFFFFFFFFFFF88FFFFFFFFFFFFFF88FFFFFFFFFFFFFF88FFFFFFFFFFF
            FFF88FFFFFFFFFFFFFF88FFFFFFFFFFFFFF88FFFFFFFFFFFFFF88FFFFFFFFFFF
            FFF88FFFFFFFFFFFFFF88FFFFFFFFFFFFFF88888888888888888}
          Caption = 'White'
          GroupIndex = 13
          RadioItem = True
          OnClick = WhiteMenuItemClick
        end
      end
    end
    object Operations1: TMenuItem
      Caption = 'Operations'
      object AddTiles: TMenuItem
        Caption = 'Add tile(s)'
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Howto1: TMenuItem
        Caption = 'How to...'
      end
      object About1: TMenuItem
        Caption = 'About...'
      end
    end
  end
  object TilesPopupMenu: TPopupMenu
    Left = 296
    Top = 264
    object Adddtiles1: TMenuItem
      Caption = 'Add tile(s)'
    end
    object Setflag1: TMenuItem
      Caption = 'Set flag'
      object Bottomlayer1: TMenuItem
        Tag = 2
        AutoCheck = True
        Caption = 'Bottom layer'
        GroupIndex = 7
        RadioItem = True
        OnClick = Bottomlayer1Click
      end
      object Middlelayer1: TMenuItem
        Tag = 4
        AutoCheck = True
        Caption = 'Middle layer'
        GroupIndex = 7
        RadioItem = True
        OnClick = Bottomlayer1Click
      end
      object Middlelayertransparent1: TMenuItem
        Tag = 5
        AutoCheck = True
        Caption = 'Middle layer (transparent)'
        GroupIndex = 7
        RadioItem = True
        OnClick = Bottomlayer1Click
      end
      object Pushpullblock1: TMenuItem
        Tag = 13
        AutoCheck = True
        Caption = 'Push/pull block'
        GroupIndex = 7
        RadioItem = True
        OnClick = Bottomlayer1Click
      end
      object oplayer1: TMenuItem
        Tag = 16
        AutoCheck = True
        Caption = 'Top layer'
        GroupIndex = 7
        RadioItem = True
        OnClick = Bottomlayer1Click
      end
      object oplayertransparent1: TMenuItem
        Tag = 17
        AutoCheck = True
        Caption = 'Top layer (transparent)'
        GroupIndex = 7
        RadioItem = True
        OnClick = Bottomlayer1Click
      end
      object Weapons1: TMenuItem
        Caption = 'Weapons'
        GroupIndex = 7
        object LightBlaster1: TMenuItem
          Tag = 65601
          AutoCheck = True
          Caption = 'Light Blaster'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object HeavyBlasterThermalDetonator1: TMenuItem
          Tag = 131137
          AutoCheck = True
          Caption = 'Heavy Blaster, Thermal Detonator'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Lightsaber1: TMenuItem
          Tag = 262209
          AutoCheck = True
          Caption = 'Lightsaber'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object heForce1: TMenuItem
          Tag = 524353
          AutoCheck = True
          Caption = 'The Force'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
      end
      object Items1: TMenuItem
        Caption = 'Items'
        GroupIndex = 7
        object Keycard1: TMenuItem
          Tag = 65665
          AutoCheck = True
          Caption = 'Keycard'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Itemforuse1: TMenuItem
          Tag = 131201
          AutoCheck = True
          Caption = 'Item (for use)'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Itempartof1: TMenuItem
          Tag = 262273
          AutoCheck = True
          Caption = 'Item (part of)'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Itemtotrade1: TMenuItem
          Tag = 524417
          AutoCheck = True
          Caption = 'Item (to trade)'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Locator1: TMenuItem
          Tag = 1048705
          AutoCheck = True
          Caption = 'Locator'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Healthpack1: TMenuItem
          Tag = 4194433
          AutoCheck = True
          Caption = 'Health pack'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
      end
      object Characters1: TMenuItem
        Caption = 'Characters'
        GroupIndex = 7
        object Player1: TMenuItem
          Tag = 65793
          AutoCheck = True
          Caption = 'Player'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Enemy1: TMenuItem
          Tag = 131329
          AutoCheck = True
          Caption = 'Enemy'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Friendly1: TMenuItem
          Tag = 262401
          AutoCheck = True
          Caption = 'Friendly'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
      end
      object Doorpassageladder1: TMenuItem
        Tag = 65538
        AutoCheck = True
        Caption = 'Door, passage, ladder'
        GroupIndex = 7
        RadioItem = True
        OnClick = Bottomlayer1Click
      end
      object Minimap1: TMenuItem
        Caption = 'Mini map'
        GroupIndex = 7
        object Home1: TMenuItem
          Tag = 131104
          AutoCheck = True
          Caption = 'Home'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Puzzle1: TMenuItem
          Tag = 262176
          AutoCheck = True
          Caption = 'Puzzle'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Puzzlesolved1: TMenuItem
          Tag = 524320
          AutoCheck = True
          Caption = 'Puzzle (solved)'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Gateway1: TMenuItem
          Tag = 1048608
          AutoCheck = True
          Caption = 'Gateway'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Gatewaysolved1: TMenuItem
          Tag = 2097184
          AutoCheck = True
          Caption = 'Gateway (solved)'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Upwalllocked1: TMenuItem
          Tag = 4194336
          AutoCheck = True
          Caption = 'Up wall (locked)'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Downwalllocked1: TMenuItem
          Tag = 8388640
          AutoCheck = True
          Caption = 'Down wall (locked)'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Leftwalllocked1: TMenuItem
          Tag = 16777248
          AutoCheck = True
          Caption = 'Left wall (locked)'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Rightwalllocked1: TMenuItem
          Tag = 33554464
          AutoCheck = True
          Caption = 'Right wall (locked)'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Upwall1: TMenuItem
          Tag = 67108896
          AutoCheck = True
          Caption = 'Up wall'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Downwall1: TMenuItem
          Tag = 134217760
          AutoCheck = True
          Caption = 'Down wall'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Leftwall1: TMenuItem
          Tag = 268435488
          AutoCheck = True
          Caption = 'Left wall'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Rightwall1: TMenuItem
          Tag = 536870944
          AutoCheck = True
          Caption = 'Right wall'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Objective1: TMenuItem
          Tag = 1073741856
          AutoCheck = True
          Caption = 'Objective'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
        object Currentposition1: TMenuItem
          Tag = 2000000000
          AutoCheck = True
          Caption = 'Current position'
          GroupIndex = 7
          RadioItem = True
          OnClick = Bottomlayer1Click
        end
      end
    end
  end
end
