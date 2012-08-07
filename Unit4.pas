unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, TeeProcs, Chart, DbChart, DB, DBTables, Grids,
  DBGrids, ExtCtrls, DBCtrls, StdCtrls;

type
  TForm4 = class(TForm)
    DBChart1: TDBChart;
    Table1: TTable;
    DataSource1: TDataSource;
    Series1: TLineSeries;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Main, Unit10;

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm4.FormActivate(Sender: TObject);
begin
table1.Refresh;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  table1.Refresh;
  Form7.MostraGrafico1.Enabled := False;
end;

procedure TForm4.FormHide(Sender: TObject);
begin
  Form7.MostraGrafico1.Enabled := True;
end;

end.
