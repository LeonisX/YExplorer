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
    crc32: String;
    dtaRevision: String;
    procedure Clear;
    procedure Add(section: String; size, offset: integer);
    function GetOffset(section: String): integer;
    function GetSize(section: String): integer;
    function GetFullSize(section: String): integer;
    function Have(section: String): boolean;

    procedure readDTAMetricks(fileName: String);
    procedure loadFileToArray(fileName: String);

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
    destructor Destroy;

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
    function inBound(section: String): boolean;
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


function TSection.inBound(section: String): boolean;
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
i: byte;
begin
  loadFileToArray(fileName);

  keepReading:=true;
  while (keepReading) do
    begin
      Application.ProcessMessages;
      s := ReadString(4);
      Log.debug(s);
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
  for i := 0 to sections.Count - 1 do
    begin
     Log.Debug(sections[i] + '  offset: ' + inttostr(TSectionMetricks(sections.Objects[i]).offset)
     + ' fullSize: ' + inttostr(TSectionMetricks(sections.Objects[i]).fullSize));
    end;
  log.debug('всё...');
end;


procedure TSection.ScanTGEN(sectionName: String);
var sz: longword;
begin
  sz:=ReadLongWord;
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  LOG.debug(sectionName + ': ' + inttohex(sz,4)); //4 байта - длина блока TGEN
end;

procedure TSection.ScanTNAM(sectionName: String);
var
k:word;
s:string;
sz:longword;
begin
  sz:=ReadLongWord;
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  LOG.debug(sectionName + ': ' + inttohex(sz,4)); //4 байта - длина блока TNAM
end;

procedure TSection.ScanCAUX(sectionName: String);
var sz:longword;
begin
  sz:=ReadLongWord;
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  LOG.debug(sectionName + ': ' + inttohex(sz,4)); //4 байта - длина блока CAUX
end;

procedure TSection.ScanCHWP(sectionName: String);
var sz:longword;
begin
  sz:=ReadLongWord;
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  LOG.debug(sectionName + ': ' + inttohex(sz,4)); //4 байта - длина блока CHWP
end;

procedure TSection.ScanCHAR(sectionName: String);
var sz:longword;
begin
  sz:=ReadLongWord;
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  LOG.debug(sectionName + ': ' + inttohex(sz,4)); //4 байта - длина блока CHAR
end;

procedure TSection.ScanPUZ2(sectionName: String);
var sz:longword;
begin
  sz:=ReadLongWord;
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  LOG.debug(sectionName + ': ' + inttohex(sz,4)); //4 байта - длина блока PUZ2
end;

procedure TSection.ScanZONE(sectionName: String);
var sz:longword;
k,i:word;
s:string;
ind: Integer;
begin
  //Signature: String[4];       // 4 bytes: "ZONE" - уже прочитано
  ind := index;
  k:=ReadWord;                  // 2 байта - количество карт $0291=657 штук
  //дальше повторяющиеся данные структуры TZone

  LOG.debug('Maps (zones)');
  for i:=1 to k do
    begin
      ReadWord;            //unknown:word; //01 00 - непонятно что
      sz:=ReadLongWord;       //size:longword; //размер, используемый текущей картой
      MoveIndex(sz);
    end;
  Add(sectionName, 4 + index - ind, ind);
  s:='... skipped '+inttostr(k)+' maps';
  LOG.debug(s);
end;

procedure TSection.ScanTILE(sectionName: String);
var k, sz, i, n:cardinal;
s:string;
begin
  sz:=ReadLongWord;
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  s:='Sprites & tiles';
  s:=s+'... skipped';
  LOG.debug(s);
end;


procedure TSection.ScanSNDS(sectionName: String);
var sz:word;
s:string;
begin
  sz:=ReadLongWord;
  Add(sectionName, 4 + sz, index);
  MoveIndex(sz);
  s:='Sounds';
  s:=s+'... skipped';
  LOG.debug(s);
end;

procedure TSection.ScanSTUP(sectionName: String);
var s:string;
sz:longword;
begin
  sz:=ReadLongWord;
  Add(sectionName, 4 + sz, index);
  s:='Title screen';
  MoveIndex(sz);
      s:=s+'... skipped';
  LOG.debug(s);
end;

procedure TSection.ScanVERS(sectionName: String);
begin
  Add(sectionName, 4 + 0, index);
//  Showmessage(Inttostr(index));
  LOG.debug('File version: '+inttostr(ReadRWord)+'.'+inttostr(ReadRWord));
//      Showmessage(Inttostr(index));
end;


procedure TSection.loadFileToArray(fileName: String);
var FS: TFileStream;
begin
  crc32 := IntToHex(GetFileCRC(fileName), 8);
  if crcs.IndexOfName(crc32) = -1
    then dtaRevision := 'Unknown'
    else dtaRevision := crcs.Values[crc32];
  Log.debug('CRC-32: ' + crc32);
  Log.debug('DTA revision: ' + dtaRevision);
  dta := nil;
  Clear;
  FS := TFileStream.Create(fileName, fmOpenRead);
  try
    if FS.Size > 0 then
      begin
        SetLength(dta, FS.Size);
        FS.ReadBuffer(Pointer(dta)^, FS.Size);
      end;
  finally
     FreeAndNil(FS);
  end;
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
