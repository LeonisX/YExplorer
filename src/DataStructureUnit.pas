unit DataStructureUnit;

interface

uses classes, dialogs, sysutils, CRCUnit, LoggerUnit, Forms, Graphics;

const
  knownSections: Array[1..12] of String[4] = ('VERS','STUP','SNDS','TILE','ZONE','PUZ2','CHAR','CHWP','CAUX','TNAM','TGEN','ENDF');
                       //                       1      2      3      4      5      6     7      8      9       10    11     12
  planets: Array[1..5] of String = ('desert', 'snow', 'forest', 'unknown', 'swamp');

type
  TSectionMetricks = class
    public
    dataSize: Cardinal;
    fullSize: Cardinal;
    startOffset: Cardinal;
    dataOffset: Cardinal;
    constructor Create(dataSize, fullSize, dataOffset, startOffset: Cardinal);
  end;

  TMap = class
    public
    mapOffset, izonOffset, izaxOffset, izx2Offset, izx3Offset, izx4Offset, iactOffset: Cardinal;
    mapSize, izonSize, izaxSize, izx2Size, izx3Size, izx4Size, iactSize, oieOffset, oieSize, oieCount: Cardinal;
    constructor Create;
  end;

  TSection = class
  private
    index: Cardinal;
    crcs: TStringList;
  public
    sections: TStringList;
    dta: array of Byte;
    maps: TStringList;
    size: Cardinal;
    crc32: String;
    dtaRevision: String;
    version: String;
    soundsCount: Byte;
    tilesCount: Integer;
    mapsCount: Integer;
    puzzlesCount: Integer;
    charsCount: Integer;
    namesCount: Integer;
    procedure Clear;

    procedure AddMap(id: Word);

    procedure Add(section: String; dataSize, fullSize, dataOffset, startOffset: Cardinal);
    function GetStartOffset(section: String): Integer;
    function GetDataOffset(section: String): Integer;
    function GetDataSize(section: String): Integer;
    function GetFullSize(section: String): Integer;
    function Have(section: String): Boolean;

    procedure ReadDTAMetricks(fileName: String);
    procedure LoadFileToArray(fileName: String);

    procedure SetIndex(offset: Cardinal); overload;
    procedure SetIndex(section: String); overload;
    procedure MoveIndex(offset: Integer);
    function GetIndex: Cardinal;

    function ReadString(size: Integer): String;
    function ReadByte: Byte;
    //так как следующие данные по 2-4 байта, надо по необходимости преобразовывать их
    //в читабельный вариант
    function ReadWord: Word;
    function ReadLongWord: Longword;
    function ReadRWord: Word;  //читает обратный порядок, little-endian, преобразует в нормальное число
    function ReadRLongWord: Longword; //читает обратный порядок, little-endian, преобразует в нормальное число

    constructor Create;
    destructor Destroy; override;

    procedure ScanVERS(sectionName: String);
    procedure ScanSTUP(sectionName: String);
    procedure ScanSNDS(sectionName: String);
    procedure ScanTILE(sectionName: String);
    procedure ScanZONE(sectionName: String);
    procedure ScanPUZ2(sectionName: String);
    procedure ScanCHAR(sectionName: String);
    procedure ScanCHWP(sectionName: String);
    procedure ScanCAUX(sectionName: String);
    procedure ScanTNAM(sectionName: String);
    procedure ScanTGEN(sectionName: String);

    procedure ScanIZON(id: Word);
    procedure ScanIZAX(id: Word);
    procedure ScanIZX2(id: Word);
    procedure ScanIZX3(id: Word);
    procedure ScanIZX4(id: Word);
    procedure ScanIACT(id: Word);

    function ChunkIndex(s: String): Byte;
    function InBound(section: String): Boolean;
  end;

  var DTA: TSection;

implementation

constructor TMap.Create;
begin
  mapOffset := 0;
  izonOffset := 0;
  izaxOffset := 0;
  izx2Offset := 0;
  izx3Offset := 0;
  izx4Offset := 0;
  iactOffset := 0;
  mapSize := 0;
  izonSize := 0;
  izaxSize := 0;
  izx2Size := 0;
  izx3Size := 0;
  izx4Size := 0;
  iactSize := 0;
  oieOffset := 0;
  oieCount := 0;
end;


constructor TSectionMetricks.Create(dataSize, fullSize, dataOffset, startOffset: Cardinal);
begin
  Self.dataSize := dataSize;
  Self.fullSize := fullSize;
  Self.startOffset := startOffset;
  Self.dataOffset := dataOffset;
end;

procedure TSection.Clear;
var i: Word;
begin
  if sections.Count > 0 then
        for i := 0 to sections.Count - 1 do sections.Objects[i].Free;
  sections.Clear;
  if maps.Count > 0 then
        for i := 0 to maps.Count - 1 do maps.Objects[i].Free;
  maps.Clear;
end;

procedure TSection.AddMap(id: Word);
begin
  maps.AddObject(IntToStr(id), TMap.Create);
end;

procedure TSection.Add(section: String; dataSize, fullSize, dataOffset, startOffset: Cardinal);
begin
  sections.AddObject(section, TSectionMetricks.Create(dataSize, fullSize, dataOffset, startOffset))
end;

function TSection.GetStartOffset(section: String): integer;
begin
  result := TSectionMetricks(sections.Objects[sections.IndexOf(section)]).startOffset;
end;

function TSection.GetDataOffset(section: String): integer;
begin
  result := TSectionMetricks(sections.Objects[sections.IndexOf(section)]).dataOffset;
end;

function TSection.GetDataSize(section: String): integer;
begin
  result := TSectionMetricks(sections.Objects[sections.IndexOf(section)]).dataSize;
end;

function TSection.GetFullSize(section: String): integer;
begin
  result := TSectionMetricks(sections.Objects[sections.IndexOf(section)]).fullSize;
end;

function TSection.Have(section: String): boolean;
begin
  result := sections.IndexOf(section) <> -1;
end;


constructor TSection.Create;
begin
  sections := TStringList.Create;
  maps := TStringList.Create;
  index := 0;
  crcs := TStringList.Create;
  crcs.LoadFromFile('./conf/crcs.cfg');
end;

destructor TSection.Destroy;
begin
  Clear;
  sections.Free;
  maps.Free;
  crcs.Free;
  dta := nil;
end;


function TSection.InBound(section: String): boolean;
begin
 result := index < getDataOffset(section) + getDataSize(section)
end;


function TSection.ChunkIndex(s:string):byte;
var i: byte;
begin
 result:=0;
 for i:=1 to sizeof(knownSections) do
 if knownSections[i]=s then result:=i;
end;

procedure TSection.readDTAMetricks(fileName: String);
var keepReading:boolean;
s: String;
i, k: Integer;
begin
  Log.Debug('DTA file internal structure');
  Log.Debug('===========================');
  Log.NewLine;
  LoadFileToArray(fileName);
  Log.NewLine;

  Log.Debug('Sections:');
  Log.Debug('---------');
  Log.NewLine;
  keepReading:=true;
  while (keepReading) do
    begin
      Application.ProcessMessages;
      s := ReadString(4);
      //Log.debug(s);
      case ChunkIndex(s) of
       1: ScanVERS(s); //версия файла
       2: ScanSTUP(s); //чтение титульной картинки
       3: ScanSNDS(s); //SNDS, 4 байта размер блока, C0FF, размер названия сэмпла+$0, размер названия сэмпла+$0,... пока не надо
       4: ScanTILE(s); //тайлы
       5: ScanZONE(s); //локации
       6: ScanPUZ2(s); //ещё диалоги
       7: ScanCHAR(s); //персонажи?
       8: ScanCHWP(s); //персонажи?????
       9: ScanCAUX(s); //персонажи?????
       10: ScanTNAM(s); //названия+тайлы
       11: ScanTGEN(s); //встречается в германском образе. Что такое - не знаю.
       12: begin
         Add(s, 4, 8, index, index - 4);
         keepReading:=false;
         end;
      else
       begin
        showmessage('Неизвестная секция: ' + s);
        keepReading:=false;
       end;
      end;
  end;
  Log.NewLine;
  Log.Debug('Sections detailed:');
  Log.Debug('------------------');
  Log.NewLine;
  Log.Debug(Format('%7s %12s %11s %12s %11s', ['Section', 'Data offset', 'Data size', 'Start offset', 'Full size']));
  for i := 0 to sections.Count - 1 do
    begin
    if k < 0 then k := 0;
     Log.Debug(Format('%7s %12x %11d %12x %11d',
       [sections[i],
        TSectionMetricks(sections.Objects[i]).dataOffset,
        TSectionMetricks(sections.Objects[i]).dataSize,
        TSectionMetricks(sections.Objects[i]).startOffset,
        TSectionMetricks(sections.Objects[i]).fullSize
       ]));
    end;

  Log.NewLine;
  Log.Debug('Maps offsets, sizes detailed:');
  Log.Debug('------------------');
  Log.NewLine;
  Log.Debug(Format('%3s %-13s %-13s  %-16s  %-13s  %-13s  %-13s  %-13s  %-13s', ['#', 'MAP', 'IZON', 'OIE', 'IZAX', 'ISX2', 'IZX3', 'IZX4', 'IACT']));
  for i := 0 to maps.Count - 1 do
    Log.Debug(Format('%3d %-13s %-13s  %-16s  %-13s  %-13s  %-13s  %-13s  %-13s', [ i,
      IntToHex(TMap(maps.Objects[i]).mapOffset, 8) + ':' + IntToHex(TMap(maps.Objects[i]).mapSize, 4),
      IntToHex(TMap(maps.Objects[i]).izonOffset, 8) + ':' + IntToHex(TMap(maps.Objects[i]).izonSize, 4),
      IntToHex(TMap(maps.Objects[i]).oieOffset, 8) + ':' + IntToHex(TMap(maps.Objects[i]).oieSize, 4) + ':' + IntToHex(TMap(maps.Objects[i]).oieCount, 2),
      IntToHex(TMap(maps.Objects[i]).izaxOffset, 8) + ':' + IntToHex(TMap(maps.Objects[i]).izaxSize, 4),
      IntToHex(TMap(maps.Objects[i]).izx2Offset, 8) + ':' + IntToHex(TMap(maps.Objects[i]).izx2Size, 4),
      IntToHex(TMap(maps.Objects[i]).izx3Offset, 8) + ':' + IntToHex(TMap(maps.Objects[i]).izx3Size, 4),
      IntToHex(TMap(maps.Objects[i]).izx4Offset, 8) + ':' + IntToHex(TMap(maps.Objects[i]).izx4Size, 4),
      IntToHex(TMap(maps.Objects[i]).iactOffset, 8) + ':' + IntToHex(TMap(maps.Objects[i]).iactSize, 4)
      ]));
end;

procedure TSection.ScanTGEN(sectionName: String);
var sz: Longword;
begin
  sz := ReadLongWord;            //4 байта - длина блока TGEN
  //Add(sectionName, 4 + sz, index);
  Add(sectionName, sz, sz + 4 + 4, index, index - 4 - 4);
  MoveIndex(sz);
  Log.Debug(sectionName + ' - what is it?...');
end;

// 246 * 26 + size(4) + 'TNAM' + $FFFF = 6406
procedure TSection.ScanTNAM(sectionName: String);
var k: Word;
sz: Longword;
count: Byte;
begin
  sz := ReadLongWord;           //4 bytes - length of section TNAM
  Add(sectionName, sz, sz + 4 + 4, index, index - 4 - 4);
  //MoveIndex(sz);
  count := 0;
  while InBound(sectionName) do
  begin
    k := ReadWord;              //2 байта - номер персонажа (тайла)
    if k = $FFFF then Break;
    ReadString(24);             //24 bytes - rest of current name length
    inc(count);
  end;
  Log.Debug(sectionName + ': ' + InttoStr(count));
end;

// 77 * 4 = 308 + size(4) + 'CAUX' + FFFF = 318
procedure TSection.ScanCAUX(sectionName: String);
var sz: Longword;
count: Byte;
begin
  sz := ReadLongWord;           //4 bytes - length of section CAUX
  Add(sectionName, sz, sz + 4 + 4, index, index - 4 - 4);
  MoveIndex(sz);
  count := (sz - 2) div 4;
  Log.Debug(sectionName + ': ' + inttostr(count));
end;

// 77 * 6 = 462 + size(4) + 'CHWP' + FFFF = 472
procedure TSection.ScanCHWP(sectionName: String);
var sz: Longword;
count: Byte;
begin
  sz := ReadLongWord;           //4 bytes - length of section CHWP
  Add(sectionName, sz, sz + 4 + 4, index, index - 4 - 4);
  MoveIndex(sz);
    count := (sz - 2) div 6;
  Log.Debug(sectionName + ': ' + inttostr(count));
end;

// 78 Characters
procedure TSection.ScanCHAR(sectionName: String);
var sz, csz: Longword;
ch: Word;
begin
  sz := ReadLongWord;           //4 bytes - length of section CHAR
  Add(sectionName, sz, sz + 4 + 4, index, index - 4 - 4);
  charsCount := 0;
  while InBound(sectionName) do
   begin
    ch := ReadWord;             //2 bytes - index of character
    if ch = $FFFF then Break;
    ReadString(4);              //4 bytes - 'ICHA'
    csz := ReadLongWord;        //4 bytes - rest of current character length
    ReadString(csz);
    inc(charsCount);
   end;
  Log.Debug('Characters: ' + IntToStr(charsCount));
end;

procedure TSection.ScanPUZ2(sectionName: String);
var sz, psz: Longword;
pz: Word;
begin
  sz := ReadLongWord;           //4 bytes - length of section PUZ2
  Add(sectionName, sz, sz + 4 + 4, index, index - 4 - 4);
  puzzlesCount := 0;
  while InBound(sectionName) do
   begin
    pz := ReadWord;             //2 bytes - index of puzzle (from 0)
    if pz = $FFFF then Break;
    ReadString(4);              //4 bytes - 'IPUZ'
    psz := ReadLongWord;        //4 bytes - rest of current puzzle length
    ReadString(psz);
    inc(puzzlesCount)
   end;
  Log.Debug('Puzzles: ' + IntToStr(puzzlesCount));
end;

procedure TSection.ScanZONE(sectionName: String);
var sz: Longword;
i: Word;
ind: Integer;
begin
  //Signature: String[4];       // 4 bytes: "ZONE" - уже прочитано
  ind := index;
  mapsCount := ReadWord;        // 2 bytes - maps count $0291 = 657 items
  // Next repeated data of TZone
  for i:=1 to mapsCount do
    begin
      ReadWord;                //unknown:word;          01 00 - unknown 2 bytes
      sz:=ReadLongWord;        //size:longword;         size of current map (4b)
      MoveIndex(sz);
    end;
  //Add(sectionName, 4 + index - ind, ind);
  Add(sectionName, index - ind, index - ind + 4, ind, ind - 4);
  Log.Debug('Maps (zones): ' + IntToStr(mapsCount));
  //Log.NewLine;

  SetIndex(knownSections[5]);   // ZONE
  ReadWord;                     // 2 bytes - maps count $0291 = 657 items

  for i := 0 to mapsCount - 1 do ScanIZON(i);
  //Log.NewLine;
end;

procedure TSection.ScanIZON(id: Word);
var sz,  pn, w, h, oieCount: Word;
  size, unk2: Longword;
begin
  // Repeated data of TZone
  AddMap(id);
  ReadWord;                     // unknown:word; //01 00
  sz := ReadLongWord;           // size:longword; size of the current map
  TMap(maps.Objects[id]).mapOffset := index;
  TMap(maps.Objects[id]).mapSize := sz + 6;
  pn := ReadWord;               // number:word; //2 bytes - serial number of the map starting with 0
  if pn <> id then ShowMessage(IntToStr(pn) + ' <> ' + IntToStr(id));
  ReadString(4);                // izon:string[4]; //4 bytes: "IZON"
  size := ReadLongWord;         // longword; //4 bytes - size of block IZON (include 'IZON') until object info entry count
  TMap(maps.Objects[id]).izonOffset := index;
  TMap(maps.Objects[id]).izonSize := size - 6;
  Application.ProcessMessages;

  w := ReadWord;                // width:word; //2 bytes: map width (W)
  h := ReadWord;                // height:word; //2 bytes: map height (H)
  ReadWord;                     // flags:word; //2 byte: map flags (unknown meanings)* добавил байт снизу
  unk2 := ReadLongWord;         // unused:longword; //5 bytes: unused (same values for every map)
  ReadWord;                     // planet:word; //1 byte: planet (0x01 = desert, 0x02 = snow, 0x03 = forest, 0x05 = swamp)* добавил следующий байт

  //Log.Debug('Map #' + IntToStr(pn) + ': ' + planets[p] + ' (' + IntToStr(w) + 'x' + IntToStr(h) + ')');
  //Log.Debug('Flags: ' + IntToStr(flags) + '; unknown value: $' + IntToHex(unk, 4));
  if unk2 <> $FFFF0000 then ShowMessage(IntToHex(unk2, 8));

  MoveIndex(w * h * 6);

  oieCount := ReadWord;         //2 bytes: object info entry count (X)
  TMap(maps.Objects[id]).oieOffset := index;
  TMap(maps.Objects[id]).oieCount := oieCount;
  TMap(maps.Objects[id]).oieSize := oieCount * 12;
  MoveIndex(oieCount * 12);     //X*12 bytes: object info data

  //Log.Debug('Object info entries count: ' + IntToStr(oieCount));

  ScanIZAX(id);
  ScanIZX2(id);
  ScanIZX3(id);
  ScanIZX4(id);
  ScanIACT(id);
end;

procedure TSection.ScanIZAX(id: Word);
var size: Longword;
begin
  ReadString(4);                //4 bytes: "IZAX"
  size := ReadLongWord;         //4 bytes: length (X)
  TMap(maps.Objects[id]).izaxOffset := index;
  TMap(maps.Objects[id]).izaxSize := size - 8;
  MoveIndex(size - 8);          //X-8 bytes: IZAX data
end;

procedure TSection.ScanIZX2(id: Word);
var size: Longword;
begin
  ReadString(4);                //4 bytes: "IZX2"
  size := ReadLongWord;         //4 bytes: length (X)
  TMap(maps.Objects[id]).izx2Offset := index;
  TMap(maps.Objects[id]).izx2Size := size - 8;
  MoveIndex(size - 8);          //X-8 bytes: IZX2 data
end;

procedure TSection.ScanIZX3(id: Word);
var size: Longword;
begin
  ReadString(4);                //4 bytes: "IZX3"
  size := ReadLongWord;         //4 bytes: length (X)
  TMap(maps.Objects[id]).izx3Offset := index;
  TMap(maps.Objects[id]).izx3Size := size - 8;
  MoveIndex(size - 8);          //X-8 bytes: IZX3 data
end;

procedure TSection.ScanIZX4(id: Word);
begin
  ReadString(4);                //4 bytes: "IZX4"
  TMap(maps.Objects[id]).izx4Offset := index;
  TMap(maps.Objects[id]).izx4Size := 8;
  MoveIndex(8);          //8 bytes: IZX4 data
end;

procedure TSection.ScanIACT(id: Word);
label l1, l2;
var title: String;
size, idx: Longword;
begin
  idx := index;
  TMap(maps.Objects[id]).iactOffset := index;
  //TMap(maps.Objects[id]).iactSize := size - 6;
l1:
  title := ReadString(4); //4 bytes: "IACT"
  if title <> 'IACT' then goto l2;
  size := ReadLongWord;   //4 bytes: length (X)
  //Log.Debug(title + ' ' + inttohex(size, 4));
  MoveIndex(size);
  goto l1;
l2:
  MoveIndex(-4);
  TMap(maps.Objects[id]).iactSize := index - idx;
end;


procedure TSection.ScanTILE(sectionName: String);
var sz: Cardinal;
begin
  sz:=ReadLongWord;             //4 bytes - length of section TILE
  Add(sectionName, sz, sz + 4 + 4, index, index - 4 - 4);
  MoveIndex(sz);
  tilesCount := sz div $404;
  Log.debug('Sprites, tiles: ' + IntToStr(tilesCount));
end;


procedure TSection.ScanSNDS(sectionName: String);
var sz, msz: Word;
begin
  sz:=ReadLongWord;             //4 bytes - length of section SNDS
  Add(sectionName, sz, sz + 4 + 4, index, index - 4 - 4);
  soundsCount := 0;
  ReadWord;
  while InBound(knownSections[3]) do
   begin
    msz := ReadWord;
    ReadString(msz);
    inc(soundsCount);
   end;
  Log.Debug('Sounds, melodies: ' + IntToStr(soundsCount));
end;

procedure TSection.ScanSTUP(sectionName: String);
var sz: Longword;
begin
  sz:=ReadLongWord;             //4 bytes - length of section STUP
  Add(sectionName, sz, sz + 4 + 4, index, index - 4 - 4);
  MoveIndex(sz);
  Log.Debug('Title screen: exists');
end;

procedure TSection.ScanVERS(sectionName: String);
begin
  Add(sectionName, 4, 4 + 4, index, index - 4);
  version := inttostr(ReadRWord)+'.'+inttostr(ReadRWord);
  Log.Debug('File version: ' + version);
end;


procedure TSection.LoadFileToArray(fileName: String);
var FS: TFileStream;
begin
  crc32 := IntToHex(GetFileCRC(fileName), 8);
  if crcs.IndexOfName(crc32) = -1
    then dtaRevision := 'Unknown'
    else dtaRevision := crcs.Values[crc32];

  dta := nil;
  //Clear;
  FS := TFileStream.Create(fileName, fmOpenRead);
  try
    size := FS.size;
    if size > 0 then
      begin
        SetLength(dta, FS.Size);
        FS.ReadBuffer(Pointer(dta)^, FS.Size);
      end;
  finally
     FreeAndNil(FS);
  end;
  Log.debug('Size: ' + inttostr(size));
  Log.debug('CRC-32: ' + crc32);
  Log.debug('DTA revision: ' + dtaRevision);
  index:=0;
end;

procedure TSection.SetIndex(offset: Cardinal);
begin
 index := offset;
end;

procedure TSection.SetIndex(section: String);
begin
 index := GetDataOffset(section);
end;

procedure TSection.MoveIndex(offset: integer);
begin
 index := index + offset;
end;

function TSection.GetIndex: Cardinal;
begin
  result := index;
end;


function TSection.ReadByte: byte;
begin
  result:=dta[index];
  MoveIndex(1);
end;

function TSection.ReadWord:word;
begin
  result := dta[index] + dta[index + 1] * 256;
  MoveIndex(2);
end;

function TSection.ReadLongWord:longword;
begin
  result := dta[index] + dta[index + 1] * 256 + dta[index + 2] * 65536 + dta[index + 3] * 16777216;
  MoveIndex(4);
end;

function TSection.ReadRWord:word;
begin
  result := dta[index + 1] + dta[index] * 256;
  MoveIndex(2);
end;

function TSection.ReadRLongWord:longword;
begin
  result := dta[index + 3] + dta[index + 2] * 256 + dta[index + 1] * 65536 + dta[index] * 16777216;
  MoveIndex(4);
end;

function TSection.ReadString(size: integer):string;
var i:integer;
begin
  result := '';
  for i := 0 to size - 1 do result := result + chr(dta[index + i]);
  MoveIndex(size);
end;

initialization

  DTA := TSection.Create;

finalization

  DTA.Clear;
  DTA.Free;

end.
