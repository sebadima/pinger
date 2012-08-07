unit Unit17;

interface

uses
{$IFDEF Linux}
   QGraphics,  QControls,  QForms,  QDialogs,  QStdCtrls,  QExtCtrls,  QButtons,
     QComCtrls,
{$ELSE}
    Windows, Messages,  Graphics,  Controls,  Forms,  Dialogs,  StdCtrls,
    ExtCtrls,  Buttons,  ComCtrls,
{$ENDIF}
  SysUtils,  Classes, IdComponent, IdTCPConnection,
    IdTCPClient, IdHTTP, IdBaseComponent, IdSSLOpenSSL, IdIntercept,
    IdSSLIntercept, IdAntiFreezeBase, IdAntiFreeze, IdLogBase, IdLogDebug,
    Menus, Spin, DB, DBTables, Inifiles, typInfo, StrUtils;

type
  TRGBArray = array[0..32767] of TRGBTriple;
  PRGBArray = ^TRGBArray;

type
  TForm14 = class(TForm)
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    FRegion: THandle;
    function CreateRegion(Bmp: TBitmap): THandle;
  end;

var
  Form14: TForm14;

implementation

{$R *.dfm}

function TForm14.CreateRegion(Bmp: TBitmap): THandle;
var
  X, Y, StartX: Integer;
  Excl: THandle;
  Row: PRGBArray;
  TransparentColor: TRGBTriple;
begin
  Bmp.PixelFormat := pf24Bit;

  Result := CreateRectRGN(0, 0, Bmp.Width, Bmp.Height);

  for Y := 0 to Bmp.Height - 1 do
  begin
    Row := Bmp.Scanline[Y];

    StartX := -1;

    if Y = 0 then
      TransparentColor := Row[0];

    for X := 0 to Bmp.Width - 1 do
    begin
      if (Row[X].rgbtRed = TransparentColor.rgbtRed) and
        (Row[X].rgbtGreen = TransparentColor.rgbtGreen) and
        (Row[X].rgbtBlue = TransparentColor.rgbtBlue) then
      begin
        if StartX = -1 then StartX := X;
      end
      else
      begin
        if StartX > -1 then
        begin
          Excl := CreateRectRGN(StartX, Y, X + 1, Y + 1);
          try
            CombineRGN(Result, Result, Excl, RGN_DIFF);
            StartX := -1;
          finally
            DeleteObject(Excl);
          end;
        end;
      end;
    end;

    if StartX > -1 then
    begin
      Excl := CreateRectRGN(StartX, Y, Bmp.Width, Y + 1);
      try
        CombineRGN(Result, Result, Excl, RGN_DIFF);
      finally
        DeleteObject(Excl);
      end;
    end;
  end;
end;

procedure TForm14.FormCreate(Sender: TObject);
var
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromFile('app.gt2');
    FRegion := CreateRegion(Bmp);
    SetWindowRGN(Handle, FRegion, True);
  finally
    Bmp.Free;
  end;
end;

procedure TForm14.FormDestroy(Sender: TObject);
begin
  DeleteObject(FRegion);
end;

procedure TForm14.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm14.BitBtn1Click(Sender: TObject);
begin
  showmessage('Se siete questa persona o il mulo siete pregati di non mandare email...');
  Close;
end;

end.
