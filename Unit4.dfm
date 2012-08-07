object Form4: TForm4
  Left = 223
  Top = 147
  Width = 406
  Height = 312
  Caption = 'Grafico "Ping Temporizzato"'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000008888888888888888888888880000000000
    000000000000000000000080000000F7777777777777777777777708000000F0
    F000008F0000008F00000FF0800000F8008C84080FBFB30808D8D088080000F7
    80C8C4400BFBF3300D8D8508808000F8808C84440FBFB33308D8D550880800F7
    80C8C4440BFBF3330D8D8550777000F8808C84440FBFB33308D8D550000000F7
    80C8C4440BFBF3330D8D8550000000F8808C84440FBFB33308D8D550000000F7
    80C8C4440BFBF3330D8D8550000000F8808C84440FBFB33308D8D550000000F7
    80C8C4440BFBF3330D8D8550000000F8807774440FBFB33308D8D550000000F7
    80CCC8440BFBF3330D8D8550000000F8780CCC840FBFB33308D8D550000000F7
    8780CCC80BFBF3330D8D8550000000F8787800000FBFB33308D8D550000000F7
    878700000BFBF3330D8D8550000000F8787800000FBFB3330DDDD550000000F7
    878700000BFBF33300DDD850000000F8787800000FBFB333000DDD800000000F
    878700000FFFF3330000000000000000F87800000BBBB7330000000000000000
    0F87000000BBBB73000000000000000000F80000000BBBB70000000000000000
    000F000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFC000003F8000001F8000000F800000078000000380000001800000008000
    0000800000008000000F8000000F8000000F8000000F8000000F8000000F8000
    000F8000000F8000000F8000000F8070000F8070000F8070000F8070040FC070
    060FE07007FFF07807FFF87C07FFFC7E07FFFE7FFFFFFF7FFFFFFFFFFFFF}
  OldCreateOrder = False
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBChart1: TDBChart
    Left = 0
    Top = 0
    Width = 398
    Height = 278
    AnimatedZoom = True
    BackImageInside = True
    BackWall.Brush.Color = clWhite
    BackWall.Color = clScrollBar
    BottomWall.Brush.Color = clScrollBar
    Foot.Brush.Color = clScrollBar
    Foot.Color = clScrollBar
    Gradient.Direction = gdRightLeft
    Gradient.EndColor = 15724527
    Gradient.StartColor = 13290186
    Gradient.Visible = True
    LeftWall.Brush.Color = clScrollBar
    Title.Alignment = taRightJustify
    Title.Brush.Color = clScrollBar
    Title.Color = 13160660
    Title.Font.Charset = ANSI_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -11
    Title.Font.Name = 'Microsoft Sans Serif'
    Title.Font.Style = []
    Title.Text.Strings = (
      '  Tempi di Risposta del Server selezionato espressi in Msecondi')
    BackColor = clScrollBar
    Chart3DPercent = 35
    LeftAxis.Title.Caption = 'Campo1'
    Legend.Brush.Color = clScrollBar
    Legend.LegendStyle = lsLastValues
    Legend.ShadowSize = 4
    View3DOptions.Elevation = 333
    View3DOptions.Orthogonal = False
    View3DOptions.Perspective = 20
    View3DOptions.Rotation = 350
    Align = alClient
    BorderWidth = 1
    TabOrder = 0
    object Series1: TLineSeries
      ColorEachPoint = True
      HorizAxis = aBothHorizAxis
      Marks.ArrowLength = 20
      Marks.Style = smsPercent
      Marks.Visible = False
      DataSource = Table1
      SeriesColor = clRed
      Title = 'Campo1'
      VertAxis = aRightAxis
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
      YValues.ValueSource = 'Campo1'
    end
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'c:\Programmi\Connection Alive 20a'
    TableName = 'TCPTiming.DB'
    TableType = ttParadox
    Left = 468
    Top = 10
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 458
    Top = 58
  end
end
