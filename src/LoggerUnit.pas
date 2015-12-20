unit LoggerUnit;

interface

uses ComCtrls, Classes;

type
  TLogger = class
  private
    lines: TStrings;
  public
    procedure Clear;
    procedure Info(text: String);
    procedure Debug(text: String);
    procedure Error(text: String);
    procedure SetOutput(lines: TStrings);
    constructor Create;
    destructor Destroy;
  end;

  var log: TLogger;

implementation

procedure TLogger.Clear;
var i: byte;
begin
  if lines <> nil then lines.Clear;
end;

procedure TLogger.Debug(text: String);
begin
  //editor.SelAttributes.Color:=$000000;
  lines.Add(text);
end;

procedure TLogger.Info(text: String);
begin
  //editor.SelAttributes.Color:=$008800;
  lines.Add(text);
end;

procedure TLogger.Error(text: String);
begin
  //editor.SelAttributes.Color:=$0000EE;
  lines.Add(text);
end;

procedure TLogger.SetOutput(lines: TStrings);
begin
  Self.lines.free;
  Self.lines := lines;
end;

constructor TLogger.Create;
begin
  Self.lines := TStringList.Create;
end;

destructor TLogger.Destroy;
begin
  lines.free;
end;

initialization

  log := TLogger.Create;

finalization

  log.Free;

end.
