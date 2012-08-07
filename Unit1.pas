unit Unit1;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    ProductName: TLabel;
    Version: TLabel;
    Comments: TLabel;
    GroupBox1: TGroupBox;
    ProgramIcon: TImage;
    GroupBox2: TGroupBox;
    LicenseText: TMemo;
    btnOk: TBitBtn;
    Copyright: TLabel;
    Label1: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses Unit17;

{$R *.dfm}

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
  Close();
end;

procedure TAboutBox.Label1Click(Sender: TObject);
begin
  Form14.Show;
end;

end.
 
