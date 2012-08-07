unit Unit7;

interface

uses
  {$IFDEF Linux}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  {$ELSE}
  windows, messages, graphics, controls, forms, dialogs, stdctrls, extctrls,
  {$ENDIF}
  StrUtils, SysUtils, Classes, IdIcmpClient, IdBaseComponent, IdComponent,
  Inifiles,IdRawBase, IdRawClient, DateUtils;


type
  TfrmPing = class(TForm)
  ICMP: TIdIcmpClient;
  procedure EseguiPing(Sender: TObject);
  procedure ICMPReply(ASender: TComponent; const ReplyStatus: TReplyStatus);
  private
  public
  end;

var
  frmPing: TfrmPing;

implementation

uses Main, Unit4, Unit6, Unit3;
{$IFDEF MSWINDOWS}{$R *.dfm}{$ELSE}{$R *.xfm}{$ENDIF}


procedure TfrmPing.EseguiPing(Sender: TObject);
var host, str_timeout, str_payload: String;
var timeout, payload              : Integer;

begin
  ICMP.OnReply := ICMPReply;
  try
    host := AnsiReplaceStr(Form1.cbURL.Text, 'http://', '');

    str_timeout := LeftStr(Form3.TimeoutPing.Items[Form3.TimeoutPing.ItemIndex], 6);
    str_timeout := AnsiReplaceStr(str_timeout, ' ', '');
    if Length(str_timeout) > 0 then
      timeout := strtoint(str_timeout)
      else timeout := 999;
    //showmessage('timeout **'+ inttostr(timeout) +'**');

    str_payload := LeftStr(Form3.PayloadPing.Items[Form3.PayloadPing.ItemIndex], 6);
    str_payload := AnsiReplaceStr(str_payload, ' ', '');
    if Length(str_payload) > 0 then
      payload := strtoint(str_payload)
      else payload := 256;
    //showmessage('payload **'+ inttostr(payload) +'**');


    ICMP.Host := host;
    ICMP.ReceiveTimeout := timeout;
    ICMP.BufferSize := payload;
    ICMP.Ping;
    Application.ProcessMessages;
  finally
  end;
end;



procedure TfrmPing.ICMPReply(ASender: TComponent; const ReplyStatus: TReplyStatus);
var
sTime, s_Data, s_Ora: string;
inifile: TIniFile;
b_MemorizzaData:   boolean;
b_MemorizzaMinSec: boolean;
begin

  if (ReplyStatus.MsRoundTripTime = 0) then
    sTime := '<1'
  else
    sTime := '=';

  inifile:= TInifile.create('.\PINGER.INI');
  try
    b_MemorizzaData   := inifile.ReadBool( 'Main_Options', 'Form3.MemorizzaData.Checked',   b_MemorizzaData   );
    b_MemorizzaMinSec := inifile.ReadBool( 'Main_Options', 'Form3.MemorizzaMinSec.Checked', b_MemorizzaMinSec );
  finally
    inifile.free
  end;


  s_Data := ' lì ';
  if b_MemorizzaData = True then
    s_Data := s_Data + datetostr(Today())
  else
    s_Data := '';

  s_Ora  := 'ore->';
  if b_MemorizzaMinSec = True then
    s_Ora := s_Ora + timetostr(Now())
  else
    s_Ora := '';


  Form1.Memo1.Lines.Add(Format('%s %s %d bytes da %s: sequenza=%d ttl=%d tempo %s%d Ms',
 [s_Data,
  s_Ora,
  ReplyStatus.BytesReceived,
  ReplyStatus.FromIpAddress,
  ReplyStatus.SequenceId,
  ReplyStatus.TimeToLive,
  sTime,
  ReplyStatus.MsRoundTripTime]));

  Form4.Table1.AppendRecord([ReplyStatus.MsRoundTripTime, 0]);
  Form4.dbchart1.RefreshData();
  Form6.Table1.Refresh;


end;

end.
