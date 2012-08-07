unit Unit14;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ToolWin, ShlObj, ImgList, Menus, Strutils;

type
  TForm12 = class(TForm)
    ListBox1: TListBox;
    function GetIEFavourites(const favpath: string):TStrings;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

uses Main;

{$R *.dfm}


function TForm12.GetIEFavourites(const favpath: string):TStrings;
var
   searchrec:TSearchrec;
   str:TStrings;
   path,dir,filename:String;
   Buffer: array[0..2047] of Char;
   found:Integer;
begin
  str:=TStringList.Create;
  try
   path:=FavPath+'\*.url';
   dir:=ExtractFilepath(path) ;
   found:=FindFirst(path,faAnyFile,searchrec) ;
   while found=0 do begin
    SetString(filename, Buffer,
            GetPrivateProfileString('InternetShortcut',
            PChar('URL'), NIL, Buffer, SizeOf(Buffer),
            PChar(dir+searchrec.Name))) ;
    str.Add(filename) ;
    found:=FindNext(searchrec) ;
   end;
   found:=FindFirst(dir+'\*.*',faAnyFile,searchrec) ;
   while found=0 do begin
    if ((searchrec.Attr and faDirectory) > 0)
      and (searchrec.Name[1]<>'.') then
    str.AddStrings(GetIEFavourites
                 (dir+'\'+searchrec.name)) ;
    found:=FindNext(searchrec) ;
   end;
   FindClose(searchrec) ;
  finally
   Result:=str;
  end;
end;




procedure TForm12.Button1Click(Sender: TObject) ;
var pidl: PItemIDList;
     FavPath: array[0..MAX_PATH] of char;
begin
  SHGetSpecialFolderLocation(Handle, CSIDL_FAVORITES, pidl) ;
  SHGetPathFromIDList(pidl, favpath) ;
  ListBox1.Items:=GetIEFavourites(StrPas(FavPath)) ;
end;

procedure TForm12.FormShow(Sender: TObject);
begin
  Button1Click(Self) ;
end;



procedure TForm12.ListBox1DblClick(Sender: TObject);
var s:string;
begin
  s := ListBox1.Items[ListBox1.ItemIndex];
  s := AnsiReplaceStr(s, 'http://', '');
  s := 'http://' + AnsiReplaceStr(s, StrScan(Pchar(s), '/'), '');
  Form1.cbURL.Text := s;
  Close;
end;


end.
