//прошил ZONE насквозь
//надо сделать обработку IZON, желательно IACT тоже, или хотя бы сохранять их как-то

unit MainUnit;

interface

uses
  Windows, Forms, BMPUnit, DataStructureUnit, LoggerUnit, StdCtrls, Controls, Classes, ExtCtrls, SysUtils, StrUtils, Graphics, dialogs,
  ComCtrls;

const OUTPUT = 'output';

type
  TMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    STUPCB: TCheckBox;
    GroupBox2: TGroupBox;
    SNDSCB: TCheckBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    TILECB: TCheckBox;
    GroupBox5: TGroupBox;
    ZONECB: TCheckBox;
    IZONCB: TCheckBox;
    IZAXCB: TCheckBox;
    IZX2CB: TCheckBox;
    IZX3CB: TCheckBox;
    IZX4CB: TCheckBox;
    IACTCB: TCheckBox;
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
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OpenDTAButtonClick(Sender: TObject);
    procedure SaveSTUPButtonClick(Sender: TObject);
    procedure ListSNDSButtonClick(Sender: TObject);
  private
  public
    procedure ReadVERS;
    procedure ReadSTUP;
    procedure ReadSNDS;
    procedure ReadTILE;
    procedure ReadZONE;
    procedure ReadIZON;
    procedure ReadIZAX;
    procedure ReadIZX2;
    procedure ReadIZX3;
    procedure ReadIZX4;
    procedure ReadIACT;
    procedure ReadPUZ2;
    procedure ReadCHAR;
    procedure ReadCHWP;
    procedure ReadCAUX;
    procedure ReadTNAM;
    procedure ReadTGEN;
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
//('VERS','STUP','SNDS','TILE','ZONE','PUZ2','CHAR','CHWP','CAUX','TNAM','ENDF');
      s := DTA.ReadString(4);
      case DTA.ChunkIndex(s) of
       1: ReadVERS; //версия файла
       2: ReadSTUP; //чтение титульной картинки
       3: ReadSNDS; //SNDS, 4 байта размер блока, C0FF, размер названия сэмпла+$0, размер названия сэмпла+$0,... пока не надо
       4: ReadTILE; //тайлы
       5: ReadZONE; //локации
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
    seek(SrcFile,filepos(SrcFile)+size);
    end else
       seek(SrcFile,filepos(SrcFile)+size);
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

procedure TMainForm.ReadIZON;
var s:string;
size:longword;
k,w,h,p,i,j:word;
begin
  DTA.ReadWord; // unknown:word; //01 00 - непонятно что
  DTA.ReadLongWord; // size:longword; //размер, используемый текущей картой
  pn:=DTA.ReadWord; // number:word; //2 байта - это порядковый номер карты, начиная с нуля
  s:='#'+inttostr(pn);
  s:=s+' '+DTA.readString(4); // izon:string[4]; //4 bytes: "IZON"
  size:=DTA.ReadLongWord; // unk:longword; //4 байта - размер блока IZON (включая IZON) до object info entry count
  s:=s+' '+inttohex(size,4);
  LOG.debug(s);
  Application.ProcessMessages;
  if IZONCB.Checked then
    begin
     CreateDir('output\Maps');
     w:=DTA.ReadWord;   // width:word; //2 bytes: map width (W)
     h:=DTA.ReadWord;   // height:word; //2 bytes: map height (H)
     DTA.ReadWord;      // flags:word; //2 byte: map flags (unknown meanings)* добавил байт снизу
     DTA.ReadLongWord;  // unused:longword; //5 bytes: unused (same values for every map)
     p:=DTA.ReadWord;   // planet:word; //1 byte: planet (0x01 = desert, 0x02 = snow, 0x03 = forest, 0x05 = swamp)* добавил следующий байт
     //Image1.Width:=w*32;
     //Image1.Height:=h*32;
     Image1.Picture.Bitmap.Width:=w*32;
     Image1.Picture.Bitmap.Height:=h*32;

     image1.Picture.bitmap.Canvas.Pen.Color:=0;
     image1.Picture.bitmap.Canvas.Brush.Color:=0;
     image1.picture.Bitmap.canvas.Rectangle(0,0,image1.picture.bitmap.width,image1.picture.bitmap.height);
     LOG.debug('Map #' + inttostr(pn) + ' offset: ' + inttohex(filepos(SrcFile),6));
     for i:=0 to h-1 do
      begin
       for j:=0 to w-1 do
         begin          //W*H*6 bytes: map data
           k:=DTA.ReadWord;
           if k<>$FFFF then
             begin
               LoadBMP('output\Tiles\'+rightstr('000'+inttostr(k),4)+'.bmp',bmp);
               CopyFrame(Image1,j*32,i*32);
             end;
           k:=DTA.ReadWord;
           if k<>$FFFF then
             begin
               LoadBMP('output\Tiles\'+rightstr('000'+inttostr(k),4)+'.bmp',bmp);
               CopyFrame(Image1,j*32,i*32);
             end;
           k:=DTA.ReadWord;
           if k<>$FFFF then
             begin
               LoadBMP('output\Tiles\'+rightstr('000'+inttostr(k),4)+'.bmp',bmp);
               CopyFrame(Image1,j*32,i*32);
             end;
         end;
         application.ProcessMessages;
         Image1.Picture.SaveToFile('output\Maps\'+rightstr('000'+inttostr(pn),3)+'.bmp');
      end;
     k:=DTA.ReadWord;                             //2 bytes: object info entry count (X)
     seek(SrcFile,filepos(SrcFile)+k*12);     //X*12 bytes: object info data
    end else
     begin
      seek(SrcFile,filepos(SrcFile)+size-8);   //4 байта - размер блока IZON (включая IZON) до object info entry count
      k:=DTA.ReadWord;                             //2 bytes: object info entry count (X)
      seek(SrcFile,filepos(SrcFile)+k*12);     //X*12 bytes: object info data
     end;
   ReadIZAX;
   ReadIZX2;
   ReadIZX3;
   ReadIZX4;
   ReadIACT;
end;


procedure TMainForm.ReadIZAX;
var size:word;
begin
  LOG.debug('IZAX: '+DTA.ReadString(4)); //4 bytes: "IZAX"
  size:=DTA.ReadWord; //2 bytes: length (X)
  if IZAXCB.Checked then
    begin
   //X-6 bytes: IZAX data
   //showmessage('Обработка IZAX пока не поддерживается!!!');
    seek(SrcFile,filepos(SrcFile)+size-6);
    end else
       seek(SrcFile,filepos(SrcFile)+size-6);
end;

procedure TMainForm.ReadIZX2;
var size:word;
begin
  LOG.debug('IZX2: '+DTA.ReadString(4)); //4 bytes: "IZX2"
  size:=DTA.ReadWord; //2 bytes: length (X)
  if IZX2CB.Checked then
    begin
    //X-6 bytes: IZX2data
    //showmessage('Обработка IZX2 пока не поддерживается!!!');
    seek(SrcFile,filepos(SrcFile)+size-6);
    end else
       seek(SrcFile,filepos(SrcFile)+size-6);
end;

procedure TMainForm.ReadIZX3;
var size:word;
begin
  LOG.debug('IZX3: '+DTA.ReadString(4)); //4 bytes: "IZX3"
  size:=DTA.ReadWord; //2 bytes: length (X)
  if IZX3CB.Checked then
    begin
    //X-6 bytes: IZX3data
    //showmessage('Обработка IZX3 пока не поддерживается!!!');
    seek(SrcFile,filepos(SrcFile)+size-6);
    end else
       seek(SrcFile,filepos(SrcFile)+size-6);
end;

procedure TMainForm.ReadIZX4;
begin
  LOG.debug('IZX4: '+DTA.ReadString(4)); //4 bytes: "IZX4"
  if IZX4CB.Checked then
    begin
    //8 bytes: IZX4 data
    //showmessage('Обработка IZX4 пока не поддерживается!!!');
    seek(SrcFile,filepos(SrcFile)+8);
    end else
       seek(SrcFile,filepos(SrcFile)+8);
end;

procedure TMainForm.ReadIACT;
label l1,l2;
var s:string;
size:longword;
k: integer;
begin
  if IACTCB.Checked then CreateDir('output\Iacts');
   k:=0;
l1:
  s:=DTA.ReadString(4); //4 bytes: "IACT"
  if s<>'IACT' then goto l2;
  inc(k);
  if IACTCB.Checked then
    begin
      AssignFile(DestFile,'output\Iacts\'+rightstr('000'+inttostr(pn), 3) + '-'+rightstr('00'+inttostr(k),2));
      Rewrite(DestFile,1);
   end;
  size:=DTA.ReadLongWord;  //4 bytes: length (X)
  LOG.debug(s+' '+inttohex(size,4));
  if IACTCB.Checked then
     begin
      //X bytes: action data
      BlockRead(SrcFile,buf,size);
      BlockWrite(DestFile,buf,size);
      Closefile(DestFile);
     end else
        seek(SrcFile,filepos(SrcFile)+size);
  goto l1;
l2:
  seek(SrcFile,filepos(SrcFile)-4);
//  showmessage(inttohex(filepos(SrcFile),4));
//  showmessage('IACTs all');
end;

procedure TMainForm.ReadZONE;
var sz:longword;
k,i:word;
s:string;
begin
  //Signature: String[4];       // 4 bytes: "ZONE" - уже прочитано
  k:=DTA.ReadWord;                  // 2 байта - количество карт $0291=657 штук
  //дальше повторяющиеся данные структуры TZone

  LOG.debug('Maps (zones)');
  if ZONECB.checked then
    begin
      for i:=1 to k do ReadIZON;
      s:='... processed '+inttostr(k)+' maps';
    end else
    begin
      for i:=1 to k do
        begin
         DTA.ReadWord;            //unknown:word; //01 00 - непонятно что
         sz:=DTA.ReadLongWord;       //size:longword; //размер, используемый текущей картой
         seek(SrcFile,filepos(SrcFile)+sz); //пропускаем карту
        end;
      s:='... skipped '+inttostr(k)+' maps';
    end;
  LOG.debug(s);
end;

procedure TMainForm.ReadTILE;
var k, sz, i, n:cardinal;
s:string;
begin
  sz:=DTA.ReadLongWord;
  s:='Sprites & tiles';
  if TILECB.Checked then
    begin
      CreateDir('output/Tiles');
      CreateDir('output/TilesHex');
      BMP.Width:=32; BMP.Height:=32;
      n:=sz div $404;
      for i:=0 to n-1 do
        begin
          k:=DTA.ReadLongWord; //атрибуты
          ReadPicture(DTA, 0);
          CopyPicture(Image1,0,0);
          application.ProcessMessages;
//          SaveBMP('output/Tiles/'+rightstr('000'+inttostr(i),4)+' - '+inttohex(k,6)+'.bmp',bmp);
          SaveBMP('output/Tiles/'+rightstr('000'+inttostr(i),4)+'.bmp',bmp);
          SaveBMP('output/TilesHex/'+inttohex(i,4)+'.bmp',bmp);
        end;
      s:=s+'... processed: '+inttostr(n)+' images';
    end
    else
    begin
      seek(SrcFile,filepos(SrcFile)+sz);
      s:=s+'... skipped';
    end;
  LOG.debug(s);
end;


procedure TMainForm.ReadSNDS;
begin
end;

procedure TMainForm.ReadSTUP;
var s:string;
sz:longword;
begin
  sz:=DTA.ReadLongWord;
  s:='Title screen';
  if STUPCB.Checked then
    begin
      BMP.Width:=288; BMP.Height:=288;
      ReadPicture(DTA, $10);
      CopyPicture(Image1,0,0);
      application.processmessages;
      SaveBMP('output/STUP.bmp',bmp);
      s:=s+'... saved';
    end
    else
    begin
      seek(SrcFile,filepos(SrcFile)+sz);
      s:=s+'... skipped';
    end;
  LOG.debug(s);
end;

procedure TMainForm.ReadVERS;
begin
  LOG.debug('File version: '+inttostr(DTA.ReadRWord)+'.'+inttostr(DTA.ReadRWord));
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  spath := ExtractFilePath(paramstr(0));
  opath := spath + OUTPUT + '\';
  BMP := TBitmap.Create;
  BMP.PixelFormat:=pf8bit;
  FillInternalPalette(BMP, 0, 0, 0);
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
      Log.SaveToFile(opath, 'Structure');
    end;
end;





procedure TMainForm.SaveSTUPButtonClick(Sender: TObject);
var title: String;
begin
  Log.Clear;
  CreateDir(opath);
  title := knownSections[2]; // STUP
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

end.


