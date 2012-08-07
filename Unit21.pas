unit Unit21;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, fcCombo, fcColorCombo, Buttons, ComCtrls;

type
  TForm12 = class(TForm)
    PageControl: TPageControl;
    Preferences: TTabSheet;
    GroupBox2: TGroupBox;
    MemorizzaData: TCheckBox;
    UtilizzaLogFile: TCheckBox;
    MemorizzaMinSec: TCheckBox;
    AzzeraLog: TCheckBox;
    IncludiLog: TCheckBox;
    LogFileName: TEdit;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ExecutionPanel: TGroupBox;
    MostraSplashScreen: TCheckBox;
    SalvaPosizione: TCheckBox;
    AvviaMinimizzato: TCheckBox;
    Params: TEdit;
    BitBtn4: TBitBtn;
    GroupBox10: TGroupBox;
    PrimoPiano: TfcColorCombo;
    Sfondo: TfcColorCombo;
    Button2: TButton;
    Panel1: TPanel;
    Esempio: TMemo;
    TabSheet2: TTabSheet;
    GroupBox5: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    BackupPanel: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.dfm}

end.
