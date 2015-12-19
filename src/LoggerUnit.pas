unit LoggerUnit;

interface

uses ComCtrls;

type
  TLogger = class
  private
    editor: TRichEdit;
  public
    procedure Clear;
    procedure Info(text: String);
    procedure Debug(text: String);
    procedure Error(text: String);
    constructor Create(editor: TRichEdit);
    destructor Destroy;
  end;

implementation

procedure TLogger.Clear;
var i: byte;
begin
  if editor <> nil then editor.lines.Clear
end;

procedure TLogger.Debug(text: String);
begin
  editor.SelAttributes.Color:=$000000;
  editor.lines.Add(text);
end;

procedure TLogger.Info(text: String);
begin
  editor.SelAttributes.Color:=$008800;
  editor.lines.Add(text);
end;

procedure TLogger.Error(text: String);
begin
  editor.SelAttributes.Color:=$0000EE;
  editor.lines.Add(text);
end;

constructor TLogger.Create(editor: TRichEdit);
begin
  Self.editor := editor;
end;

destructor TLogger.Destroy;
begin
  editor.free;
end;

end.
