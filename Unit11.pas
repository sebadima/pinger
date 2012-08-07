unit Unit11;

//***************************************************************************//
//                 Delphi  NETWORK INTERFACE MONITOR                         //
//***************************************************************************//
//                                                                           //
//  Tested on   :  Delphi 4.03, Delphi 6.0 Enterprise,                       //
//                 WIN-NT4/SP6, WIN2K, WIN98se                               //
//***************************************************************************//
//                    This software is FREEWARE                              //
//  If this software works, it was surely written by Dirk Claessens          //
//                      <dirkcl@pandora.be>                                  //
//  (If it doesn't, I don't know anything about it.)                         //
//***************************************************************************//


(* definitions

sample interval     : time interval between samples ( fixed 1000ms interval )
octets/sec. in/out  : number of octets IN/OUT from/to adapter in previous
------------------    one second period

peak in/out per sec.: highest number of octets IN/OUT measured during observation
-------------------   period.

avg. in/out per sec. : accumulated sample average over observation period
-------------------


NOTES:
------
1/ internet traffic is bursty by nature, so for calculation of average
   values zero values are _not_ used. A separate sample counter is
   maintained for each interface ( ActiveCountIn/Out ), which only counts
   samples with byte count <> 0.
   Example: say  500 samples were taken. if only 400 of them contain data,
   the accumulated average is calculated from Totalcount/400 seconds, not 500.

2/ Peak values _may_ show figures exceeding the theoretical maximum bitrate
   for an adapter. This is caused by sampling artefacts, and the internal
   - unknown :0) - workings of IpHlpAPI.dll. 

*)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, IPHelper, IPHLPAPI, StdCtrls, ComCtrls, Buttons, Grids;

const
   version = '2.0';
type
  TIPForm = class( TForm )
    Timer1: TTimer;
    btnStartCap: TSpeedButton;
    btnStopCap: TSpeedButton;
    btnClear: TSpeedButton;
    btnQuit: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Timer1Timer( Sender: TObject );
    procedure FormCreate( Sender: TObject );
    procedure btnStartCapClick(Sender: TObject);
    procedure btnStopCapClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbOnTopClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
  private
    { Private declarations }
    function GetIPFromIFIndex( InterfaceIndex: integer ): string;
    procedure InitGrid( MibArr: IpHlpAPI.TMibIFArray );
    procedure CaptureMIBData( InitFlag: boolean );
    procedure ClearCounters;
    procedure Data2Grid( MIBArr: IpHlpAPI.TMIBIFArray );
  public
    { Public declarations }
  end;

  // statistics data for each interface
  TStatistics = record
    dwInterfaceIndex: DWORD;
    ActiveCountIn,      { count of samples where something was received }
    ActiveCountOut,     { count of samples where something was sent     }
    PrevCountIn,        { previous byte count in }
    PrevCountOut,       { previous byte count out}
    TotalIn,            { total byte count in    }
    TotalOut,           { total byte count out   }
    InPerSec,           { byte count in of last sample period }
    OutPerSec,          { byte count out of last sample period }
    PeakInPerSec,       { peak byte count in/out }
    PeakOutPerSec : DWORD;
  end;
  TStatArr = array of TStatistics;


var
  IPForm      : TIPForm;
  StatArr     : TStatArr;

implementation

uses Main;

{$R *.DFM}


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TIPForm.FormCreate( Sender: TObject );
begin
  ClearCounters;
  btnStartCap.Enabled := false;
  btnStopCap.Enabled  := true;
  ClearCounters;
  Timer1.Enabled := true;

  Timer1.Interval := 1000;
  CaptureMIBData( true );
end;

//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TIPForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Timer1.OnTimer := nil;
   Action := caFREE;
end;

//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TIPForm.btnQuitClick(Sender: TObject);
begin
  Close;
end;


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TIPForm.cbOnTopClick(Sender: TObject);
begin
end;



//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TIPForm.Timer1Timer( Sender: TObject );
begin
  Timer1.Enabled := false;
  CaptureMIBData( false );
  Timer1.Enabled := true;
end;


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TIPForm.btnStartCapClick(Sender: TObject);
begin
  btnStartCap.Enabled := false;
  btnStopCap.Enabled  := true;
  ClearCounters;
  Timer1.Enabled := true;
end;


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TIPForm.btnStopCapClick(Sender: TObject);
begin
  btnStartCap.Enabled := true;
  btnStopCap.Enabled  := false;;
  Timer1.Enabled := false;
end;


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TIPForm.btnClearClick(Sender: TObject);
begin
  ClearCounters;
end;




//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
// get MIB data and init or show data
procedure TIPForm.CaptureMIBData( InitFlag: boolean );

var
 MibArr : IpHlpAPI.TMIBIfArray;
begin
  Get_IfTableMIB( MibArr );  // get current MIB data
  if InitFlag  then
    InitGrid( MibArr ) // initialise grid & counters
  else
    Data2Grid( MibArr );  // show data
end;



//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TIPForm.ClearCounters;
begin
 CaptureMIBData( true );
 CaptureMIBData( false);
end;

//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure TIPForm.Data2Grid( MIBArr: IpHlpAPI.TMIBIFArray );
var
 i : integer;
begin

  for i := low(MIBArr) to High(MIBArr) do
    with MIBArr[i] do
    begin

     with StatArr[i] do
     begin
       InPerSec  := dwInOctets - PrevCountIn;
       inc(TotalIn, InPerSec);
       if InPerSec > 0 then
          inc(ActivecountIn);
       PrevCountIn := dwInOctets;
       //
       OutPerSec := dwOutOctets - PrevCountOut;
       inc(TotalOut,OutPerSec);
       if OutPerSec > 0 then
          inc(ActivecountOut);
       PrevCountOut  := dwOutOctets;
       // peak values
       if InPerSec > PeakInPerSec then
           PeakInPersec := InPersec;
       if OutPerSec > PeakOutPerSec then
           PeakOutPerSec := OutPerSec;

       // update grid
        if (i=0) then
        begin
        //showmessage(IntToStr( PeakInPerSec ));
        Form1.edit7.Text :=(IntToStr( InPerSec ));
        Form1.edit8.Text :=(IntToStr( PeakInPerSec ));
        //edit2.Text :=(IntToStr( InPerSec ));
        end;


        if (ActiveCountIn > 0)  and  (i=0)  then
        begin
        Form1.edit9.Text :=(IntToStr( TotalIn div ActiveCountIn ))
        end
        else
                //showmessage(IntToStr( OutPerSec ));



                        //showmessage(IntToStr(PeakOutPerSec));



        if ActiveCountOut > 0 then
        else
     end;


    end;
end;

//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
function TIPForm.GetIPFromIFIndex( InterfaceIndex: integer ): string;
var
 i:  integer;
 IPArr : TMIBIPAddrArray;
begin
   Result := '!not_found!';  // shouldn't happen...
   Get_IPAddrTableMIB( IpArr );  // get IP-address table
   if Length(IPArr) > 0 then
     for i := low(IPArr) to High(IPArr) do  // look for matching index...
       if IPArr[i].dwIndex = InterfaceIndex then
       begin
         Result := IPAddr2Str(IParr[i].dwAddr);
         BREAK;
       end;
end;


//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
// initialise stat variables & grid
procedure TIpForm.InitGrid( MibArr: IpHlpAPI.TMibIFArray );
var
 i     : integer;
 IPArr : TMibIPAddrArray;

 Descr: string;
begin
  if Length(MibArr) > 0 then
  begin
    SetLength( StatArr, Length(MibArr));
    for i := low(MIBArr) to High(MIBArr) do
    with MIBArr[i] do
    begin
     StatArr[i].ActiveCountIn := 0;
     StatArr[i].ActiveCountOut:= 0;
     StatArr[i].PrevCountIn := dwInOctets;
     StatArr[i].PrevCountOut:= dwOutOctets;
     StatArr[i].TotalIn := 0;
     StatArr[i].TotalOut:= 0;
     StatArr[i].InPerSec:= 0;
     StatArr[i].OutPerSec:= 0;
     StatArr[i].PeakInPerSec := 0;
     StatArr[i].PeakOutPerSec:=0;
     SetLength( Descr, pred(dwDescrLen));
     move(bDescr, Descr[1], pred(dwDescrLen));
     // adapter description
     // adapter MAC address
     // adapter IP address
     //
    end;
  end;
end;

(*
  version history
  ---------------
 2.0
 ---
  add: mean in/out values
  add: stayinfront
  add: minor cosmetic changes
*)




end.
