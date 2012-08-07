unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DBCtrls, DB, DBTables,
  Buttons;

type
  TForm6 = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    Panel2: TPanel;
    Query1: TQuery;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    DBNavigator2: TDBNavigator;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses Unit4;

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
begin
  Close();
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
query1.ExecSQL;
table1.Refresh;
end;

procedure TForm6.FormActivate(Sender: TObject);
begin
table1.Refresh;
end;

end.
