unit Info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ColorGrd, Spin, ComCtrls, Buttons, Inifiles, ExtCtrls,
  fcCombo, fcColorCombo, Registry;

type
  TForm8 = class(TForm)
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    DefaultBtn: TBitBtn;
    PageControl: TPageControl;
    TabSheet2: TTabSheet;
    GroupBox5: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    BackupPanel: TGroupBox;
    GroupBox8: TGroupBox;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    GroupBox2: TGroupBox;
    Edit4: TEdit;
    BitBtn1: TBitBtn;
    function  FNStringGetOperatingSystemVersionMicrosoftWindowsS:string;
    function  GetIPFromHost(var HostName, IPaddr, WSAErr: string): Boolean;
    procedure FormCreate(Sender: TObject);
    procedure TrovaMemoria(Sender: TObject) ;
    procedure NomeUtente(Sender: TObject);
    procedure PorteSeriali(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

uses Unit1, Unit4, Main, Unit8, Unit3, Winsock;

{$R *.dfm}


function TForm8.GetIPFromHost(var HostName, IPaddr, WSAErr: string): Boolean;
type
  Name = array[0..100] of Char;
  PName = ^Name;
var
  HEnt: pHostEnt;
  HName: PName;
  WSAData: TWSAData;
  i: Integer;
begin
  Result := False;
  if WSAStartup($0101, WSAData) <> 0 then begin
    WSAErr := 'Winsock is not responding."';
    Exit;
  end;
  IPaddr := '';
  New(HName);
  if GetHostName(HName^, SizeOf(Name)) = 0 then
  begin
    HostName := StrPas(HName^);
    HEnt := GetHostByName(HName^);
    for i := 0 to HEnt^.h_length - 1 do
     IPaddr :=
      Concat(IPaddr,
      IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.');
    SetLength(IPaddr, Length(IPaddr) - 1);
    Result := True;
  end
  else begin
   case WSAGetLastError of
    WSANOTINITIALISED:WSAErr:='WSANotInitialised';
    WSAENETDOWN      :WSAErr:='WSAENetDown';
    WSAEINPROGRESS   :WSAErr:='WSAEInProgress';
   end;
  end;
  Dispose(HName);
  WSACleanup;
end;



function TForm8.FNStringGetOperatingSystemVersionMicrosoftWindowsS:string;
var s : string;
begin
s := 'Windows version unknown';
case Win32Platform of
VER_PLATFORM_WIN32s :
begin
s := 'Windows 32 bits';
end;
VER_PLATFORM_WIN32_WINDOWS :
case Win32MinorVersion of
0:
if ( Win32BuildNumber < 1000 ) then begin
s := 'Windows 95';
end
else if ( Win32BuildNumber = 1111 ) then begin
s := 'Windows 95 b';
end
else if ( Win32BuildNumber > 1111 ) then begin
s := 'Windows 95c';
end;
10:
if ( Win32BuildNumber < 2000 ) then begin
s := 'Windows 98';
end
else if ( Win32BuildNumber > 2000 ) then begin
s := 'Windows 98 second edition';
end;
90:
begin
// s := FNStringGetOperatingSystemVersionMicrosoftWindowsMeS;
end;
end;
VER_PLATFORM_WIN32_NT :
if ( ( Win32MinorVersion = 2 ) and ( Win32MajorVersion = 5 ) )
then begin
s := 'Windows 2003'; // server
// buildnumber=3790
end
else if ( ( Win32MinorVersion = 1 ) and ( Win32MajorVersion =
5 ) ) then begin
s := 'Windows XP'; // home + professional
// buildnumber=2600
end
else if ( Win32MajorVersion = 4 ) then begin
s := 'Windows NT'; // workstation + server
end
else if ( Win32MajorVersion = 5 ) then begin
s := 'Windows 2000' // workstation + server
// buildnumber=2195
end;
end;
result := s;
end;


procedure TForm8.FormCreate(Sender: TObject);
var
  Host, IP, Err: string;
begin
  Form8.Edit3.Text := FNStringGetOperatingSystemVersionMicrosoftWindowsS;
  if GetIPFromHost(Host, IP, Err) then begin
    Form8.Edit2.Text := Host;
    Form8.Edit1.Text := IP;
  end
  else
    MessageDlg(Err, mtError, [mbOk], 0);
  TrovaMemoria(Self);
  NomeUtente(Self);
  PorteSeriali(Self);
end;


procedure TForm8.TrovaMemoria(Sender: TObject);
var MemoryStatus: TMemoryStatus;
begin
  Memo1.Lines.Clear;
  GlobalMemoryStatus(MemoryStatus) ;
  Memo1.Lines.Add(IntToStr(MemoryStatus.dwMemoryLoad)   + '% della memoria attualmente in Uso');
  Memo1.Lines.Add(IntToStr(MemoryStatus.dwTotalPhys)    + ' memoria Fisica in bytes');
  Memo1.Lines.Add(IntToStr(MemoryStatus.dwAvailPhys)    + ' memoria Disponibile in bytes');
  Memo1.Lines.Add(IntToStr(MemoryStatus.dwTotalPageFile)+ ' Paging File in bytes');
  Memo1.Lines.Add(IntToStr(MemoryStatus.dwTotalVirtual) + ' Spazio Indirizzi in bytes');
end;



procedure TForm8.NomeUtente(Sender: TObject);
var
  buffer : array[0..255] of char;
  buffSize : DWORD;
begin
  buffSize := sizeOf(buffer);
  GetUserName(@buffer, buffSize);
  Form8.Edit4.Text := buffer;
end;



procedure TForm8.PorteSeriali(Sender: TObject);
var
  // don't forget to add Registry to uses clause
  reg : TRegistry;
  ts : TStrings;
  i : integer;
  s: String;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKey('hardware\devicemap\serialcomm',
              false);
  ts := TStringList.Create;
  reg.GetValueNames(ts);
  Memo2.Lines.Clear;
  s := ' ';
  for i := 0 to ts.Count -1 do begin
    s := s + reg.ReadString(ts.Strings[i]) + ':  ';
  end;
  Memo2.Lines.Add(s);
  ts.Free;
  reg.CloseKey;
  reg.free;
end;


procedure TForm8.FormShow(Sender: TObject);
var
  Host, IP, Err: string;
begin
  Form8.Edit3.Text := FNStringGetOperatingSystemVersionMicrosoftWindowsS;
  if GetIPFromHost(Host, IP, Err) then begin
    Form8.Edit2.Text := Host;
    Form8.Edit1.Text := IP;
  end
  else
    MessageDlg(Err, mtError, [mbOk], 0);
  TrovaMemoria(Self);
  NomeUtente(Self);
  PorteSeriali(Self);
end;

procedure TForm8.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm8.BitBtn1Click(Sender: TObject);
begin
  TrovaMemoria(Self);
end;

end.
