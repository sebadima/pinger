unit Unit12;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, IdBaseComponent, IdComponent, IdRawBase,
  IdRawClient, IdIcmpClient, IdAntiFreezeBase, IdAntiFreeze, ComCtrls, Strutils;

const
  ICMP_TIMEOUT      = 5000;
  ICMP_MAX_HOPS     = 40;
  NULL_IP           = '0.0.0.0';

type
  TForm9 = class(TForm)
    Icmp: TIdIcmpClient;
    edtHost: TEdit;
    StaticText1: TStaticText;
    sbTrace: TSpeedButton;
    cbResolveHosts: TCheckBox;
    edtIP: TEdit;
    IdAntiFreeze1: TIdAntiFreeze;
    StaticText2: TStaticText;
    sbStop: TSpeedButton;
    StaticText3: TStaticText;
    StatusBar: TStatusBar;
    reLog: TRichEdit;
    procedure sbTraceClick(Sender: TObject);
    procedure sbStopClick(Sender: TObject);
  private
    { Private declarations }
    FDestIP    : string;
    FHostName  : string;
    CurrentTTL : integer;
    PingStart  : cardinal;
    FStop      : boolean;
    procedure PingFirst;
    procedure PingNext;
    procedure ProcessResponse( Status: TReplyStatus) ;
    procedure Report( TTL: integer; ResponseTime: integer;Status: TReplyStatus; info: string );
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

 uses IDStack, Main;
{$R *.dfm}


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TForm9.sbTraceClick(Sender: TObject);
begin
  FStop := false;
  PingFirst;
end;

//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TForm9.sbStopClick(Sender: TObject);
begin
 FStop := true;
end;


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TForm9.Report( TTL: integer; ResponseTime: integer; Status: TReplyStatus;
                         info: string );
var
 HostName : string;
begin
  Application.ProcessMessages;
  if cbResolveHosts.Checked
  and (Status.FromIpAddress <> NULL_IP ) then
   try
      StatusBar.SimpleText := ' rDNS lookup for ' + Status.FromIpAddress+ ' ...';
      HostName := gStack.WSGetHostByAddr( Status.FromIpAddress );
   except
      HostName := Status.FromIpAddress+ ' [no rDNS]';
   end
  else
    HostName := '...';

  with Status do
  begin
   case Status.ReplyStatusType of
     rsECHO             : reLog.SelAttributes.Color := clGREEN;
     rsTIMEOUT,
     rsERROR,
     rsERRORUNREACHABLE : reLog.SelAttributes.Color := clRED
     else
      reLog.SelAttributes.Color := clNAVY;
   end;
   Form1.Memo1.Lines.Add( Format( '%-4d %-18s %4dms  %-4d %s',
                               [TTL, FromIPAddress,
                                ResponseTime, Status.TimeToLive, Info]) );
  end;
  Application.ProcessMessages;

end;


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TForm9.PingFirst;
var
 OldMode : DWORD;
begin
 reLog.Clear;
 Application.ProcessMessages;
 CurrentTTL := 1;
 FHostName := edtHost.Text;
 ICMP.ReceiveTimeout := ICMP_TIMEOUT;
 ICMP.TTL  := CurrentTTL;

 OldMode := SetErrorMode( SEM_FAILCRITICALERRORS ); // trap DNS-errors!
 try
  StatusBar.SimpleText := 'looking up destination IP of ' +  FHostName +' ...' ;
  reLog.Refresh;
  FDestIP    := GStack.WSGetHostByName(AnsiReplaceStr(Form1.cbURL.Text, 'http://', '')); // pippo
  edtIP.Text := FDestIP;
 except
  edtIP.Text := '?.?.?.?';
  StatusBar.SimpleText :='  cannot resolve IP-address of host "' + edtHost.Text +'"';
  MessageBeep(0);  // Euh Aah...
  EXIT;
 end;
 SetErrorMode( OldMode );

 ICMP.Host := FDestIP;
 PingStart := GetTickCount;

 if not FStop then
 begin
   ICMP.Ping;
   Processresponse(ICMP.ReplyStatus);
 end;

end;


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TForm9.PingNext;
var
  OldMode: DWORD;
begin
 if FStop then
 begin
    reLog.Lines.Add('** INTERRUPTED **');
    EXIT;
 end;
 inc(CurrentTTL);
 if CurrentTTL < ICMP_MAX_HOPS then
 begin
   ICMP.Host := FDestIP ;
   ICMP.TTL  := CurrentTTL;
   ICMP.ReceiveTimeout := ICMP_TIMEOUT;
   PingStart := GetTickCount;
   StatusBar.SimpleText := ' ping ' + FDestIP + ' ...';
   OldMode := SetErrorMode( SEM_FAILCRITICALERRORS );
   try
     ICMP.Ping;
   except
     reLog.Lines.Add('** ERROR **');
   end;
   SetErrorMode( OldMode );
   Processresponse(ICMP.ReplyStatus);
 end
 else
   StatusBar.SimpleText :=  'MAX TTL EXCEEDED.';
end;


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TForm9.ProcessResponse( Status: TReplyStatus );
begin

   StatusBar.SimpleText := Status.FromIpAddress + ' responded';
   case Status.ReplyStatusType of

   //------
   rsECHO :
    begin     // target host has responded
      Report( CurrentTTL, GetTickCount-PingStart, Status, 'Eseguito!' );  // done!
      StatusBar.SimpleText := 'done.';
    end;

   //------
   rsErrorTTLExceeded:
     begin  // Time-To-Live exceeded for an ICMP response.
        Report( CurrentTTL, GetTickCount-PingStart, Status, 'Ok' );
        PingNext;
     end;

   //-------
   rsTimeOut :
     begin // - Timeout occurred before a response was received.
        Report( CurrentTTL, GetTickCount-PingStart, Status, 'Time out' );
        PingNext;
     end;

   //-------
   rsErrorUnreachable:
     begin // - Destination unreachable
       Report( CurrentTTL, GetTickCount-PingStart, Status, 'DEST_UNREACH' );
       StatusBar.SimpleText := 'destination unreachable!';
     end;

   //------
   rsError:
     begin // - An error has occurred.
       Report( CurrentTTL, GetTickCount-PingStart, Status, 'ERROR' );
       PingNext;
     end;
   end   // case
end;





end.
