unit DataStructureUnit;

interface

uses classes, dialogs, sysutils;

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
  public
    procedure Clear;
    procedure Add(section: String; size, offset: integer);
    function GetOffset(section: String): integer;
    function GetSize(section: String): integer;
    function GetFullSize(section: String): integer;
    function Have(section: String): boolean;
    constructor Create;
    destructor Destroy;
  end;

implementation

procedure ShowMessage(k: integer);
begin
  Dialogs.Showmessage(inttostr(k));
end;

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
end;

destructor TSection.Destroy;
begin
  clear;
  sections.free;
end;

end.
