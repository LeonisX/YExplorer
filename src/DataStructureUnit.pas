unit DataStructureUnit;

interface

uses classes, dialogs, sysutils, CRCUnit, LoggerUnit, Forms;

const
  knownSections: Array[1..12] of string[4]=('VERS','STUP','SNDS','TILE','ZONE','PUZ2','CHAR','CHWP','CAUX','TNAM','TGEN','ENDF');
                      //                       1      2      3      4      5      6     7      8      9       10    11     12
type
  TSectionMetricks = class
    public
    size: integer;
    fullSize: integer;
    offset: integer;
    constructor Create(size, offset: integer);
  end;

  TSection = class
  private
    sections: TStringList;
    dta: array of byte;
    index: integer;
    crcs: TStringList;
  public
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
    procedure Add(section: String; size, offset: integer);
    function GetOffset(section: String): integer;
    function GetSize(section: String): integer;
    function GetFullSize(section: String): integer;
    function Have(section: String): boolean;

    procedure ReadDTAMetricks(fileName: String);
    procedure LoadFileToArray(fileName: String);

    procedure SetIndex(offset: integer); overload;
    procedure SetIndex(section: String); overload;
    procedure MoveIndex(offset: integer);

    function ReadString(size:integer): string;
    function ReadByte: byte;
    //так как следующие данные по 2-4 байта, надо по необходимости преобразовывать их
    //в читабельный вариант
    function ReadWord: word;
    function ReadLongWord: Longword;
    function ReadRWord: word;  //читает обратный порядок, little-endian, преобразует в нормальное число
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
    function ChunkIndex(s:string):byte;
    function InBound(section: String): boolean;
  end;

  var DTA: TSection;

implementation

constructor TSectionMetricks.Create(size, offset: integer);
begin
  Self.size := size;
  Self.offset := offset;
  Self.fullSize := size + 4;
end;

procedure TSection.Clear;
var i: byte;
begin
  if sections.count > 0 then
        for i := 0 to sections.Count - 1 do sections.Objects[i].Free;
  sections.Clear;
end;

procedure TSection.Add(section: String; size, offset: integer);
begin
  sections.AddObject(section, TSectionMetricks.Create(size, offset))
end;

function TSection.GetOffset(section: String): integer;
begin
  result := TSectionMetricks(sections.Objects[sections.IndexOf(section)]).offset;
end;

function TSection.GetSize(section: String): integer;
begin
  result := TSectionMetricks(sections.Objects[sections.IndexOf(section)]).size;
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
  sections:=TStringList.Create;
  index:=0;
  crcs := TStringList.Create;
  crcs.LoadFromFile('./conf/crcs.cfg');
end;

destructor TSection.Destroy;
begin
  Clear;
  sections.free;
  crcs.Free;
  dta := nil;
end;


function TSection.InBound(section: String): boolean;
begin
 result := index + 4 < getOffset(section) + getSize(section)
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
         Add(s, 4, index);
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
  Log.Debug(Format('%-7s%14s%10s', ['Section', 'Offset (hex)', 'Size']));
  for i := 0 to sections.Count - 1 do
    begin
    k := TSectionMetricks(sections.Objects[i]).offset - 8;
    if k < 0 then k := 0;
     Log.Debug(Format('%7s%14x%10d',
       [sections[i], k, TSectionMetricks(sections.Objects[i]).fullSize]));
    end;
end;

procedure TSection.ScanTGEN(sectionName: String);
var sz: Longword;
begin
  sz := ReadLongWord;            //4 байта - длина блока TGEN
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  Log.Debug(sectionName + ' - what is it?...');
end;

// 246 * 26 + size(4) + 'TNAM' + $FFFF = 6406
procedure TSection.ScanTNAM(sectionName: String);
var k: Word;
s: String;
sz: Longword;
count: Byte;
begin
  sz := ReadLongWord;           //4 bytes - length of section TNAM
  Add(sectionName, 4 + sz, index);
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
  Add(sectionName, 4 + sz, index);
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
  Add(sectionName, 4 + sz, index);
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
  Add(sectionName, 4 + sz, index);
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
  Add(sectionName, 4 + sz, index);
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
s: String;
ind: Integer;
begin
  //Signature: String[4];       // 4 bytes: "ZONE" - уже прочитано
  ind := index;
  mapsCount := ReadWord;        // 2 bytes - maps count $0291=657 штук
  //дальше повторяющиеся данные структуры TZone
  for i:=1 to mapsCount do
    begin
      ReadWord;                //unknown:word;          01 00 - unknown 2 bytes
      sz:=ReadLongWord;        //size:longword;         size of current map (4b)
      MoveIndex(sz);
    end;
  Add(sectionName, 4 + index - ind, ind);
  Log.Debug('Maps (zones): ' + IntToStr(mapsCount));
end;

procedure TSection.ScanTILE(sectionName: String);
var k, sz, i, n: Cardinal;
begin
  sz:=ReadLongWord;             //4 bytes - length of section TILE
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  tilesCount := sz div $404;
  Log.debug('Sprites, tiles: ' + IntToStr(tilesCount));
end;


procedure TSection.ScanSNDS(sectionName: String);
var sz, msz: Word;
begin
  sz:=ReadLongWord;             //4 bytes - length of section SNDS
  Add(sectionName, 4 + sz, index);
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
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  Log.Debug('Title screen: exists');
end;

procedure TSection.ScanVERS(sectionName: String);
begin
  Add(sectionName, 4 + 0, index);
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

procedure TSection.SetIndex(offset: integer);
begin
 index := offset;
end;

procedure TSection.SetIndex(section: String);
begin
 index := GetOffset(section);
end;


procedure TSection.MoveIndex(offset: integer);
begin
 index := index + offset;
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

  DTA.Free;

end.
