object Form12: TForm12
  Left = 178
  Top = 188
  Width = 595
  Height = 210
  BorderStyle = bsSizeToolWin
  Caption = 'Seleziona un indirizzo fra i "Preferiti" di Internet Explorer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 587
    Height = 176
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = ListBox1DblClick
  end
end
