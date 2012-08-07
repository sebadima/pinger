unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ColorGrd, Spin, ComCtrls, Buttons, Inifiles, ExtCtrls,
  fcCombo, fcColorCombo;

type
  TForm3 = class(TForm)
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    DefaultBtn: TBitBtn;
    PageControl: TPageControl;
    Preferences: TTabSheet;
    GroupBox2: TGroupBox;
    MemorizzaData: TCheckBox;
    UtilizzaLogFile: TCheckBox;
    MemorizzaMinSec: TCheckBox;
    AzzeraLog: TCheckBox;
    IncludiLog: TCheckBox;
    ExecutionPanel: TGroupBox;
    MostraSplashScreen: TCheckBox;
    SalvaPosizione: TCheckBox;
    AvviaMinimizzato: TCheckBox;
    TabSheet2: TTabSheet;
    GroupBox5: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    IdentificatiCome: TComboBox;
    BackupPanel: TGroupBox;
    AutorizzaIntranet: TCheckBox;
    GroupBox7: TGroupBox;
    IgnoraJavascript: TCheckBox;
    IgnoraActiveX: TCheckBox;
    IgnoraCookies: TCheckBox;
    CodeSheet: TTabSheet;
    GroupBox6: TGroupBox;
    GroupBox9: TGroupBox;
    Memo: TMemo;
    Params: TEdit;
    GroupBox8: TGroupBox;
    cbSSL: TCheckBox;
    cbMethod: TComboBox;
    edProxyServer: TEdit;
    edProxyPort: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    cbProxy: TCheckBox;
    SaveDialog1: TSaveDialog;
    ColorDialog1: TColorDialog;
    LogFileName: TEdit;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    ColorDialog2: TColorDialog;
    GroupBox10: TGroupBox;
    BitBtn4: TBitBtn;
    LanciaPing: TCheckBox;
    PayloadPing: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    TimeoutPing: TComboBox;
    UsaPingWin: TCheckBox;
    Label1: TLabel;
    Label9: TLabel;
    PrimoPiano: TfcColorCombo;
    Sfondo: TfcColorCombo;
    Label12: TLabel;
    Label13: TLabel;
    lbAccount: TLabel;
    lbPassword: TLabel;
    SMTPServer: TEdit;
    SMTPPort: TEdit;
    SMTPAccount: TEdit;
    SMTPPassword: TEdit;
    Label3: TLabel;
    MailProvider: TEdit;
    Label4: TLabel;
    MailRiscontro: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    FontFinestre: TComboBox;
    DimensioneFont: TEdit;
    Label5: TLabel;
    Button2: TButton;
    FontDialog1: TFontDialog;
    Panel1: TPanel;
    Esempio: TMemo;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    procedure OKButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure TestBtnClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cbProxyClick(Sender: TObject);
    procedure LanciaPingClick(Sender: TObject);
    procedure cbSSLClick(Sender: TObject);
    procedure UtilizzaLogFileClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure AggiornaFinestraFont();

    procedure PrimoPianoChange(Sender: TObject);
    procedure SfondoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1, Unit4, Main, Unit8;

{$R *.dfm}



procedure TForm3.AggiornaFinestraFont();
begin
  Form3.Esempio.Font.Color := Form3.PrimoPiano.SelectedColor;
  Form3.Esempio.Color      := Form3.Sfondo.SelectedColor;
  Form3.Esempio.Font.Name  := Form3.FontDialog1.Font.Name;
  Form3.Esempio.Font.Size  := Form3.FontDialog1.Font.Size;

  Form1.Memo1.Font.Color   := Form3.PrimoPiano.SelectedColor;
  Form1.Memo1.Color        := Form3.Sfondo.SelectedColor;
  Form1.Memo1.Font.Name    := Form3.FontDialog1.Font.Name;
  Form1.Memo1.Font.Size    := Form3.FontDialog1.Font.Size;
end;


procedure TForm3.OKButtonClick(Sender: TObject);
begin
  Close();
end;


procedure TForm3.Button1Click(Sender: TObject);
var Filename:string;
var FileExt :string;
begin

  Form3.SaveDialog1.FileName := Form3.LogFileName.Text;
  Form3.SaveDialog1.Filter := 'txt';
  Form3.SaveDialog1.DefaultExt := 'txt';
  if (Form3.SaveDialog1.Execute) = True Then
  begin
    Filename := Form3.SaveDialog1.FileName;
    form1.Memo1.Lines.SaveToFile(Filename);
  end;
end;


procedure TForm3.BitBtn5Click(Sender: TObject);
begin
  Memo.Clear;
end;

procedure TForm3.TestBtnClick(Sender: TObject);
Var
  inifile: TIniFile;

Begin
  inifile:= TInifile.create('.\PINGER.INI');
  try

   // solita rout.....

    inifile.WriteBool   ( 'Main_Options', 'Form3.UtilizzaLogFile.Checked',     Form3.UtilizzaLogFile.Checked );
    inifile.writestring ( 'Main_Options', 'Form3.LogFileName.Text',            Form3.LogFileName.Text);
    inifile.WriteBool   ( 'Main_Options', 'Form3.MemorizzaData.Checked',       Form3.MemorizzaData.Checked );
    inifile.WriteBool   ( 'Main_Options', 'Form3.AzzeraLog.Checked',           Form3.AzzeraLog.Checked );
    inifile.WriteBool   ( 'Main_Options', 'Form3.MemorizzaMinSec.Checked',     Form3.MemorizzaMinSec.Checked );
    inifile.WriteBool   ( 'Main_Options', 'Form3.IncludiLog.Checked',          Form3.IncludiLog.Checked );

    inifile.writestring ( 'Main_Options', 'Form3.FontDialog1.Font.Name',       Form3.FontDialog1.Font.Name );
    inifile.WriteInteger( 'Main_Options', 'Form3.FontDialog1.Font.Size',       Form3.FontDialog1.Font.Size);
    inifile.WriteInteger( 'Main_Options', 'Form3.PrimoPiano.SelectedColor',    Form3.PrimoPiano.SelectedColor );
    inifile.WriteInteger( 'Main_Options', 'Form3.Sfondo.SelectedColor',        Form3.Sfondo.SelectedColor );


    inifile.WriteBool   ( 'Main_Options', 'Form3.MostraSplashScreen.Checked',  Form3.MostraSplashScreen.Checked );
    inifile.WriteBool   ( 'Main_Options', 'Form3.AvviaMinimizzato.Checked',    Form3.AvviaMinimizzato.Checked );
    inifile.WriteBool   ( 'Main_Options', 'Form3.SalvaPosizione.Checked',      Form3.SalvaPosizione.Checked );





    inifile.WriteInteger( 'TCP_Options', 'Form3.IdentificatiCome.ItemIndex',   Form3.IdentificatiCome.ItemIndex );
    inifile.WriteBool   ( 'TCP_Options', 'Form3.AutorizzaIntranet.Checked',    Form3.AutorizzaIntranet.Checked );
    inifile.WriteBool   ( 'TCP_Options', 'Form3.LanciaPing.Checked',           Form3.LanciaPing.Checked );
    inifile.WriteBool   ( 'TCP_Options', 'Form3.UsaPingWin.Checked',           Form3.UsaPingWin.Checked );
    inifile.WriteInteger( 'TCP_Options', 'Form3.PayloadPing.ItemIndex',        Form3.PayloadPing.ItemIndex );
    inifile.WriteInteger( 'TCP_Options', 'Form3.TimeoutPing.ItemIndex',        Form3.TimeoutPing.ItemIndex );
    inifile.WriteBool   ( 'TCP_Options', 'Form3.cbProxy.Checked',              Form3.cbProxy.Checked );
    inifile.writestring ( 'TCP_Options', 'Form3.edProxyServer.Text',           Form3.edProxyServer.Text );
    inifile.writestring ( 'TCP_Options', 'Form3.edProxyPort.Text',             Form3.edProxyPort.Text );
    inifile.WriteBool   ( 'TCP_Options', 'Form3.IgnoraJavascript.Checked',     Form3.IgnoraJavascript.Checked );
    inifile.WriteBool   ( 'TCP_Options', 'Form3.IgnoraActiveX.Checked',        Form3.IgnoraActiveX.Checked );
    inifile.WriteBool   ( 'TCP_Options', 'Form3.IgnoraCookies.Checked',        Form3.IgnoraCookies.Checked );
    inifile.WriteBool   ( 'TCP_Options', 'Form3.cbSSL.Checked',                Form3.cbSSL.Checked );
    inifile.WriteInteger( 'TCP_Options', 'Form3.cbMethod.ItemIndex' ,          Form3.cbMethod.ItemIndex  );


    //inifile.writestring ( 'Email_Options', 'Form3.Memo.Text' ,            Form3.Memo.Text );
    inifile.writestring ( 'Email_Options', 'Form3.SMTPServer.Text'   ,    Form3.SMTPServer.Text );
    inifile.writestring ( 'Email_Options', 'Form3.SMTPPort.Text'     ,    Form3.SMTPPort.Text );
    inifile.writestring ( 'Email_Options', 'Form3.MailProvider.Text' ,    Form3.MailProvider.Text );
    inifile.writestring ( 'Email_Options', 'Form3.MailRiscontro.Text',    Form3.MailRiscontro.Text );
    inifile.writestring ( 'Email_Options', 'Form3.SMTPAccount.Text'  ,    Form3.SMTPAccount.Text );
    inifile.writestring ( 'Email_Options', 'Form3.SMTPPassword.Text' ,    Form3.SMTPPassword.Text );

  finally
    inifile.free
  end;
  Form3.Memo.Lines.SaveToFile('EmailText.txt');
  Close;
end;


procedure TForm3.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm3.FormPaint(Sender: TObject);

Var
  inifile: TIniFile;
Begin
  inifile:= TInifile.create('.\PINGER.INI');
  try

    Form3.UtilizzaLogFile.Checked   := inifile.ReadBool   ( 'Main_Options', 'Form3.UtilizzaLogFile.Checked',     Form3.UtilizzaLogFile.Checked );
    Form3.LogFileName.Text          := inifile.Readstring ( 'Main_Options', 'Form3.LogFileName.Text',            Form3.LogFileName.Text);
    Form3.MemorizzaData.Checked     := inifile.ReadBool   ( 'Main_Options', 'Form3.MemorizzaData.Checked',       Form3.MemorizzaData.Checked );
    Form3.AzzeraLog.Checked         := inifile.ReadBool   ( 'Main_Options', 'Form3.AzzeraLog.Checked',           Form3.AzzeraLog.Checked );
    Form3.MemorizzaMinSec.Checked   := inifile.ReadBool   ( 'Main_Options', 'Form3.MemorizzaMinSec.Checked',     Form3.MemorizzaMinSec.Checked );
    Form3.IncludiLog.Checked        := inifile.ReadBool   ( 'Main_Options', 'Form3.IncludiLog.Checked',          Form3.IncludiLog.Checked );
    Form3.FontFinestre.ItemIndex    := inifile.ReadInteger( 'Main_Options', 'Form3.FontFinestre.ItemIndex',      Form3.FontFinestre.ItemIndex );
    Form3.DimensioneFont.Text       := inifile.Readstring ( 'Main_Options', 'Form3.DimensioneFont.Text',         Form3.DimensioneFont.Text);
    Form3.MostraSplashScreen.Checked:= inifile.ReadBool   ( 'Main_Options', 'Form3.MostraSplashScreen.Checked',  Form3.MostraSplashScreen.Checked );
    Form3.AvviaMinimizzato.Checked  := inifile.ReadBool   ( 'Main_Options', 'Form3.AvviaMinimizzato.Checked',    Form3.AvviaMinimizzato.Checked );
    Form3.SalvaPosizione.Checked    := inifile.ReadBool   ( 'Main_Options', 'Form3.SalvaPosizione.Checked',      Form3.SalvaPosizione.Checked );

    Form3.FontDialog1.Font.Name     := inifile.Readstring ( 'Main_Options', 'Form3.FontDialog1.Font.Name',       Form3.FontDialog1.Font.Name );
    Form3.FontDialog1.Font.Size     := inifile.ReadInteger( 'Main_Options', 'Form3.FontDialog1.Font.Size',       Form3.FontDialog1.Font.Size );
    Form3.PrimoPiano.SelectedColor  := inifile.ReadInteger( 'Main_Options', 'Form3.PrimoPiano.SelectedColor',    Form3.PrimoPiano.SelectedColor );
    Form3.Sfondo.SelectedColor      := inifile.ReadInteger( 'Main_Options', 'Form3.Sfondo.SelectedColor',        Form3.Sfondo.SelectedColor );

    Form3.IdentificatiCome.ItemIndex:= inifile.ReadInteger( 'TCP_Options', 'Form3.IdentificatiCome.ItemIndex',   Form3.IdentificatiCome.ItemIndex );
    Form3.AutorizzaIntranet.Checked := inifile.ReadBool   ( 'TCP_Options', 'Form3.AutorizzaIntranet.Checked',    Form3.AutorizzaIntranet.Checked );
    Form3.LanciaPing.Checked        := inifile.ReadBool   ( 'TCP_Options', 'Form3.LanciaPing.Checked',           Form3.LanciaPing.Checked );
    Form3.UsaPingWin.Checked        := inifile.ReadBool   ( 'TCP_Options', 'Form3.UsaPingWin.Checked',           Form3.UsaPingWin.Checked );
    Form3.PayloadPing.ItemIndex     := inifile.ReadInteger( 'TCP_Options', 'Form3.PayloadPing.ItemIndex',        Form3.PayloadPing.ItemIndex );
    Form3.TimeoutPing.ItemIndex     := inifile.ReadInteger( 'TCP_Options', 'Form3.TimeoutPing.ItemIndex',        Form3.TimeoutPing.ItemIndex );
    Form3.cbProxy.Checked           := inifile.ReadBool   ( 'TCP_Options', 'Form3.cbProxy.Checked',              Form3.cbProxy.Checked );
    Form3.edProxyServer.Text        := inifile.Readstring ( 'TCP_Options', 'Form3.edProxyServer.Text',           Form3.edProxyServer.Text );
    Form3.edProxyPort.Text          := inifile.Readstring ( 'TCP_Options', 'Form3.edProxyPort.Text',             Form3.edProxyPort.Text );
    Form3.IgnoraJavascript.Checked  := inifile.ReadBool   ( 'TCP_Options', 'Form3.IgnoraJavascript.Checked',     Form3.IgnoraJavascript.Checked );
    Form3.IgnoraActiveX.Checked     := inifile.ReadBool   ( 'TCP_Options', 'Form3.IgnoraActiveX.Checked',        Form3.IgnoraActiveX.Checked );
    Form3.IgnoraCookies.Checked     := inifile.ReadBool   ( 'TCP_Options', 'Form3.IgnoraCookies.Checked',        Form3.IgnoraCookies.Checked );
    Form3.cbSSL.Checked             := inifile.ReadBool   ( 'TCP_Options', 'Form3.cbSSL.Checked',           Form3.cbSSL.Checked );
    Form3.cbMethod.ItemIndex        := inifile.ReadInteger( 'TCP_Options', 'Form3.cbMethod.ItemIndex' ,     Form3.cbMethod.ItemIndex  );

    //Form3.Memo.Text                 := inifile.readstring( 'Email_Options', 'Form3.Memo.Text',  Form3.Memo.Text  );
    Form3.SMTPServer.Text           := inifile.readstring( 'Email_Options', 'Form3.SMTPServer.Text',  Form3.SMTPServer.Text  );
    Form3.SMTPPort.Text             := inifile.readstring( 'Email_Options', 'Form3.SMTPPort.Text',  Form3.SMTPPort.Text  );
    Form3.MailProvider.Text         := inifile.readstring( 'Email_Options', 'Form3.MailProvider.Text',  Form3.MailProvider.Text  );
    Form3.MailRiscontro.Text        := inifile.readstring( 'Email_Options', 'Form3.MailRiscontro.Text',  Form3.MailRiscontro.Text  );
    Form3.SMTPAccount.Text          := inifile.readstring( 'Email_Options', 'Form3.SMTPAccount.Text',  Form3.SMTPAccount.Text  );
    Form3.SMTPPassword.Text         := inifile.readstring( 'Email_Options', 'Form3.SMTPPassword.Text',  Form3.SMTPPassword.Text  );


  finally
    inifile.free
  end;
  Form3.Memo.Lines.LoadFromFile('EmailText.txt');

  Form3.cbProxyClick(Self);//mark
  Form3.LanciaPingClick(Self);//mark
  Form3.cbSSLClick(Self);//mark
  Form3.UtilizzaLogFileClick(Self);//mark
  AggiornaFinestraFont();
end;




procedure TForm3.Button2Click(Sender: TObject);
begin
  Form3.FontDialog1.Execute;
  Form3.Esempio.Font       := Form3.FontDialog1.Font;
  AggiornaFinestraFont();
end;


procedure TForm3.cbProxyClick(Sender: TObject);
begin
  Form3.edProxyServer.Enabled := Form3.cbProxy.Checked;
  Form3.edProxyPort.Enabled   := Form3.cbProxy.Checked;
end;

procedure TForm3.LanciaPingClick(Sender: TObject);
begin
(*
  Form3.UsaPingWin.Enabled  := Form3.LanciaPing.Checked;
  Form3.PayloadPing.Enabled := Form3.LanciaPing.Checked;
  Form3.TimeoutPing.Enabled := Form3.LanciaPing.Checked;
  Form3.UsaPingWin.Enabled  := Form3.LanciaPing.Checked;
  Form3.PayloadPing.Enabled := Form3.LanciaPing.Checked;
  Form3.TimeoutPing.Enabled := Form3.LanciaPing.Checked;
*)
end;

procedure TForm3.cbSSLClick(Sender: TObject);
begin

  Form3.cbMethod.Enabled := Form3.cbSSL.Checked;

end;


procedure TForm3.UtilizzaLogFileClick(Sender: TObject);
begin
  Form3.LogFileName.Enabled     := Form3.UtilizzaLogFile.Checked;
  Form3.Button1.Enabled         := Form3.UtilizzaLogFile.Checked;
  Form3.Button3.Enabled         := Form3.UtilizzaLogFile.Checked;
  Form3.Button4.Enabled         := Form3.UtilizzaLogFile.Checked;
  Form3.Button5.Enabled         := Form3.UtilizzaLogFile.Checked;
  Form3.MemorizzaData.Enabled   := Form3.UtilizzaLogFile.Checked;
  Form3.MemorizzaMinSec.Enabled := Form3.UtilizzaLogFile.Checked;
  Form3.AzzeraLog.Enabled       := Form3.UtilizzaLogFile.Checked;
  Form3.IncludiLog.Enabled      := Form3.UtilizzaLogFile.Checked;
end;

procedure TForm3.btnCancelClick(Sender: TObject);
begin
  Close;
end;


procedure TForm3.PrimoPianoChange(Sender: TObject);
begin
  AggiornaFinestraFont();
end;

procedure TForm3.SfondoChange(Sender: TObject);
begin
  AggiornaFinestraFont();
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  AggiornaFinestraFont();
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  Form1.Memo1.Clear;
end;

procedure TForm3.Button4Click(Sender: TObject);
var
  a : Array[0..MAX_PATH] of char;
  MyPointer : Pchar;
begin

  Form1.Memo1.Lines.SaveToFile(Form3.LogFileName.Text);
  GetSystemDirectory(a, sizeof(a));
  Strcat(a, '\notepad.exe ');
  Strcat(a , Pchar(Form3.LogFileName.Text));
  MyPointer := a;
  WinExec(MyPointer, SW_SHOWNORMAL);
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TForm3.Button5Click(Sender: TObject);
var Filename:string;
var FileExt :string;
begin

  Form3.OpenDialog1.FileName := Form3.LogFileName.Text;
  Form3.OpenDialog1.Filter := 'txt';
  Form3.OpenDialog1.DefaultExt := 'txt';
  if (Form3.OpenDialog1.Execute) = True Then
  begin
    Filename := Form3.OpenDialog1.FileName;
    Form1.Memo1.Lines.LoadFromFile(Filename);
  end;
end;

procedure TForm3.BitBtn4Click(Sender: TObject);
begin

  if MessageDlg('Vuoi davvero ripristinare tutte le Opzioni allo stato iniziale?',     mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    exit;

Form3.UtilizzaLogFile.Checked := True;
Form3.LogFileName.Text := 'Logfile.txt';
Form3.MemorizzaData.Checked := False;
Form3.AzzeraLog.Checked := False;
Form3.MemorizzaMinSec.Checked := True;
Form3.IncludiLog.Checked := True;
Form3.FontFinestre.ItemIndex :=1;
Form3.DimensioneFont.Text := '11';
Form3.MostraSplashScreen.Checked := True;
Form3.AvviaMinimizzato.Checked := False;
Form3.SalvaPosizione.Checked := False;
Form3.PrimoPiano.SelectedColor :=3371960;
Form3.Sfondo.SelectedColor :=15793151;
Form3.FontDialog1.Font.Name := 'Fixedsys';
Form3.FontDialog1.Font.Size :=10;


Form3.SMTPServer.Text := 'Problemi sulla mia ADSL... < modificare! >';
Form3.SMTPPort.Text := '25';
Form3.MailProvider.Text := 'info@provider.it   < modificare! >';
Form3.MailRiscontro.Text :='mia_email@email.it     < modificare! >';
Form3.SMTPAccount.Text :='utente  < modificare! >';
Form3.SMTPPassword.Text :='';

//Form3.EditorColor.ItemIndex := 3;
//Form3.LineNumbers.Checked := True;
Form3.cbProxy.Checked := False;
Form3.edProxyServer.Text :='0.0.0.0';
Form3.edProxyPort.Text :='8080';
//Form3.ShowScrollHint.Checked := False;
//Form3.DontShowScroll.Checked := False;
//Form3.ShowGutter.Checked=0
Form3.cbSSL.Checked := False;
Form3.cbMethod.ItemIndex :=1;
Form3.IdentificatiCome.ItemIndex :=0;
Form3.AutorizzaIntranet.Checked := False;
Form3.LanciaPing.Checked := True;
Form3.UsaPingWin.Checked := False;
Form3.PayloadPing.ItemIndex :=2;
Form3.TimeoutPing.ItemIndex :=6;
Form3.IgnoraJavascript.Checked := True;
Form3.IgnoraActiveX.Checked := True;
Form3.IgnoraCookies.Checked := True;

end;

end.
