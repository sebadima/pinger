// NOTE: This demo ONLY runs under Windows.

// There is a seperate Kylix version of this demo.

program HTTPClient;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit1 in 'Unit1.pas' {AboutBox},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit5 in 'Unit5.pas' {AboutBox1},
  Unit6 in 'Unit6.pas' {Form6},
  Unit7 in 'Unit7.pas' {frmPing},
  Unit8 in 'Unit8.pas' {Form5},
  Unit9 in 'Unit9.pas' {frmHelp},
  Unit10 in 'Unit10.pas' {Form7},
  Unit20 in 'Unit20.pas' {Form11},
  Unit11 in 'Unit11.pas' {IPForm},
  Info in 'Info.pas' {Form8},
  Unit12 in 'Unit12.pas' {Form9},
  Unit13 in 'Unit13.pas' {Form10},
  Unit14 in 'Unit14.pas' {Form12},
  Unit15 in 'Unit15.pas' {Form13},
  Unit16 in 'Unit16.pas' {UptimeForm},
  Unit17 in 'Unit17.pas' {Form14},
  Unit18 in 'Unit18.pas' {Form15};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Connection Alive';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TAboutBox1, AboutBox1);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TfrmPing, frmPing);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TfrmHelp, frmHelp);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TIPForm, IPForm);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm12, Form12);
  Application.CreateForm(TForm13, Form13);
  Application.CreateForm(TUptimeForm, UptimeForm);
  Application.CreateForm(TForm14, Form14);
  Application.CreateForm(TForm15, Form15);
  Application.Run;
end.

