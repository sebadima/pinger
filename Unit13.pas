unit Unit13;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RedirectConsole, ExtCtrls;

type
  TForm10 = class(TForm)
    Memo1: TMemo;
    Edit2: TEdit;
    Panel1: TPanel;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    Edit3: TEdit;
    Button1: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Edit20: TEdit;
    Button20: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

uses Main;
{$R *.DFM}


procedure MyLineOut(s: string); // Output procedure
begin
  form1.memo1.lines.add(s);
end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  RC_LineOut:=MyLineOut; // set Output
  edit2.align:=albottom;
end;

procedure TForm10.Button2Click(Sender: TObject);
begin
  RC_Run(Edit1.text);
end;

procedure TForm10.Button3Click(Sender: TObject);
begin
  RC_LineIn('exit');
  Close;
end;

procedure TForm10.Edit2KeyPress(Sender: TObject; var Key: Char);
const EnterKey=#13; NoKey=#00;
begin
  if key=EnterKey then begin // send command line on Enter Key
    RC_LineIn(edit2.text);
    edit2.text:='';
    key:=NoKey;
  end;
end;

procedure TForm10.Button1Click(Sender: TObject);
begin
  RC_Run(Edit3.text); // run console program
end;

procedure TForm10.Button4Click(Sender: TObject);
begin
  RC_Run(Edit4.text);
end;

procedure TForm10.Button5Click(Sender: TObject);
begin
  RC_Run(Edit5.text);
end;

procedure TForm10.Button6Click(Sender: TObject);
begin
  RC_Run(Edit6.text);
end;

procedure TForm10.Button7Click(Sender: TObject);
begin
  RC_Run(Edit7.text);
end;

procedure TForm10.Button8Click(Sender: TObject);
begin
  RC_Run(Edit8.text);
end;

procedure TForm10.Button9Click(Sender: TObject);
begin
  RC_Run(Edit9.text);
end;

procedure TForm10.Button10Click(Sender: TObject);
begin
  RC_Run(Edit10.text);
end;

procedure TForm10.Button11Click(Sender: TObject);
begin
  RC_Run(Edit12.text);
end;

procedure TForm10.Button12Click(Sender: TObject);
begin
  RC_Run(Edit13.text);
end;

procedure TForm10.Button13Click(Sender: TObject);
begin
  RC_Run(Edit14.text);
end;

procedure TForm10.Button14Click(Sender: TObject);
begin
  RC_Run(Edit15.text);
end;

procedure TForm10.Button15Click(Sender: TObject);
begin
  RC_Run(Edit16.text);
end;

procedure TForm10.Button20Click(Sender: TObject);
begin
  RC_Run(Edit20.text);
end;

end.
