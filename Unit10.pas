unit Unit10;    // penso tray

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
  Menus, Spin, DB, DBTables, Inifiles, TrayIcon;

type
  TForm7 = class(TForm)
    PopupMenu1: TPopupMenu;
    Test11: TMenuItem;
    Test21: TMenuItem;
    Test31: TMenuItem;
    TrayIcon1: TTrayIcon;
    Opzioni1: TMenuItem;
    Autore1: TMenuItem;
    N2: TMenuItem;
    BloccaPing1: TMenuItem;
    RipristinaPing1: TMenuItem;
    MostraGrafico1: TMenuItem;
    N1: TMenuItem;
    procedure TrayIcon1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Test31Click(Sender: TObject);
    procedure Test11Click(Sender: TObject);
    procedure Opzioni1Click(Sender: TObject);
    procedure Autore1Click(Sender: TObject);
    procedure BloccaPing1Click(Sender: TObject);
    procedure RipristinaPing1Click(Sender: TObject);
    procedure MostraGrafico1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;


implementation

uses unit1, Main, Unit3, Unit4;

{$R *.DFM}

procedure TForm7.TrayIcon1Click(Sender: TObject);
begin
   form1.Show;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
   ShowWindowAsync( Handle, SW_HIDE );
end;


procedure TForm7.Test31Click(Sender: TObject);
begin
  if MessageDlg('Sei sicuro di volere Uscire?',     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Form1.SalvaDimensioniFinestra();
    Application.Terminate;
  end;
end;


procedure TForm7.Test11Click(Sender: TObject);
begin
   form1.Show;
   ShowWindow( Application.handle, SW_SHOW );
end;

procedure TForm7.Opzioni1Click(Sender: TObject);
begin
  Form3.Show();
end;

procedure TForm7.Autore1Click(Sender: TObject);
begin
  AboutBox.Show();
end;

procedure TForm7.BloccaPing1Click(Sender: TObject);
begin
  Form1.CheckBox1.Checked := False;
end;

procedure TForm7.RipristinaPing1Click(Sender: TObject);
begin
  Form1.CheckBox1.Checked := True;
end;

procedure TForm7.MostraGrafico1Click(Sender: TObject);
begin
  Form4.Show();
end;

initialization
begin
   //ShowWindow( Application.Handle, SW_HIDE ); // Get it done NOW
   Application.ProcessMessages;
end;

end.
