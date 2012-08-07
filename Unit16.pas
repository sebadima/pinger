unit Unit16;
{==============================================================}
{ Example how to show uptime of system and when system started }
{ Platform Delphi 5                                            }
{ (c) Anatoly Podgoretsky, 2002                                }
{ anatoly@podgoretsky.com                                      }
{ http://www.podgoretsky.com                                   }
{==============================================================}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ShellApi,
  ComObj,
  ExtCtrls, Buttons, ComCtrls;

type
  TUptimeForm = class(TForm)
    Timer: TTimer;
    PageControl: TPageControl;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    BitBtn1: TBitBtn;
    StartLabel: TLabel;
    UptimeLabel: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure TimerTimer(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  end;

var
  UptimeForm: TUptimeForm;

implementation

{$R *.DFM}

const
	MS					=	1000;
  HOURSPERDAY	=	24;
  MINPERHOUR	=	60;
	SECPERMIN		=	60;
  SECPERHOUR	=	MINPERHOUR * SECPERMIN;
  SECPERDAY		=	HOURSPERDAY * SECPERHOUR;

procedure TUptimeForm.FormShow(Sender: TObject);
begin
  StartLabel.Caption	:= DateTimeToStr(Now - GetTickCount / (SECPERDAY*MS));
	TimerTimer(Self);
end;

procedure TUptimeForm.TimerTimer(Sender: TObject);
var
  Uptime	:	Cardinal;
  TmpStr	:	string;
begin
  Uptime							:= GetTickCount div MS;
// DAYS
  TmpStr							:= IntToStr(Uptime div SECPERDAY) + ' giorni ';
  UpTime							:= Uptime mod SECPERDAY;
// HOURS
  TmpStr							:= TmpStr + IntToStr(Uptime div SECPERHOUR) + ' ore ';
  UpTime							:= Uptime mod SECPERHOUR;
// MINUTES
  TmpStr							:= TmpStr + IntToStr(Uptime div SECPERMIN) + ' minuti ';
  UpTime							:= Uptime mod SECPERMIN;
// SECONDS
  TmpStr							:= TmpStr + IntToStr(Uptime) + ' secondi';
// RESULY
  UptimeLabel.Caption	:= TmpStr;
end;

procedure TUptimeForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TUptimeForm.BitBtn2Click(Sender: TObject);
begin
ShellExecute (HWND(nil), 'open', 'taskmgr', '', '', SW_SHOWNORMAL);
end;

procedure TUptimeForm.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TUptimeForm.BitBtn3Click(Sender: TObject);
var 
  shell: Variant;
begin
  shell := CreateOleObject('Shell.Application');
  shell.ShutdownWindows;
end;

procedure TUptimeForm.BitBtn4Click(Sender: TObject);
var 
  FullProgPath: PChar; 
begin 
  FullProgPath := PChar(Application.ExeName); 
  WinExec(FullProgPath, SW_SHOW); 
  Application.Terminate;
end;

end.
