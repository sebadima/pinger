unit Unit18;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, WSocket, WinSock, DateUtils, ExtCtrls, Menus, Inifiles;


const
   SNTP_PORT = '123';
   ONE_SEC   = 1/SecsPerDay;
type

  TNTPTimeStamp = packed record
    Secs: DWORD;
    Frac: DWORD;
  end;

  TNtpRec = packed record
       LiVuMode        : byte;
       Stratum,
       Poll,
       Precision       : byte;
       RootDelay,
       RootDispersion,
       RefID           : array[0..3] of char;
       RefTStamp,
       OrgTStamp,
       RxTStamp,
       TxTStamp        : TNTPTimeStamp;
  end;



  TWinTStamp = record
     DayTime : TDateTime;
     MSecs   : integer;
  end;



  TForm15 = class(TForm)
    cbServers: TComboBox;
    StaticText1: TStaticText;
    edtLocalTime: TEdit;
    edtError: TEdit;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    edtRTT: TEdit;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    cbSync: TCheckBox;
    UDPSock: TWSocket;
    stStatus: TStaticText;
    edtServerTime: TEdit;
    StaticText7: TStaticText;
    Button1: TButton;
    procedure UDPSockDataAvailable(Sender: TObject; Error: Word);
    procedure UDPSockSessionConnected(Sender: TObject; Error: Word);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure UDPSockError(Sender: TObject);
    procedure cbServersSelect(Sender: TObject);
    procedure cbIntervalSelect(Sender: TObject);
    function  ServerIndex():Integer;
  private
    { Private declarations }
    CurrentServer : string;
    ServerTime    : TDateTime;
    SendRec : TNTPRec;
    T1      : TNTPTimeStamp;
    IpResolved : boolean;
    SyncTicks  : integer;
    procedure ReverseByteOrder( var NtpTime: DWORD );
    function  Ntp2Double( NtpTime: TNTPTimestamp ): Double;
    function  NowToNTP : TNtpTimeStamp;
    procedure ResolveIP;
    procedure RequestTime;
  public
    { Public declarations }
  end;

var
  Form15: TForm15;

implementation

uses Main;

{$R *.dfm}



procedure TForm15.ReverseByteOrder( var NtpTime: DWORD );
var
   Ta: array[0..3] of byte absolute NTPTime;
   Temp : WORD;
begin
  temp  := ta[0];
  ta[0] := ta[3];
  ta[3] := temp;
  Temp  := ta[1];
  ta[1] := ta[2];
  ta[2] := temp;
end;



function  TForm15.Ntp2Double( NtpTime: TNTPTimestamp ): Double;
begin
  ReverseByteOrder( NTPTime.Secs );
  ReverseByteOrder( NTPTime.Frac );
  Result  := NTpTime.Secs;
  Result := Result +  ( NTPTime.Frac/$FFFFFFFF) ;
end;




procedure TForm15.FormCreate(Sender: TObject);
begin
  SyncTicks := 0;
end;



procedure TForm15.Timer1Timer(Sender: TObject);
begin
  cbServers.ItemIndex := ServerIndex();
  IpResolved := false;
  CurrentServer := cbServers.Items[cbServers.ItemIndex];
  edtLocalTime.Text := DateTimeTostr(Now);
  if ServerTime <> 0.0 then
  begin
    ServerTime := ServerTime + ONE_SEC;
    edtServerTime.Text := DateTimeToStr(ServerTime);
    Form1.Memo1.Lines.Add(' ');
    Form1.Memo1.Lines.Add(' Internet Time = ' +  (DateTimeToStr(ServerTime)) + ' sul server "' + cbServers.Text + '"');
    Form1.Memo1.Lines.Add(' Local    Time = ' +  (DateTimeToStr(Now)));
  end
  else
  begin
    Form1.Memo1.Lines.Add(' ');
    Form1.Memo1.Lines.Add(' In collegamento, riprovare tra un secondo... ');
  end;
  if ( CurrentServer <> '') and not IPResolved then
    ResolveIP;
  if IpResolved    then
    RequestTime;
end;


procedure TForm15.RequestTime;
begin
  stStatus.Caption := 'requesting time...';
  FillChar( SendRec, SizeOf(SendRec), #0 );

  SendRec.LiVuMode := $33;
  T1 := NowToNTP;
  UDPSock.Send( @SendRec, SizeOf(SendRec));
end;


procedure TForm15.UDPSockDataAvailable(Sender: TObject; Error: Word);
var
  Src     : TSockAddrIn;
  Len     : Integer;
  SrcLen  : Integer;
  T4      : TNtpTimeStamp;
  NTPRec  : TNTPRec;
  T1f,T2f,T3f,t4f,
  Rtt, ClockErr : Double;
  CorrectedTime : TSystemTime;
begin

  T4 := NowToNtp;
  stStatus.Caption := 'time received.';
  SrcLen := SizeOf( Src );
  Len := UDPSock.ReceiveFrom( @NTPRec, SizeOf(NtpRec), Src, SrcLen );
  T1f := Ntp2Double(T1);
  T2f := Ntp2Double(NtpRec.RxTStamp);
  T3f := Ntp2Double(NtpRec.TxTStamp);
  T4f := Ntp2Double(T4);

  Rtt := (T4f-T1f) - (T2f-T3f);

  ClockErr := (( T2f - T1f ) + (T3f-T4f)) / 2;
  edtError.Text := Format('%8.3f', [-ClockErr]);
  edtRTT.Text := IntToStr(Round(Rtt*1000));
   with CorrectedTime do
        DecodeDateTime( Now + (ClockErr/SecsPerDay), wYear, wMonth, wDay,
                        wHour, wMinute, wSecond, wMilliseconds );
  ServerTime := Now + (ClockErr/SecsPerDay);
  edtServerTime.Text := DateTimeToStr(ServerTime);


  if  cbSync.Checked then
  begin
      SetLocalTime( CorrectedTime );
      stStatus.Caption := 'clock corrected.';
      cbSync.Checked := false;
      RequestTime;
  end;

end;


procedure TForm15.UDPSockSessionConnected(Sender: TObject; Error: Word);
begin
  stStatus.Caption := UDPSock.Addr + ' resolved.';
  IpResolved := true;
  RequestTime;
end;

function  TForm15.NowToNTP : TNtpTimeStamp;
var
  T   : TSystemTime;
  TNow: TDateTime;
begin
 GetSystemTime( T );
 TNow := EncodeDateTime(T.wYear, T.wMonth, T.wDay, T.wHour, T.wMinute, T.wSecond, 0);

 Result.Secs := Round((TNow - 2 ) *  SecsPerDay);
 Result.Frac := Round( $FFFFFFFF * (T.wMilliseconds/1000));
 ReverseByteOrder( Result.Secs );
 ReverseByteOrder( Result.Frac );
end;


procedure TForm15.UDPSockError(Sender: TObject);
begin
 stStatus.Caption :='error '+ IntToStr(WSAGetLastError);
 cbServers.ItemIndex := -1;
 CurrentServer := '';
 IpResolved := false;
end;


procedure TForm15.ResolveIP;
begin
  stStatus.Caption := 'resolving ' + cbServers.Items[cbservers.itemindex] + ' ...';
  UDPSock.Close;
  UDPSock.Proto := 'udp';
  UDPSock.Port := SNTP_PORT;
  UDPSock.Addr := CurrentServer;
  UDPSock.Connect;
end;

procedure TForm15.cbServersSelect(Sender: TObject);
begin
  IpResolved := false;
  CurrentServer := cbServers.Items[cbServers.ItemIndex];
end;

procedure TForm15.cbIntervalSelect(Sender: TObject);
begin
  if IPResolved then
      RequestTime;
end;


function TForm15.ServerIndex():Integer;
var
inifile, desk_inifile: TIniFile;
s_indice:integer;
begin
  inifile:= TInifile.create('.\PINGER.INI');
  try
    s_indice := inifile.ReadInteger( 'TCP_Options', 'Form3.IdentificatiCome.ItemIndex', s_indice );
  finally
    inifile.free
  end;
  Result := s_indice;
end;




end.
