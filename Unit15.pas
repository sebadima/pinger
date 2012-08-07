unit Unit15;
{
 Delphi System Enumerator
 ------------------------
 Enumerates all processes running on a system.
 For each process:
  - all modules (DLL's etc..) it uses,
  - all windows it uses ( including invisible windows),
  are listed


 Author : D. Claessens <dirk.claessens16@yucom.be>

 FREEWARE  ( BUT USE AT YOUR OWN RISK )

 ======================================================================
 Tested on : Delphi 4 update pack 2+3,  P3/550/128/W98se, P1/100/24/W95
 NOTE: will NOT, repeat _NOT_ work on NT, due to security constraints
 ======================================================================

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, TlHelp32, ComCtrls;
const
   Version = 'v1.2';
type
  TForm13 = class(TForm)
    Button1: TButton;
    ListWin: TRichEdit;
    PrBar: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    WindowList,
    ProcessList : TStringList;
    procedure GetModules  ( ProcessID: DWORD; Buf: TStrings );
    procedure GetProcesses( Buf: TStrings);
    procedure ListAll;
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

uses Unit1, Main;

{$R *.DFM}



//==========================================
procedure TForm13.FormCreate(Sender: TObject);
begin
  Caption := Caption + ' ' + Version;
  WindowList  := TStringList.Create;
  ProcessList := TStringList.Create;
end;

//===========================================
procedure TForm13.FormDestroy(Sender: TObject);
begin
   WindowList.Free;
   ProcessList.Free;
end;


{----------------------------------------}
{ Window  enumeration Callback procedure }
{ NOTE: this proc _must_ be global,      }
{ and _cannot_ be a method.              }
{----------------------------------------}
function WinEnumProc( hWnd: THandle; Val: integer ): boolean; stdcall;
const
 FmtStr = '%-8.8x  %-8.8x   %-35s %s';
var
 ClassName,
 WinText       : array[0..255] of Char;
 WinInfo       : string;
 LpdwProcessID : DWORD;

begin

 // get classname from handle
 GetClassName( hWnd, ClassName, 255 );

 // get window title from handle (if any)
 if GetWindowText( hWnd, WinText, 255) = 0 then
    Wintext := 'no title';

 // get some window info
 WinInfo := '';
 case boolean(IsWindowVisible( hWnd )) of
  true : WinInfo := ' [visible';
  false: WinInfo := ' [invisible';
 end;
 //
 if boolean(IsIconic( hWnd )) then
   WinInfo := WinInfo + ',iconic]'
 else
   WinInfo := WinInfo + ']';

 // get ProcessID that owns this window
 lpdwProcessID := 1;
 GetWindowThreadProcessID( hWnd, @lpdwProcessID );
 // ProcessID is stored separately, to facilitate searching later
  //Form1.WindowList.AddObject( Format( FmtStr, [lpdwProcessID, hWnd,
//                              string(ClassName),
  //                            string(WinText)]) + WinInfo,
    //                          TObject( lpdwProcessID));
 // Tell Windows to continue
 Result := true;
end;


{-------------------------------------------------------------}
{  Enumerates modules in use, given a ProcessID               }
{-------------------------------------------------------------}
procedure TForm13.GetModules( ProcessID: DWORD; Buf: TStrings );
const
  FmtMod = '    %8.8x  %6.1f     %4.4d %15s  %-s';
var
 hSnap : THandle;
 ModuleEntry : TModuleEntry32; // <<==see TLHelp32.pas for details
 Proceed     : Boolean;
begin
  Buf.Clear;
  hSnap := CreateToolhelp32Snapshot( TH32CS_SNAPMODULE , ProcessID );
  if HSnap <> -1 then
  begin
   //
   //Buf.Add(' ');
   //Buf.Add('    Modules used:');
   //Buf.Add('    ModuleID   Size(kb) Usage     Module        Path');
   //Buf.Add('    --------   -------- ------    ------        ----');
   //
   ModuleEntry.dwSize := SizeOf(TModuleEntry32);
   Proceed :=  Module32First(hSnap, ModuleEntry);
   while Proceed do
   begin
     with ModuleEntry do
(*       Buf.add( Format( FmtMod, [Th32ModuleID, ModBaseSize/1024,
                                 GlblCntUsage,
                                 szModule,
                                 ExtractFilePath(szEXEPath)])
              );
  *)
     Proceed := Module32Next( hSnap, ModuleEntry);
   end;
   //
   CloseHandle( hSnap );
  end
  else
    ShowMessage( 'Oops...' + SysErrorMessage(GetLastError));
end;


{--------------------------------------------------------------------}
{  Enumerates running tasks                                          }
{                                                                    }
{--------------------------------------------------------------------}
procedure TForm13.GetProcesses(  Buf: TStrings);
const
  FmtProc = ' * %s';
var
  hSnap     : THandle;
  ProcessEntry : TProcessEntry32; // <<==see TLHelp32.pas for details
  Proceed   : Boolean;
begin
  Buf.Clear;
  Buf.Add(' Elenco Processi Attivi');
  //Form1.Memo1.Clear;
  Form1.Memo1.Lines.Add(' ');
  Form1.Memo1.Lines.Add(' ');
  Form1.Memo1.Lines.Add(' Elenco Processi Attivi');
  Form1.Memo1.Lines.Add(' ------');
  // get a snapshot handle
  hSnap := CreateToolhelp32Snapshot( TH32CS_SNAPALL , 0 );
  if HSnap <> -1 then
  begin
   ProcessEntry.dwSize := SizeOf(TProcessEntry32);
   Proceed := Process32First(hSnap, ProcessEntry);
   while Proceed do
   begin
     with ProcessEntry do
     begin

      Form1.Memo1.Lines.AddObject( Format( FmtProc, [szEXEFile]),
                     TObject(TH32ProcessID));

      Buf.AddObject( Format( FmtProc, [szEXEFile]),
                     TObject(TH32ProcessID));
     end;
     // Keep calling until Windows returns false
     Proceed := Process32Next( hSnap, ProcessEntry);
   end;
   CloseHandle( hSnap );
  end
  else
    ShowMessage( 'Oops...' + SysErrorMessage(GetLastError));
end;




//============================================
procedure TForm13.Button1Click(Sender: TObject);
begin
  WindowList.Clear;
  ProcessList.Clear;
  EnumWindows(  @WinEnumProc, 0);
  GetProcesses( ProcessList);
  ListAll;
end;




//=======================
procedure TForm13.ListAll;
var
  i,j : integer;
  ProcessID : DWORD;
  ModuleList : TStringList;
  WindowLess : boolean;
begin
  PrBar.Max := ProcessList.Count;
  PrBar.Position := 0;
  ListWin.Clear;
  ModuleList := TStringList.Create;
  if ProcessList.Count > 0 then
  for i := 0 to pred(ProcessList.Count) do
  begin
    PrBar.Position := i;
    //ListWin.Lines.Add(' ');
    //ListWin.Lines.Add('');
    with ListWin.SelAttributes do
    begin
       Color := clNAVY;
       Style := [fsUNDERLINE];
    end;
    //ListWin.Lines.Add('ProcessID  ParentID ModuleID  Usage  Threads Prio Path');
    with ListWin.SelAttributes do
    begin
       Style := [];
       Color := clNAVY;
    end;
    ListWin.Lines.Add( ProcessList[i] );
    //ListWin.Lines.Add( '  ');

    with ListWin.SelAttributes do
      begin
       Color := clGREEN;
       Style := [];
      end;
    //ListWin.Lines.Add( '    Owned Windows:');
    //
    with ListWin.SelAttributes do
    begin
      Color := clGREEN;
      Style := [fsUNDERLINE];
    end;
    //
    WindowLess := true;
    if WindowList.Count > 0 then
    begin

      ListWin.Lines.Add( '    ProcessID  HWND      Classname                           Window Title');
      with ListWin.SelAttributes do
      begin
       Style := [];
       Color := clGREEN;
      end;
      // look for matching ProcessID's
      // these were stored in the pointer space of the stringlists
      for j := 0 to pred(WindowList.Count) do
      if DWORD( WindowList.Objects[j] ) = DWORD( ProcessList.Objects[i]) then
      begin
         // add windows owned by this processID
         ListWin.Lines.Add( '    ' + WindowList[j] );
         WindowLess := false;
      end;
    end;
    if WindowLess then
          //ListWin.Lines.Add('     none.');
    //
    with ListWin.SelAttributes do
      begin
       Style := [];
       Color := clPURPLE;
      end;
    GetModules( DWORD(ProcessList.Objects[i]), ModuleList );
    ListWin.Lines.AddStrings( ModuleList );
  end;
  ModuleList.Free;
  PrBar.Position := 0;
end;


end.
