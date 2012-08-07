unit Unit5;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox1 = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    btnOk: TBitBtn;
    Label1: TLabel;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox1: TAboutBox1;

implementation

{$R *.dfm}

procedure TAboutBox1.OKButtonClick(Sender: TObject);
begin
  Close();
end;

end.
 
