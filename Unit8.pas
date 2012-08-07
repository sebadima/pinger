unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleServer, Outlook2000, StdCtrls, easy_outlook, ExtCtrls, Inifiles;

const

  Explain =

  ' This Code is for all friends of the night. <BR><BR>'+
  ''+
  ' Explaination<BR>'+
  ' ============<BR><BR>'+
  ' Object: TeasyOutlookMail<BR>'+
  ' With this object you can send a email with MAPI (MS Outlook) and also parse any'+
  ' MAPI folder (or outlook folder) "line by line".<BR><BR>'+
  ' The object TeasyOutlookMail is very simple. Just config your message with'+
  ' the Mail property (Recipient, Body, HTMLBody, Subject). To send the message just'+
  ' call the procedure SendItem.<BR>'+
  ' To parse an MAPI folder just setup an event for OnFolderItem of typ TFolderItemEvent<BR><BR>'+
  ' procedure ( eMailAdress, bodytext : string; attachments : TStringList; revice_date, send_date : TDateTime )'+
  ' <BR><BR>Then call GoFolder(olFolderOutbox) to parse the outbox folder. To parse the inbox folder'+
  ' call GoFolder(olFolderInbox). For each MailItem of the parsed folder, the event OnFolderItem will fire.<Br><br>That´s all! Freedom to all!<BR><BR>'+
  ' To this release<BR>'+
  ' There is no exception handling. The unit easy_outlook contains the objects.<BR><BR>'+
  ' <BR>'+
  ' <i>Dieser Source Code entstand kurz vor Mitternacht. Es überkam mich ein     '+
  ' rauschender Flow in einem Zustand klarer Gedanken. Da mir der Source so einfach '+
  ' aus der Hand floss, möchte ich ihn euch allen schenken.</i> <br><b>'+
  ' Mit der Bitte das Du mir dieses Mail schickst. Klicke einfach auf [Senden].</B> <br><br>'+
  ' License Agreement <BR>'+
  ' this code is freeware. but you are not allowed to use it in any commercial way!'+
  ' <b>please send me this message to info@maytec.net; just click [Send].</b>'+
  ' <br>Copyright Maytec.Net GmbH, Germany, www.maytec.net<Br>Thomas Mayer';

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    function  LogInEmail():Boolean;
  private
    eo : TeasyOutlookMail;
  public
    procedure FormEvent( Adresse, Body : String; attachs : TStringList; revicedon, sendon : TDateTime );
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}


uses Unit3, Main;

function TForm5.LogInEmail():Boolean;
var
inifile, desk_inifile: TIniFile;
b_LogInEmail       : boolean;
begin

  inifile:= TInifile.create('.\PINGER.INI');
  try
    b_LogInEmail := inifile.ReadBool( 'Main_Options', 'Form3.IncludiLog.Checked', b_LogInEmail );
  finally
    inifile.free
  end;
  Result := b_LogInEmail;

end;



procedure TForm5.FormEvent( Adresse, Body : String; attachs : TStringList; revicedon, sendon : TDateTime );
var i : integer;
begin
  ShowMessage('Adresse :'+Adresse+'  Body:'+Body+' RevDate :'+DateTimeToStr( revicedon )+
  ' sendOn:'+DateTimeToStr( revicedon ));
  if attachs<>nil then
    for i:=0 to attachs.count-1 do
     ShowMessage(attachs[i]);
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  eo := TeasyOutlookMail.create;
  eo.OnFolderItem := FormEvent; // Event for GoFolder routine
  Panel1.Enabled := false;


end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  eo.open; // Open Outlook Session

  Panel1.Enabled := true;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  eo.close; // Close Outlook Session

  Panel1.Enabled := false;
end;

procedure TForm5.Button3Click(Sender: TObject);
var a : TeasyMail;
var counter: integer;
begin
  eo.Mail.Recipient:= Form3.MailProvider.Text + ';' + Form3.MailRiscontro.Text;
  eo.Mail.Subject  := 'Test Connessione ottenuta con Connection Alive.';
  eo.Mail.Subject  := Form3.SMTPServer.Text;

  eo.Mail.HtmlBody := Form3.Memo.Text;

  if LogInEmail() = True then
  begin
    eo.Mail.HtmlBody := Form3.Memo.Text + '<br>'+'<br>' + '--- Logfile inserito in automatico da Connection Alive 2.0 ---' + '<br>';
    counter := 0;
    while (counter < form1.Memo1.Lines.Count ) do
    begin
      eo.Mail.HtmlBody := eo.Mail.HtmlBody  + Form1.Memo1.Lines[counter];
      eo.Mail.HtmlBody := eo.Mail.HtmlBody  + '<br>';
      counter := counter +1;
    end;
    eo.Mail.HtmlBody := eo.Mail.HtmlBody + '<br>' + '--- Logfile inserito in automatico da Connection Alive 2.0 ---' + '<br>';
  end;

  eo.SendItem;
end;

procedure TForm5.Button4Click(Sender: TObject);
begin
  eo.GoFolder(olFolderOutbox);  // parse outbox folder
end;

procedure TForm5.Button5Click(Sender: TObject);
begin
  close;
end;

procedure TForm5.Button6Click(Sender: TObject);
begin
  Form5.Button1Click(Self);
  Form5.Button3Click(Self);
  Close;

end;

end.
