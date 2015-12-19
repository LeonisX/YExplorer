//прошил ZONE насквозь
//надо сделать обработку IZON, желательно IACT тоже, или хотя бы сохранять их как-то

unit MainUnit;

interface

uses
  Windows, Forms, BMPUnit, DataStructureUnit, CRCUnit, StdCtrls, Controls, Classes, ExtCtrls, SysUtils, StrUtils, Graphics, dialogs;

const
  sections: Array[1..12] of string[4]=('VERS','STUP','SNDS','TILE','ZONE','PUZ2','CHAR','CHWP','CAUX','TNAM','TGEN','ENDF');

type
  TMainForm = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Button2: TButton;
    GroupBox1: TGroupBox;
    STUPCB: TCheckBox;
    GroupBox2: TGroupBox;
    SNDSCB: TCheckBox;
    GroupBox3: TGroupBox;
    LOG: TMemo;
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
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OpenDTAButtonClick(Sender: TObject);
  private
    section: TSection;
    dta: array of byte;
  public
    procedure readDTAMetricks(fileName: String);
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
    function ChunkIndex(s:string):byte;
  end;

var
  MainForm: TMainForm;
  pn:word;

implementation

{$R *.dfm}


function TMainForm.ChunkIndex(s:string):byte;
var i:byte;
begin
 result:=0;
 for i:=1 to sizeof(Sections) do
 if Sections[i]=s then result:=i;
end;


procedure TMainForm.Button1Click(Sender: TObject);
var keepReading:boolean;
s:string;
begin
  LOG.Lines.Clear;
  FillInternalPalette(BMP);
  CreateDir('output');
  assignfile(SrcFile, 'input\Yodesk.dta');
  Reset(SrcFile,1);

  keepReading:=true;
  while (keepReading) do
    begin
//('VERS','STUP','SNDS','TILE','ZONE','PUZ2','CHAR','CHWP','CAUX','TNAM','ENDF');
      s:=ReadString(4);
      case ChunkIndex(s) of
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
  LOG.Lines.Add('всё...');
end;

procedure TMainForm.ReadTGEN;
var size:longword;
begin
  size:=ReadLongWord;
  LOG.Lines.Add('TGEN: '+inttohex(size,4)); //4 байта - длина блока TGEN
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
  size:=ReadLongWord;
  LOG.Lines.Add('TNAM: '+inttohex(size,4)); //4 байта - длина блока TNAM
  if TNAMCB.Checked then
    begin
      CreateDir('output/Names');
      repeat
         k:=ReadWord; //2 байта - номер персонажа (тайла)
         if k=$FFFF then break;
         s:=ReadString(24); //24 байта - длина до конца текущего имени
         s:=leftstr(s,pos(chr(0),s)-1);
         if CTCB.Checked then CopyFile(pchar('output/Tiles/'+rightstr('000'+inttostr(k),4)+'.bmp'),
                                 pchar('output/Names/'+s+'.bmp'),false);
         LOG.Lines.Add(s);
//         showmessage(s);
      until false;
    end else
       seek(SrcFile,filepos(SrcFile)+size);
end;

procedure TMainForm.ReadCAUX;
var size:longword;
begin
  size:=ReadLongWord;
  LOG.Lines.Add('CAUX: '+inttohex(size,4)); //4 байта - длина блока CAUX
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
  size:=ReadLongWord;
  LOG.Lines.Add('CHWP: '+inttohex(size,4)); //4 байта - длина блока CHWP
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
  size:=ReadLongWord;
  LOG.Lines.Add('CHAR: '+inttohex(size,4)); //4 байта - длина блока CHAR
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
  size:=ReadLongWord;
  LOG.Lines.Add('PUZ2: '+inttohex(size,4)); //4 байта - длина блока PUZ2
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
  ReadWord; // unknown:word; //01 00 - непонятно что
  ReadLongWord; // size:longword; //размер, используемый текущей картой
  pn:=ReadWord; // number:word; //2 байта - это порядковый номер карты, начиная с нуля
  s:='#'+inttostr(pn);
  s:=s+' '+readString(4); // izon:string[4]; //4 bytes: "IZON"
  size:=ReadLongWord; // unk:longword; //4 байта - размер блока IZON (включая IZON) до object info entry count
  s:=s+' '+inttohex(size,4);
  LOG.Lines.Add(s);
  Application.ProcessMessages;
  if IZONCB.Checked then
    begin
     CreateDir('output\Maps');
     w:=ReadWord;   // width:word; //2 bytes: map width (W)
     h:=ReadWord;   // height:word; //2 bytes: map height (H)
     ReadWord;      // flags:word; //2 byte: map flags (unknown meanings)* добавил байт снизу
     ReadLongWord;  // unused:longword; //5 bytes: unused (same values for every map)
     p:=ReadWord;   // planet:word; //1 byte: planet (0x01 = desert, 0x02 = snow, 0x03 = forest, 0x05 = swamp)* добавил следующий байт
     //Image1.Width:=w*32;
     //Image1.Height:=h*32;
     Image1.Picture.Bitmap.Width:=w*32;
     Image1.Picture.Bitmap.Height:=h*32;

     image1.Picture.bitmap.Canvas.Pen.Color:=0;
     image1.Picture.bitmap.Canvas.Brush.Color:=0;
     image1.picture.Bitmap.canvas.Rectangle(0,0,image1.picture.bitmap.width,image1.picture.bitmap.height);
     LOG.lines.Add('Map #' + inttostr(pn) + ' offset: ' + inttohex(filepos(SrcFile),6));
     for i:=0 to h-1 do
      begin
       for j:=0 to w-1 do
         begin          //W*H*6 bytes: map data
           k:=ReadWord;
           if k<>$FFFF then
             begin
               LoadBMP('output\Tiles\'+rightstr('000'+inttostr(k),4)+'.bmp',bmp);
               CopyFrame(Image1,j*32,i*32);
             end;
           k:=ReadWord;
           if k<>$FFFF then
             begin
               LoadBMP('output\Tiles\'+rightstr('000'+inttostr(k),4)+'.bmp',bmp);
               CopyFrame(Image1,j*32,i*32);
             end;
           k:=ReadWord;
           if k<>$FFFF then
             begin
               LoadBMP('output\Tiles\'+rightstr('000'+inttostr(k),4)+'.bmp',bmp);
               CopyFrame(Image1,j*32,i*32);
             end;
         end;
         application.ProcessMessages;
         Image1.Picture.SaveToFile('output\Maps\'+rightstr('000'+inttostr(pn),3)+'.bmp');
      end;
     k:=ReadWord;                             //2 bytes: object info entry count (X)
     seek(SrcFile,filepos(SrcFile)+k*12);     //X*12 bytes: object info data
    end else
     begin
      seek(SrcFile,filepos(SrcFile)+size-8);   //4 байта - размер блока IZON (включая IZON) до object info entry count
      k:=ReadWord;                             //2 bytes: object info entry count (X)
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
  LOG.Lines.Add('IZAX: '+ReadString(4)); //4 bytes: "IZAX"
  size:=ReadWord; //2 bytes: length (X)
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
  LOG.Lines.Add('IZX2: '+ReadString(4)); //4 bytes: "IZX2"
  size:=ReadWord; //2 bytes: length (X)
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
  LOG.Lines.Add('IZX3: '+ReadString(4)); //4 bytes: "IZX3"
  size:=ReadWord; //2 bytes: length (X)
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
  LOG.Lines.Add('IZX4: '+ReadString(4)); //4 bytes: "IZX4"
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
  s:=ReadString(4); //4 bytes: "IACT"
  if s<>'IACT' then goto l2;
  inc(k);
  if IACTCB.Checked then
    begin
      AssignFile(DestFile,'output\Iacts\'+rightstr('000'+inttostr(pn), 3) + '-'+rightstr('00'+inttostr(k),2));
      Rewrite(DestFile,1);
   end;
  size:=ReadLongWord;  //4 bytes: length (X)
  LOG.Lines.Add(s+' '+inttohex(size,4));
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
  k:=ReadWord;                  // 2 байта - количество карт $0291=657 штук
  //дальше повторяющиеся данные структуры TZone

  LOG.Lines.Add('Maps (zones)');
  if ZONECB.checked then
    begin
      for i:=1 to k do ReadIZON;
      s:='... processed '+inttostr(k)+' maps';
    end else
    begin
      for i:=1 to k do
        begin
         ReadWord;            //unknown:word; //01 00 - непонятно что
         sz:=ReadLongWord;       //size:longword; //размер, используемый текущей картой
         seek(SrcFile,filepos(SrcFile)+sz); //пропускаем карту
        end;
      s:='... skipped '+inttostr(k)+' maps';
    end;
  LOG.Lines.Add(s);
end;

procedure TMainForm.ReadTILE;
var k, sz, i, n:cardinal;
s:string;
begin
  sz:=ReadLongWord;
  s:='Sprites & tiles';
  if TILECB.Checked then
    begin
      CreateDir('output/Tiles');
      CreateDir('output/TilesHex');
      BMP.Width:=32; BMP.Height:=32;
      n:=sz div $404;
      for i:=0 to n-1 do
        begin
          k:=ReadLongWord; //атрибуты
          ReadPicture(0);
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
  LOG.Lines.Add(s);
end;


procedure TMainForm.ReadSNDS;
var sz:word;
s:string;
begin
  sz:=ReadLongWord;
  s:='Sounds';
  if SNDSCB.Checked then
    begin
      showmessage('Sound processing force skipping.');
      BlockRead(SrcFile,Buf,sz); //заглушка
      s:=s+'... processed';
    end
    else
    begin
      seek(SrcFile,filepos(SrcFile)+sz);
      s:=s+'... skipped';
    end;
  LOG.Lines.Add(s);
end;

procedure TMainForm.ReadSTUP;
var s:string;
sz:longword;
begin
  sz:=ReadLongWord;
  s:='Title screen';
  if STUPCB.Checked then
    begin
      BMP.Width:=288; BMP.Height:=288;
      ReadPicture($10);
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
  LOG.Lines.Add(s);
end;

procedure TMainForm.ReadVERS;
begin
  LOG.Lines.add('File version: '+inttostr(ReadRWord)+'.'+inttostr(ReadRWord));
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  section := TSection.Create;
  BMP := TBitmap.Create;
  BMP.PixelFormat:=pf8bit;
  LOG.Clear;
  OpenDTADialog.InitialDir := '.\'
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  dta := nil;
  BMP.Free;
  section.Free;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  LoadBMP('output/STUP.bmp',bmp);
  CopyPicture(Image1,0,0);
end;


procedure TMainForm.OpenDTAButtonClick(Sender: TObject);
begin
  if OpenDTADialog.Execute then readDTAMetricks(OpenDTADialog.FileName);
end;


procedure TMainForm.readDTAMetricks(fileName: String);
var FS: TFileStream;
begin
  LOG.Lines.Add(IntToHex(GetFileCRC(fileName), 8));
  dta := nil;
  section.Clear;
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
  ShowMessage(IntToStr(Length(dta)));
end;


end.


