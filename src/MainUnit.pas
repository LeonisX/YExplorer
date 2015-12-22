//прошил ZONE насквозь
//надо сделать обработку IZON, желательно IACT тоже, или хотя бы сохранять их как-то

unit MainUnit;

interface

uses
  Windows, Forms, BMPUnit, DataStructureUnit, LoggerUnit, StdCtrls, Controls, Classes, ExtCtrls, SysUtils, StrUtils, Graphics, dialogs,
  ComCtrls;

const
  OUTPUT = 'output';
  eBMP = '.bmp';
  TileSize = 32;
  
type
  TMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox3: TGroupBox;
    GroupBox6: TGroupBox;
    PUZ2CB: TCheckBox;
    GroupBox7: TGroupBox;
    CHARCB: TCheckBox;
    GroupBox8: TGroupBox;
    CHWPCB: TCheckBox;
    GroupBox9: TGroupBox;
    CAUXCB: TCheckBox;
    GroupBox10: TGroupBox;
    TNAMCB: TCheckBox;
    CTCB: TCheckBox;
    GroupBox11: TGroupBox;
    TGENCB: TCheckBox;
    OpenDTAButton: TButton;
    OpenDTADialog: TOpenDialog;
    Image1: TImage;
    LogMemo: TMemo;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    LabelCRC32: TLabel;
    LabelName: TLabel;
    CRC32Label: TLabel;
    NameLabel: TLabel;
    LabelSize: TLabel;
    SizeLabel: TLabel;
    VersionLabel: TLabel;
    LabelVersion: TLabel;
    SaveSTUPButton: TButton;
    ListSNDSButton: TButton;
    TabSheet10: TTabSheet;
    TilesLabel: TLabel;
    LabelTiles: TLabel;
    SaveTilesButton: TButton;
    LabelSounds: TLabel;
    SoundsLabel: TLabel;
    LabelMaps: TLabel;
    MapsLabel: TLabel;
    LabelPuzzles: TLabel;
    PuzzlesLabel: TLabel;
    LabelChars: TLabel;
    CharsLabel: TLabel;
    LabelNames: TLabel;
    NamesLabel: TLabel;
    DecimalCheckBox: TCheckBox;
    HexCheckBox: TCheckBox;
    AttrCheckBox: TCheckBox;
    ZeroColorRG: TRadioGroup;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    TilesProgressBar: TProgressBar;
    TilesProgressLabel: TLabel;
    SaveMapsButton: TButton;
    MapProgressBar: TProgressBar;
    MapPlanetSaveCheckBox: TCheckBox;
    MapFlagSaveCheckBox: TCheckBox;
    MapSaveCheckBox: TCheckBox;
    MapProgressLabel: TLabel;
    ActionsCheckBox: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OpenDTAButtonClick(Sender: TObject);
    procedure SaveSTUPButtonClick(Sender: TObject);
    procedure ListSNDSButtonClick(Sender: TObject);
    procedure SaveTilesButtonClick(Sender: TObject);
    procedure SaveMapsButtonClick(Sender: TObject);
  private
  public
    procedure ReadOIE(id: Word);
    procedure ReadIZON(id: Word);
    procedure ReadIZAX(id: Word);
    procedure ReadIZX2(id: Word);
    procedure ReadIZX3(id: Word);
    procedure ReadIZX4(id: Word);
    procedure ReadIACT(id: Word);
    procedure ReadPUZ2;
    procedure ReadCHAR;
    procedure ReadCHWP;
    procedure ReadCAUX;
    procedure ReadTNAM;
    procedure ReadTGEN;
    procedure DumpData(fileName: String; offset, size: Cardinal);
  end;

var
  MainForm: TMainForm;
  pn:word;
  spath, opath: String;

implementation

{$R *.dfm}





procedure TMainForm.Button1Click(Sender: TObject);
var keepReading:boolean;
s:string;
begin
  log.Clear;

  CreateDir('output');
  assignfile(SrcFile, 'input\Yodesk.dta');
  Reset(SrcFile,1);

  keepReading:=true;
  while (keepReading) do
    begin
      s := DTA.ReadString(4);
      case DTA.ChunkIndex(s) of
       6: ReadPUZ2; //ещё диалоги
       7: ReadCHAR; //персонажи?
       8: ReadCHWP; //персонажи?????
       9: ReadCAUX; //персонажи?????
       10: ReadTNAM; //названия+тайлы
       11: ReadTGEN; //встречается в германском образе. Что такое - не знаю.
       12: keepReading:=false;
      else
       begin
        showmessage('Неизвестная секция: '+s);
        keepReading:=false;
       end;
      end;
  end;
  closefile(SrcFile);
  LOG.debug('всё...');
end;

procedure TMainForm.ReadTGEN;
var size:longword;
begin
  size := DTA.ReadLongWord;
  LOG.debug('TGEN: '+inttohex(size,4)); //4 байта - длина блока TGEN
  if TGENCB.Checked then
    begin
    //надо расшифровать
    showmessage('Обработка tGEN пока не поддерживается!!!');
    seek(SrcFile,filepos(SrcFile) + size);
    end else
       seek(SrcFile,filepos(SrcFile) + size);
end;

procedure TMainForm.ReadTNAM;
var size:longword;
k:word;
s:string;
begin
  size:=DTA.ReadLongWord;
  LOG.debug('TNAM: '+inttohex(size,4)); //4 байта - длина блока TNAM
  if TNAMCB.Checked then
    begin
      CreateDir('output/Names');
      repeat
         k:=DTA.ReadWord; //2 байта - номер персонажа (тайла)
         if k=$FFFF then break;
         s:=DTA.ReadString(24); //24 байта - длина до конца текущего имени
         s:=leftstr(s,pos(chr(0),s)-1);
         if CTCB.Checked then CopyFile(pchar('output/Tiles/'+rightstr('000'+inttostr(k),4)+'.bmp'),
                                 pchar('output/Names/'+s+'.bmp'),false);
         LOG.debug(s);
//         showmessage(s);
      until false;
    end else
       seek(SrcFile,filepos(SrcFile)+size);
end;

procedure TMainForm.ReadCAUX;
var size:longword;
begin
  size:=DTA.ReadLongWord;
  LOG.debug('CAUX: '+inttohex(size,4)); //4 байта - длина блока CAUX
  if CAUXCB.Checked then
    begin
    //надо расшифровать
    showmessage('Обработка CAUX пока не поддерживается!!!');
    seek(SrcFile,filepos(SrcFile)+size);
    end else
       seek(SrcFile,filepos(SrcFile)+size);
end;

procedure TMainForm.ReadCHWP;
var size:longword;
begin
  size:=DTA.ReadLongWord;
  LOG.debug('CHWP: '+inttohex(size,4)); //4 байта - длина блока CHWP
  if CHWPCB.Checked then
    begin
    //надо расшифровать
    showmessage('Обработка CHWP пока не поддерживается!!!');
    seek(SrcFile,filepos(SrcFile)+size);
    end else
       seek(SrcFile,filepos(SrcFile)+size);
end;

procedure TMainForm.ReadCHAR;
var size:longword;
begin
  size:=DTA.ReadLongWord;
  LOG.debug('CHAR: '+inttohex(size,4)); //4 байта - длина блока CHAR
  if CHARCB.Checked then
    begin
    //2 байта - номер персонажа
    //4 байта ICHA
    //4 байта - длина до конца текущего
    showmessage('Обработка CHAR пока не поддерживается!!!');
    seek(SrcFile,filepos(SrcFile)+size);
    end else
       seek(SrcFile,filepos(SrcFile)+size);
end;

procedure TMainForm.ReadPUZ2;
var size:longword;
begin
  size:=DTA.ReadLongWord;
  LOG.debug('PUZ2: '+inttohex(size,4)); //4 байта - длина блока PUZ2
  if PUZ2CB.Checked then
    begin
    //2 байта - не используется (00 00)
    //2 байта - номер паззла
    //4 байта IPUZ
    //2 байта - длина паззла (до конца текущего)
    showmessage('Обработка PUZ2 пока не поддерживается!!!');
    seek(SrcFile,filepos(SrcFile)+size);
    end else
       seek(SrcFile,filepos(SrcFile)+size);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  spath := ExtractFilePath(paramstr(0));
  opath := spath + OUTPUT + '\';
  BMP := TBitmap.Create;
  BMP.PixelFormat:=pf8bit;
  OpenDTADialog.InitialDir := '.\';
  log.SetOutput(LogMemo.lines);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  BMP.Free;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  LoadBMP('output/STUP.bmp',bmp);
  CopyPicture(Image1,0,0);
end;


procedure TMainForm.OpenDTAButtonClick(Sender: TObject);
begin
  if OpenDTADialog.Execute then
    begin
      log.Clear;
      DTA.readDTAMetricks(OpenDTADialog.FileName);
      VersionLabel.Caption := DTA.version;
      SizeLabel.Caption := IntToStr(DTA.size);
      CRC32Label.Caption := DTA.crc32;
      NameLabel.Caption := DTA.dtaRevision;

      SoundsLabel.Caption := IntToStr(DTA.soundsCount);

      TilesLabel.Caption := IntToStr(DTA.tilesCount);

      MapsLabel.Caption := IntToStr(DTA.mapsCount);

      PuzzlesLabel.Caption := IntToStr(DTA.puzzlesCount);

      CharsLabel.Caption := IntToStr(DTA.charsCount);

      NamesLabel.Caption := IntToStr(DTA.namesCount);

      Log.SaveToFile(opath, 'Structure');
    end;
end;





procedure TMainForm.SaveSTUPButtonClick(Sender: TObject);
var title: String;
begin
  Log.Clear;
  CreateDir(opath);
  title := knownSections[2]; // STUP
  FillInternalPalette(BMP, 0, 0, 0);
  BMP.Width:=288; BMP.Height:=288;
  ReadPicture(DTA, DTA.GetOffset(title));
  CopyPicture(Image1, 0, 0);
  Application.ProcessMessages;
  SaveBMP(opath + title + '.bmp', bmp);
  Log.Debug('Title screen saved');
end;

procedure TMainForm.ListSNDSButtonClick(Sender: TObject);
var sz, msz, i: Integer;
  title: String;
begin
  Log.Clear;
  Log.Debug('Sounds & melodies:');
  Log.Debug('');
  title := knownSections[3]; // SNDS
  DTA.SetIndex(title);
  Log.Debug('Unknown value: ' + inttohex(DTA.ReadWord, 4)); // C0 FF ??????
  i := 0;
  while DTA.InBound(title) do
   begin
    msz := DTA.ReadWord;
    Log.Debug('#' + rightstr('00'+inttostr(i),2) + ': ' + DTA.ReadString(msz - 1));
    DTA.ReadByte;                   // 00 at the end of string
    inc(i)
   end;
  Log.SaveToFile(opath, title);
end;

function IntToBin(Value: LongWord): string;
var i: Integer;
begin
  SetLength(Result, 32);
  for i := 1 to 32 do begin
    if ((Value shl (i-1)) shr 31) = 0 then begin
      Result[i] := '0'
    end else begin
      Result[i] := '1';
    end;
  end;
end;


procedure TMainForm.SaveTilesButtonClick(Sender: TObject);
var tilesPath, hexPath, attrPath, attrFullPath, title: String;
attr, sz, i: Cardinal;
begin
  TilesProgressBar.Position := 0;
  TilesProgressBar.Max := DTA.tilesCount;
  tilesPath := opath +'Tiles';
  hexPath := opath +'TilesHex';
  attrPath := opath +'TilesByAttr';
  Log.Clear;
  CreateDir(opath);
  if DecimalCheckBox.Checked then CreateDir(tilesPath);
  if HexCheckBox.Checked then CreateDir(hexPath);
  if AttrCheckBox.Checked then CreateDir(attrPath);
  case ZeroColorRG.ItemIndex of
       0: FillInternalPalette(BMP, 0, 0, 0);
       1: FillInternalPalette(BMP, $FF, $FF, $FF);
       2: FillInternalPalette(BMP, $FF, 0, $FF);
  end;
  BMP.Width := TileSize;
  BMP.Height := TileSize;
  title := knownSections[4]; // TILE
  DTA.SetIndex(title);
  for i := 0 to DTA.tilesCount - 1 do
  begin
    attr := DTA.ReadLongWord; // attributes
    ReadPicture(DTA, 0);
    CopyPicture(Image1, 0, 0);
    Application.ProcessMessages;
    //  SaveBMP('output/Tiles/'+rightstr('000'+inttostr(i),4)+' - '+inttohex(k,6)+'.bmp',bmp);
    if DecimalCheckBox.Checked then
      SaveBMP(tilesPath + '\' + rightstr('000' + inttostr(i) ,4) + eBMP, bmp);
    if AttrCheckBox.Checked then
    begin
      attrFullPath := attrPath + '\' + IntToBin(attr);
      CreateDir(attrFullPath);
      SaveBMP(attrFullPath + '\' + rightstr('000' + inttostr(i) ,4) + eBMP, bmp);
    end;
    if HexCheckBox.Checked then
      SaveBMP(hexPath + '\' + inttohex(i,4) + eBMP,bmp);
    TilesProgressBar.Position := i;
    TilesProgressLabel.Caption := Format('%.2f %%', [((i + 1) / DTA.tilesCount) * 100]);
    Application.ProcessMessages;
  end;
  Log.Debug('OK');
end;


procedure TMainForm.SaveMapsButtonClick(Sender: TObject);
var i: Word;
begin
  CreateDir(opath);
  if MapSaveCheckBox.Checked then CreateDir(opath + 'Maps');
  if MapFlagSaveCheckBox.Checked then CreateDir(opath + 'MapsByFlags');
  if MapPlanetSaveCheckBox.Checked then CreateDir(opath + 'MapsByPlanetType');
  if ActionsCheckBox.Checked then
  begin
    CreateDir(opath + 'IZAX');
    CreateDir(opath + 'IZX2');
    CreateDir(opath + 'IZX3');
    CreateDir(opath + 'IZX4');
    CreateDir(opath + 'IACT');
  end;

  bmp.PixelFormat := pf8bit;
  bmp.Width := TileSize;
  bmp.Height := TileSize;
  FillInternalPalette(BMP, $FF, 0, $FF);

  MapProgressBar.Position := 0;
  MapProgressBar.Max := DTA.mapsCount;

  Log.Clear;
  Log.Debug('Maps (zones):');
  Log.Debug('');
  Log.Debug('Total count: ' + IntToStr(DTA.mapsCount));
  Log.Debug('');
  //DTA.SetIndex(knownSections[5]);          // ZONE
  for i:=0 to DTA.mapsCount - 1 do ReadIZON(i);
end;

procedure TMainForm.ReadIZON(id: Word);
var s: String;
size: Longword;
k, w, h, p, i, j, flag, planet: Word;
begin
  DTA.SetIndex(TMap(DTA.maps.Objects[id]).mapOffset);   // go to map data
  pn := DTA.ReadWord;               // number:word; //2 bytes - serial number of the map starting with 0
  if pn <> id then ShowMessage(IntToStr(pn) + ' <> ' + IntToStr(id));
  DTA.ReadString(4);                // izon:string[4]; //4 bytes: "IZON"
  size := DTA.ReadLongWord;         // longword; //4 bytes - size of block IZON (include 'IZON') until object info entry count

  Application.ProcessMessages;

  w := DTA.ReadWord;                // width:word; //2 bytes: map width (W)
  h := DTA.ReadWord;                // height:word; //2 bytes: map height (H)
  flag := DTA.ReadWord;             // flags:word; //2 byte: map flags (unknown meanings)* добавил байт снизу
  DTA.ReadLongWord;                 // unused:longword; //5 bytes: unused (same values for every map)
  planet := DTA.ReadWord;           // planet:word; //1 byte: planet (0x01 = desert, 0x02 = snow, 0x03 = forest, 0x05 = swamp)* добавил следующий байт
  Image1.Width := w * 32;
  Image1.Height := h * 32;
  Image1.Picture.Bitmap.Width := w * 32;
  Image1.Picture.Bitmap.Height := h * 32;

  image1.Picture.bitmap.Canvas.Pen.Color := 0;
  image1.Picture.bitmap.Canvas.Brush.Color := 0;
  image1.picture.Bitmap.canvas.Rectangle(0, 0, image1.picture.bitmap.width, image1.picture.bitmap.height);
  Log.Debug('Map #' + inttostr(pn) + ' offset: ' + inttohex(DTA.GetIndex, 8));
  for i:=0 to h-1 do
  begin
    for j:=0 to w-1 do
    begin          //W*H*6 bytes: map data
      k := DTA.ReadWord;
      if k <> $FFFF then
      begin
        GetTile(dta, k, bmp);
        CopyFrame(Image1, j * 32, i * 32);
      end;
      k := DTA.ReadWord;
      if k <> $FFFF then
      begin
        GetTile(dta, k, bmp);
        CopyFrame(Image1, j * 32, i * 32);
      end;
      k := DTA.ReadWord;
      if k <> $FFFF then
      begin
        GetTile(dta, k, bmp);
        CopyFrame(Image1, j * 32, i * 32);
      end;
    end;
    Application.ProcessMessages;
    if MapSaveCheckBox.Checked then
      Image1.Picture.SaveToFile(opath + 'Maps\' + rightstr('000' + inttostr(pn), 3) + '.bmp');
    if MapFlagSaveCheckBox.Checked then
    begin
      s := opath + 'MapsByFlags\' + IntToBin(flag);
      CreateDir(s);
      Image1.Picture.SaveToFile(s + '\' + rightstr('000' + inttostr(pn), 3) + '.bmp');
    end;
    if MapPlanetSaveCheckBox.Checked then
    begin
      s := opath + 'MapsByPlanetType\' + planets[planet];
      CreateDir(s);
      Image1.Picture.SaveToFile(s + '\' + rightstr('000' + inttostr(pn), 3) + '.bmp');
    end;


    MapProgressBar.Position := id;
    MapProgressLabel.Caption := Format('%.2f %%', [((id + 1)/ DTA.mapsCount) * 100]);
    Application.ProcessMessages;
  end;
  //k:=DTA.ReadWord;                             //2 bytes: object info entry count (X)
  //DTA.MoveIndex(k * 12);                       //X*12 bytes: object info data

  if ActionsCheckBox.Checked then
  begin
   //ReadOIE(id);
   ReadIZAX(id);
   ReadIZX2(id);
   ReadIZX3(id);
   ReadIZX4(id);
   ReadIACT(id);
  end;
end;


procedure TMainForm.DumpData(fileName: String; offset, size: Cardinal);
var f: File of Byte;
i: Cardinal;
b: Byte;
begin
  DTA.SetIndex(offset);
  AssignFile(f, fileName);
  Rewrite(f);
  for i := 0 to size - 1 do
  begin
    b := DTA.ReadByte;
    Write(f, b);
    //DTA.MoveIndex(1);
  end;
  CloseFile(f);
end;

procedure TMainForm.ReadOIE(id: Word);
begin
  DumpData(opath + 'OIE\' + IntToStr(id), TMap(DTA.maps.Objects[id]).oieOffset, TMap(DTA.maps.Objects[id]).oieSize);
end;

procedure TMainForm.ReadIZAX(id: Word);
begin
  DumpData(opath + 'IZAX\' + IntToStr(id), TMap(DTA.maps.Objects[id]).izaxOffset, TMap(DTA.maps.Objects[id]).izaxSize);
end;

procedure TMainForm.ReadIZX2(id: Word);
begin
  DumpData(opath + 'IZX2\' + IntToStr(id), TMap(DTA.maps.Objects[id]).izx2Offset, TMap(DTA.maps.Objects[id]).izx2Size);
end;

procedure TMainForm.ReadIZX3(id: Word);
begin
  DumpData(opath + 'IZX3\' + IntToStr(id), TMap(DTA.maps.Objects[id]).izx3Offset, TMap(DTA.maps.Objects[id]).izx3Size);
end;

procedure TMainForm.ReadIZX4;
begin
  DumpData(opath + 'IZX4\' + IntToStr(id), TMap(DTA.maps.Objects[id]).izx4Offset, TMap(DTA.maps.Objects[id]).izx4Size);
end;

procedure TMainForm.ReadIACT(id: Word);
label l1, l2;
var s: String;
size, idx: Longword;
k: Integer;
begin
  k := 0;
  DTA.SetIndex(TMap(DTA.maps.Objects[id]).iactOffset);
l1:
  if DTA.ReadString(4) <> 'IACT' then goto l2;
  inc(k);
  size := DTA.ReadLongWord;  //4 bytes: length (X)
  DumpData(opath + 'IACT\' + rightstr('000' + inttostr(id), 3) + '-'+rightstr('00'+inttostr(k),2), DTA.GetIndex, size);
  goto l1;
l2:
  //seek(SrcFile,filepos(SrcFile)-4);
//  showmessage(inttohex(filepos(SrcFile),4));
//  showmessage('IACTs all');
end;

end.
