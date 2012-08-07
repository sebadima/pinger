{***************************************************************
 *
 * Project    : Connection Alive
 * Unit Name  : Main
 * Purpose    : Pinger like
 * NOtes      : Demo for Windows only
 * Date       : 21/01/2005
 * Author     : Sebastiano Dimartina
 * History    :
 *
 ****************************************************************}

unit Main;

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
  TForm1 = class(TForm)
    IdAntiFreeze1: TIdAntiFreeze;
    Panel1: TPanel;
    memoHTML: TMemo;
    HTTP: TIdHTTP;
    StatusBar1: TStatusBar;
    ProgressBar1: TProgressBar;
    btnGo: TBitBtn;
    btnStop: TBitBtn;
    cbURL: TComboBox;
    cbProtocol: TComboBox;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    SSL: TIdConnectionInterceptOpenSSL;
    LogDebug: TIdLogDebug;
    Memo1: TMemo;
    Splitter1: TSplitter;
    mePostData: TMemo;
    edContentType: TEdit;
    edPostFile: TEdit;
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    edUsername: TEdit;
    edPassword: TEdit;
    Timer1: TTimer;
    GroupBox3: TGroupBox;
    CheckBox1: TCheckBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Help1: TMenuItem;
    Nascondi: TMenuItem;
    ControlBar2: TControlBar;
    Button3: TButton;
    Button4: TButton;
    ControlBar1: TControlBar;
    Button1: TButton;
    Button2: TButton;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Label3: TLabel;
    Edit1: TMenuItem;
    Connessione1: TMenuItem;
    estDownload1: TMenuItem;
    StopDownload1: TMenuItem;
    ClicksuDownload1: TMenuItem;
    HTMLCache1: TMenuItem;
    Calcolatrice1: TMenuItem;
    Opzioni2: TMenuItem;
    Sorgenti1: TMenuItem;
    Autore1: TMenuItem;
    DatiNumerici1: TMenuItem;
    N1: TMenuItem;
    Help2: TMenuItem;
    Label6: TLabel;
    N2: TMenuItem;
    N3: TMenuItem;
    Esci: TMenuItem;
    Timer2: TTimer;
    Timer3: TTimer;
    GroupBox2: TGroupBox;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    BitBtn1: TBitBtn;
    Sistema1: TMenuItem;
    N4: TMenuItem;
    StrumentiWindows1: TMenuItem;
    Netstata1: TMenuItem;
    N5: TMenuItem;
    raceroute1: TMenuItem;
    Netaccounts1: TMenuItem;
    Netuser1: TMenuItem;
    netconfigworkstation1: TMenuItem;
    netconfigserve1: TMenuItem;
    netstatistics1: TMenuItem;
    netview1: TMenuItem;
    netlocalgroup1: TMenuItem;
    arpa1: TMenuItem;
    Netstatas1: TMenuItem;
    netstatafindLISTENING1: TMenuItem;
    nbtstatn1: TMenuItem;
    routePRINT1: TMenuItem;
    N8551: TMenuItem;
    Button5: TButton;
    Copia1: TMenuItem;
    Icolla1: TMenuItem;
    Elimina1: TMenuItem;
    Cancella1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Annulla1: TMenuItem;
    aglia1: TMenuItem;
    SolaLettura1: TMenuItem;
    N6: TMenuItem;
    processiattivi1: TMenuItem;
    Attivitasistema1: TMenuItem;
    N9: TMenuItem;
    Nettime1: TMenuItem;
    procedure btnGoClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbURLChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HTTPStatus(axSender: TObject; const axStatus: TIdStatus;
      const asStatusText: string);
    procedure HTTPWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HTTPWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure cbProtocolChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edPostFileExit(Sender: TObject);
    procedure mePostDataExit(Sender: TObject);
    procedure cbSSLClick(Sender: TObject);
    procedure LogDebugLogItem(ASender: TComponent; var AText: string);
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Autore1Click(Sender: TObject);
    procedure NascondiClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure HTMLCache1Click(Sender: TObject);
    procedure Calcolatrice1Click(Sender: TObject);
    procedure ClicksuDownload1Click(Sender: TObject);
    procedure estDownload1Click(Sender: TObject);
    procedure StopDownload1Click(Sender: TObject);
    procedure Opzioni2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Autore2Click(Sender: TObject);
    procedure Sorgenti1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DatiNumerici1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Help2Click(Sender: TObject);
    procedure EsciClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure SalvaDimensioniFinestra();
    procedure Sistema1Click(Sender: TObject);
    procedure racert1Click(Sender: TObject);
    function  SoloIntranet():Boolean;
    procedure Netstata1Click(Sender: TObject);
    procedure Netstata2Click(Sender: TObject);
    procedure netstatafindLISTENING1Click(Sender: TObject);
    procedure N8551Click(Sender: TObject);
    procedure Netuser1Click(Sender: TObject);
    procedure Netaccounts1Click(Sender: TObject);
    procedure netconfigworkstation1Click(Sender: TObject);
    procedure netconfigserve1Click(Sender: TObject);
    procedure netstatistics1Click(Sender: TObject);
    procedure netview1Click(Sender: TObject);
    procedure netlocalgroup1Click(Sender: TObject);
    procedure arpa1Click(Sender: TObject);
    procedure nbtstatn1Click(Sender: TObject);
    procedure routePRINT1Click(Sender: TObject);
    procedure Copia1Click(Sender: TObject);
    procedure Icolla1Click(Sender: TObject);
    procedure Elimina1Click(Sender: TObject);
    procedure Cancella1Click(Sender: TObject);
    procedure Annulla1Click(Sender: TObject);
    procedure aglia1Click(Sender: TObject);
    procedure SolaLettura1Click(Sender: TObject);
    procedure processiattivi1Click(Sender: TObject);
    procedure Attivitasistema1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Nettime1Click(Sender: TObject);
  private
    bPostFile: Boolean;
  public
  end;

var
  Form1: TForm1;

implementation

uses Unit1, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit9, Unit11, Unit10,
  Info, Unit12, Unit13, Unit14, Unit15, Unit16, Unit17, Unit18;

{$R *.DFM}



function TForm1.SoloIntranet():Boolean;
var
inifile, desk_inifile: TIniFile;
b_SoloIntranet       : boolean;
b_IndirizzoEsterno   : boolean;
begin

  inifile:= TInifile.create('.\PINGER.INI');
  try
    b_SoloIntranet := inifile.ReadBool( 'TCP_Options', 'Form3.AutorizzaIntranet.Checked', b_SoloIntranet );
  finally
    inifile.free
  end;

  if ((AnsiContainsStr(Form1.cbURL.Text, '127.0')) = False) AND ((AnsiContainsStr(Form1.cbURL.Text, '192.168')) = False) Then
    b_IndirizzoEsterno := True;

  if (b_SoloIntranet = True) And (b_IndirizzoEsterno = True) Then
    Result := True
  else
    Result := False;
end;



procedure TForm1.btnGoClick(Sender: TObject);
var
Source: TMemoryStream;
Response: TStringStream;
begin

  if(SoloIntranet() = True) then
  begin
    showmessage(' Hai abilitato il flag ''Autorizza solo indirizzi Intranet'' nelle Opzioni Tcp/Ip.');
    exit;
  end;

  if (Form1.CheckBox1.Checked = False) then
  begin

  if cbURL.Items.IndexOf(cbURL.Text) = -1 then
    cbURL.Items.Add(cbURL.Text);
  Screen.Cursor := crHourGlass;
  btnStop.Enabled := True;
  btnGo.Enabled := False;
  try
    memoHTML.Clear;
    // Set the properties for HTTP
    HTTP.Request.Username := edUsername.Text;
    HTTP.Request.Password := edPassword.Text;


    if Form3.cbProxy.Checked = True  then
    begin
      HTTP.Request.ProxyServer := Form3.edProxyServer.Text;
      HTTP.Request.ProxyPort   := StrToIntDef(Form3.edProxyPort.Text, 80);
    end
    else
    begin
      HTTP.Request.ProxyServer := '';
      HTTP.Request.ProxyPort   := 80;
    end;



    HTTP.Request.ContentType := edContentType.Text;
    if Form3.cbSSL.Checked then
    begin
      HTTP.Intercept := SSL;
    end
    else
    begin
      HTTP.Intercept := LogDebug;
      HTTP.InterceptEnabled := true;
    end;

    case Form3.cbMethod.ItemIndex of
      0: // Head
        begin
          HTTP.Head(cbURL.Text);
          memoHTML.Lines.Add('This is an example of some of the headers returned: ');
          memoHTML.Lines.Add('---------------------------------------------------');
          memoHTML.Lines.Add('Content-Type: ' + HTTP.Response.ContentType);
          memoHTML.Lines.Add('Date: ' + DatetoStr(HTTP.Response.Date));
          memoHTML.Lines.Add('');
          memoHTML.Lines.Add('You can view all the headers by examining HTTP.Response');
        end;
      1: // Get
        begin
          memoHTML.Lines.Text := HTTP.Get(cbURL.Text);
        end;
      2: // Post
        begin
          Response := TStringStream.Create('');
          try
            if not bPostFile then
              HTTP.Post(cbURL.Text, mePostData.Lines, Response)
            else
            begin
              Source := TMemoryStream.Create;
              try
                Source.LoadFromFile(edPostFile.Text);
                HTTP.Post(cbURL.Text, Source, Response);
              finally
                Source.Free;
              end;
            end;
            memoHTML.Lines.Text := Response.DataString;
          finally
            Response.Free;
          end;
        end;
    end;
  finally
    Screen.Cursor := crDefault;
    btnStop.Enabled := False;
    btnGo.Enabled := True;
  end;
  end; // end of if looping ping

end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  IPForm.btnClearClick(Self);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  btnStop.Enabled := False;
  Form3.cbMethod.ItemIndex := 1; // Set to GET
  cbProtocol.ItemIndex := 0; // Set to 1.0
  cbProtocol.OnChange(nil);
  bPostFile := False;
  // Load history
  if FileExists(ExtractFilePath(ParamStr(0)) + 'history.dat') then
  begin
    cbURL.Items.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'history.dat');
  end;
end;

procedure TForm1.cbURLChange(Sender: TObject);
begin
  btnGo.Enabled := Length(cbURL.Text) > 0;
  Form3.cbSSL.Checked := Pos('HTTPS', UpperCase(cbURL.Text)) > 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Set the progress bar
  ProgressBar1.Parent := StatusBar1;
  ProgressBar1.Top    := 2;
  ProgressBar1.Left   := 1;

end;

procedure TForm1.HTTPStatus(axSender: TObject; const axStatus: TIdStatus;
  const asStatusText: string);
begin
  StatusBar1.Panels[1].Text := asStatusText;
end;

procedure TForm1.HTTPWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
  ProgressBar1.Position := 0;
  ProgressBar1.Max := AWorkcountMax;
  if AWorkCountMax > 0 then
    StatusBar1.Panels[1].Text := 'Trasferimento: ' + IntToStr(AWorkCountMax);
end;

procedure TForm1.HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  StatusBar1.Panels[1].Text := 'Fatto';
  ProgressBar1.Position := 0;
end;


procedure TForm1.SalvaDimensioniFinestra();
Var
  inifile: TIniFile;
  wp: TWindowPlacement;
begin

  inifile:= TInifile.create('.\desktop.ini');
  try
    wp.length := Sizeof(wp);
    GetWindowPlacement( form1.handle, @wp );
    With Inifile, wp.rcNormalPosition Do Begin
    WriteInteger('Desktop_Options', 'Left', Left );
    WriteInteger('Desktop_Options', 'Top' , Top );
    WriteInteger('Desktop_Options', 'sWidth', Right-Left );
    WriteInteger('Desktop_Options', 'sHeight', Bottom-Top );
    WriteString ('Desktop_Options', 'sState', GetEnumName( TypeInfo( TwindowState ), Ord( form1.WindowState )));
    end;
  finally
    inifile.free
  end;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
Var
  inifile: TIniFile;
  wp: TWindowPlacement;
begin
  btnStop.OnClick(nil);
  try
    cbURL.Items.SaveToFile(ExtractFilePath(ParamStr(0)) + 'history.dat');
  except
  end;
  SalvaDimensioniFinestra();
end;

procedure TForm1.HTTPWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  if ProgressBar1.Max > 0 then
  begin
    StatusBar1.Panels[1].Text := IntToStr(AWorkCount) + ' bytes di ' +
      IntToStr(ProgressBar1.Max) + ' bytes.';
    ProgressBar1.Position := AWorkCount;
  end
  else
    StatusBar1.Panels[1].Text := IntToStr(AworkCount) + ' bytes.';
end;

procedure TForm1.cbProtocolChange(Sender: TObject);
begin
  case cbProtocol.ItemIndex of
    0: HTTP.ProtocolVersion := pv1_0;
    1: HTTP.ProtocolVersion := pv1_1;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edPostFile.Text := OpenDialog1.FileName;
    edPostFile.OnExit(nil);
  end;
end;

procedure TForm1.edPostFileExit(Sender: TObject);
begin
  if Length(edPostFile.Text) > 0 then
  begin
    mePostData.Clear;
    bPostFile := True;
  end;
end;

procedure TForm1.mePostDataExit(Sender: TObject);
begin
  if mePostData.Lines.Count > 0 then
  begin
    edPostFile.Text := '';
    bPostFile := False;
  end;
end;

procedure TForm1.cbSSLClick(Sender: TObject);
var
  p: Integer;
begin
  // check if the url has proper protocol set
  if Form3.cbSSL.Checked then
  begin
    if Pos('HTTPS', UpperCase(cbURL.Text)) <= 0 then
    begin
      p := Pos('://', UpperCase(cbURL.Text));
      if p > 0 then
      begin
        cbURL.Text := 'https://' + Copy(cbURL.Text, p + 3, Length(cbURL.Text) -
          (p + 2));
      end
      else
      begin
        cbURL.Text := 'https://' + cbURL.Text;
      end;
    end;
  end
  else
  begin
    if Pos('HTTPS', UpperCase(cbURL.Text)) > 0 then
    begin
      p := Pos('://', UpperCase(cbURL.Text));
      cbURL.Text := 'http://' + Copy(cbURL.Text, p + 3, Length(cbURL.Text) - (p
        + 2));
    end;
  end;

end;

procedure TForm1.LogDebugLogItem(ASender: TComponent;
  var AText: string);
begin
  Memo1.Lines.Add(AText);
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var
  inizio, durata : LongInt;
begin

  if(SoloIntranet() = True)  And (checkbox1.Checked = True) then
  begin
    showmessage(' Hai abilitato il flag ''Autorizza solo indirizzi Intranet'' nelle Opzioni Tcp/Ip.');
    exit;
  end;

  if checkbox1.Checked = True then
  begin
    //inizio := GetTickCount;
    //if (Form3.LanciaPing.Checked  = True )  then
    //  btnGoClick(self);
    //durata:= (GetTickCount - inizio);
    //Form4.Table1.AppendRecord([durata, 0]);
    //Form4.dbchart1.RefreshData();
    //Form6.Table1.Refresh;
    FrmPing.EseguiPing(self);
   end
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  timer1.Interval := spinedit1.value * 1000;
end;

procedure TForm1.Autore1Click(Sender: TObject);
begin
  AboutBox.Show();
end;

procedure TForm1.NascondiClick(Sender: TObject);
begin
  ShowWindow( Application.handle, SW_HIDE );
  Form1.Hide;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowWindow( Application.handle, SW_HIDE );
  Form1.Hide;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form3.Show();
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Form4.Show
end;



procedure TForm1.HTMLCache1Click(Sender: TObject);
begin
  if(SoloIntranet() = True) then
  begin
    showmessage(' Hai abilitato il flag ''Autorizza solo indirizzi Intranet'' nelle Opzioni Tcp/Ip.');
    exit;
  end;

  Form2.Show();
  Form2.WebBrowser1.Navigate(cburl.text);
end;


procedure TForm1.Calcolatrice1Click(Sender: TObject);
var
  a : Array[0..MAX_PATH] of char;
  MyPointer : Pchar;
begin

  // WinExec('ecalc.exe', SW_SHOWNORMAL);
  GetSystemDirectory(a, sizeof(a));
  // ShowMessage(StrPas(a)+'\calc.exe');
  Strcat(a, '\calc.exe');
  MyPointer := a;
  WinExec(MyPointer, SW_SHOWNORMAL);
end;

procedure TForm1.ClicksuDownload1Click(Sender: TObject);
begin
  Form4.Show();
  Form6.Close();
end;

procedure TForm1.estDownload1Click(Sender: TObject);
begin
  Form1.btnGoClick(self);
end;

procedure TForm1.StopDownload1Click(Sender: TObject);
begin
  Form1.btnStopClick(self);
end;

procedure TForm1.Opzioni2Click(Sender: TObject);
begin
  Form3.Show();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Form4.Show();
  Form6.Close();
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Form4.Close();
  Form6.Show();
end;

procedure TForm1.Autore2Click(Sender: TObject);
begin
  AboutBox.Show();
end;

procedure TForm1.Sorgenti1Click(Sender: TObject);
begin
  AboutBox1.Show();
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  if MessageDlg('Sei sicuro di volere Uscire?',     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      CanClose := True;
    end
  else
      CanClose := False;
  end;  //end if

procedure TForm1.DatiNumerici1Click(Sender: TObject);
begin
  Form4.Close();
  Form6.Show();
end;




procedure TForm1.FormPaint(Sender: TObject);
Var
  inifile: TIniFile;
begin
  inifile:= TInifile.create('.\PINGER.INI');
  try
    Memo1.Font.Color  := inifile.ReadInteger( 'Main_Options', 'Form3.PrimoPiano.SelectedColor',    Form3.PrimoPiano.SelectedColor );
    Memo1.Color       := inifile.ReadInteger( 'Main_Options', 'Form3.Sfondo.SelectedColor',        Form3.Sfondo.SelectedColor );
    Memo1.Font.Name   := inifile.Readstring ( 'Main_Options', 'Form3.FontDialog1.Font.Name',       Form3.FontDialog1.Font.Name );
    Memo1.Font.Size   := inifile.ReadInteger( 'Main_Options', 'Form3.FontDialog1.Font.Size',       Form3.FontDialog1.Font.Size );

  finally
    inifile.free
  end;
end;



procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if Form3.AzzeraLog.Checked = True  then
  begin
    Memo1.Clear;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Form12.Show;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  if spinedit1.value < 0 then
    spinedit1.value :=0;
  timer1.Interval := spinedit1.value * 1000;
end;

procedure TForm1.Help2Click(Sender: TObject);
begin
  Form10.Button20Click(Self);
end;

procedure TForm1.EsciClick(Sender: TObject);
begin
  if MessageDlg('Sei sicuro di volere Uscire?',     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    SalvaDimensioniFinestra();
    Application.Terminate;
  end;
end;


procedure TForm1.Timer2Timer(Sender: TObject);
var inifile: TIniFile;
var b_AvviaMinimizzato: boolean;
begin

  inifile:= TInifile.create('.\PINGER.INI');
  try
    b_AvviaMinimizzato := inifile.ReadBool( 'Main_Options', 'Form3.AvviaMinimizzato.Checked',    Form3.AvviaMinimizzato.Checked );
  finally
    inifile.free
  end;

  if b_AvviaMinimizzato = True then
  begin
    ShowWindow( Application.handle, SW_HIDE );
    Form1.Hide;
  end;
  Form1.Timer2.Enabled := False;


end;














procedure TForm1.Timer3Timer(Sender: TObject);
var inifile, desk_inifile: TIniFile;
var b_MostraSplashScreen: boolean;
var b_SalvaPosizione    : boolean;
var i: integer;
var s: string;
begin
  inifile:= TInifile.create('.\PINGER.INI');
  try
    b_MostraSplashScreen := inifile.ReadBool   ( 'Main_Options', 'Form3.MostraSplashScreen.Checked', Form3.MostraSplashScreen.Checked );
    b_SalvaPosizione     := inifile.ReadBool   ( 'Main_Options', 'Form3.SalvaPosizione.Checked'    , Form3.SalvaPosizione.Checked     );
  finally
    inifile.free
  end;

  if b_MostraSplashScreen = True then
  begin
    Form1.Memo1.Lines.Add('');
    Form1.Memo1.Lines.Add('** Integra di Sebastiano Dimartina - Via Acradina,1 96100 Siracusa');
    Form1.Memo1.Lines.Add('');
    Form1.Memo1.Lines.Add('** P.Iva 01236100895 C.F. DMR SST 63D04I 754T');
    Form1.Memo1.Lines.Add('');
    Form1.Memo1.Lines.Add('** Tel.334-3469878');
    Form1.Memo1.Lines.Add('');
  end;

  if b_SalvaPosizione = True then
  begin
    desk_inifile:= TInifile.create('.\desktop.ini');
    try
      form1.Left   := desk_inifile.ReadInteger('Desktop_Options', 'Left',   i );
      form1.Top    := desk_inifile.ReadInteger('Desktop_Options', 'Top' ,   i );
      form1.Width  := desk_inifile.ReadInteger('Desktop_Options', 'sWidth', i );
      form1.Height := desk_inifile.ReadInteger('Desktop_Options', 'sHeight',i );
      s            := desk_inifile.Readstring ('Desktop_Options', 'sState', s);
      form1.Windowstate := TWindowState( GetEnumValue( TYpeinfo(TWindowState), s));
    finally
      desk_inifile.free
    end;
  end;
  Form1.Timer3.Enabled := False;
end;

procedure TForm1.Sistema1Click(Sender: TObject);
begin
  Form8.Show;
  
end;

procedure TForm1.racert1Click(Sender: TObject);
begin

  if(SoloIntranet() = True) then
  begin
    showmessage(' Hai abilitato il flag ''Autorizza solo indirizzi Intranet'' nelle Opzioni Tcp/Ip.');
    exit;
  end;

  Form1.Memo1.Lines.Add('  ');
  Form1.Memo1.Lines.Add(' ***');
  Form1.Memo1.Lines.Add(' Traceroute verso indirizzo: ' + AnsiReplaceStr(Form1.cbURL.Text, 'http://', ''));
  Form1.Memo1.Lines.Add(' ');
  Form9.sbTraceClick(Self);
  Form1.Memo1.Lines.Add(' ***');

end;

procedure TForm1.Netstata1Click(Sender: TObject);
begin
  Form10.Button2Click(Self);
end;

procedure TForm1.Netstata2Click(Sender: TObject);
begin
  Form10.Button1Click(Self);
end;

procedure TForm1.netstatafindLISTENING1Click(Sender: TObject);
begin
  Form10.Button4Click(Self);
end;

procedure TForm1.N8551Click(Sender: TObject);
begin
  Form10.Button5Click(Self);
end;

procedure TForm1.Netuser1Click(Sender: TObject);
begin
  Form10.Button6Click(Self);
end;

procedure TForm1.Netaccounts1Click(Sender: TObject);
begin
  Form10.Button7Click(Self);
end;

procedure TForm1.netconfigworkstation1Click(Sender: TObject);
begin
  Form10.Button8Click(Self);
end;

procedure TForm1.netconfigserve1Click(Sender: TObject);
begin
  Form10.Button9Click(Self);
end;

procedure TForm1.netstatistics1Click(Sender: TObject);
begin
  Form10.Button10Click(Self);
end;

procedure TForm1.netview1Click(Sender: TObject);
begin
  Form10.Button11Click(Self);
end;

procedure TForm1.netlocalgroup1Click(Sender: TObject);
begin
  Form10.Button12Click(Self);
end;

procedure TForm1.arpa1Click(Sender: TObject);
begin
  Form10.Button13Click(Self);
end;

procedure TForm1.nbtstatn1Click(Sender: TObject);
begin
  Form10.Button14Click(Self);
end;

procedure TForm1.routePRINT1Click(Sender: TObject);
begin
  Form10.Button15Click(Self);
end;

procedure TForm1.Copia1Click(Sender: TObject);
begin
  Memo1.CopyToClipboard;
end;

procedure TForm1.Icolla1Click(Sender: TObject);
begin
  Memo1.PasteFromClipboard;
end;

procedure TForm1.Elimina1Click(Sender: TObject);
begin

  If Form1.SolaLettura1.Checked = False then
    Memo1.Clear;
end;

procedure TForm1.Cancella1Click(Sender: TObject);
begin
  Memo1.ClearSelection;
end;

procedure TForm1.Annulla1Click(Sender: TObject);
begin
  Memo1.Perform(EM_UNDO, 0, 0);
end;

procedure TForm1.aglia1Click(Sender: TObject);
begin
  Memo1.CutToClipboard;
end;

procedure TForm1.SolaLettura1Click(Sender: TObject);
begin
  Form1.Memo1.ReadOnly := NOT Form1.Memo1.ReadOnly;
  SolaLettura1.Checked := NOT SolaLettura1.Checked;
end;

procedure TForm1.processiattivi1Click(Sender: TObject);
begin
  Form13.Button1Click(Self);
end;

procedure TForm1.Attivitasistema1Click(Sender: TObject);
begin
  UptimeForm.Show;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Form15.Show;
end;

procedure TForm1.Nettime1Click(Sender: TObject);
begin
  Form15.Timer1Timer(Self);
end;

end.

