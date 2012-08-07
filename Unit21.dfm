object Form12: TForm12
  Left = 219
  Top = 126
  Width = 445
  Height = 417
  Caption = 'Form12'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = -34
    Width = 437
    Height = 375
    ActivePage = TabSheet2
    TabIndex = 1
    TabOrder = 0
    object Preferences: TTabSheet
      Caption = 'Generale'
      object GroupBox2: TGroupBox
        Left = 15
        Top = 20
        Width = 400
        Height = 119
        Caption = 'LogFile:'
        TabOrder = 0
        object MemorizzaData: TCheckBox
          Left = 9
          Top = 73
          Width = 110
          Height = 17
          Caption = 'Memorizza Data'
          TabOrder = 0
        end
        object UtilizzaLogFile: TCheckBox
          Left = 9
          Top = 17
          Width = 110
          Height = 17
          Caption = 'Utilizza LogFile'
          TabOrder = 1
        end
        object MemorizzaMinSec: TCheckBox
          Left = 9
          Top = 95
          Width = 146
          Height = 17
          Caption = 'Memorizza Min.+Sec.'
          TabOrder = 2
        end
        object AzzeraLog: TCheckBox
          Left = 233
          Top = 73
          Width = 164
          Height = 17
          Caption = 'Azzera Log in automatico'
          TabOrder = 3
        end
        object IncludiLog: TCheckBox
          Left = 233
          Top = 95
          Width = 139
          Height = 14
          Caption = 'Includi Log nella Email'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object LogFileName: TEdit
          Left = 9
          Top = 41
          Width = 131
          Height = 21
          TabOrder = 5
          Text = 'Logfile.txt'
        end
        object Button1: TButton
          Left = 330
          Top = 40
          Width = 58
          Height = 23
          Caption = 'Esporta'
          TabOrder = 6
        end
        object Button3: TButton
          Left = 147
          Top = 40
          Width = 58
          Height = 23
          Caption = 'Azzera'
          TabOrder = 7
        end
        object Button4: TButton
          Left = 208
          Top = 40
          Width = 58
          Height = 23
          Caption = 'Notepad'
          TabOrder = 8
        end
        object Button5: TButton
          Left = 269
          Top = 40
          Width = 58
          Height = 23
          Caption = 'Importa'
          TabOrder = 9
        end
      end
      object ExecutionPanel: TGroupBox
        Left = 15
        Top = 242
        Width = 400
        Height = 81
        Caption = 'Generale:'
        TabOrder = 1
        object MostraSplashScreen: TCheckBox
          Left = 9
          Top = 15
          Width = 179
          Height = 17
          Caption = 'Mostra Informazioni all'#39'avvio'
          TabOrder = 0
        end
        object SalvaPosizione: TCheckBox
          Left = 9
          Top = 57
          Width = 161
          Height = 17
          Caption = 'Salva posizione nel Desktop'
          TabOrder = 1
        end
        object AvviaMinimizzato: TCheckBox
          Left = 9
          Top = 36
          Width = 177
          Height = 17
          Caption = 'Avvia Minimizzato nella Traybar'
          TabOrder = 2
        end
        object Params: TEdit
          Left = 24
          Top = 88
          Width = 313
          Height = 21
          TabOrder = 3
        end
        object BitBtn4: TBitBtn
          Left = 292
          Top = 20
          Width = 93
          Height = 47
          Caption = 'Ripristina'
          TabOrder = 4
          Glyph.Data = {
            0E060000424D0E06000000000000360000002800000016000000160000000100
            180000000000D8050000C40E0000C40E00000000000000000000BFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF80
            8080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            808080BFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBF808080BFBFBF808080BFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BF808080BFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBF808080BFBFBFBFBFBFBF
            BFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBF
            BFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080808080BFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080BFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080BF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF8080
            80BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBF8080
            80BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080808080BFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBF808080BFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBF808080BFBFBF
            BFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBF808080BFBFBF808080BFBFBFBFBFBFBFBFBFBFBF
            BF808080BFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000BFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBF808080BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBF0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
            BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000}
        end
      end
      object GroupBox10: TGroupBox
        Left = 15
        Top = 152
        Width = 400
        Height = 78
        Caption = 'Aspetto Finestre:'
        TabOrder = 2
        object PrimoPiano: TfcColorCombo
          Left = 286
          Top = 16
          Width = 105
          Height = 21
          AutoDropDown = True
          Color = clWhite
          ColorListOptions.Color = clWhite
          ColorListOptions.Font.Charset = DEFAULT_CHARSET
          ColorListOptions.Font.Color = clWindowText
          ColorListOptions.Font.Height = -11
          ColorListOptions.Font.Name = 'MS Sans Serif'
          ColorListOptions.Font.Style = []
          ColorListOptions.Options = [ccoShowCustomColors, ccoShowColorNames]
          ColorListOptions.SortBy = csoByRGB
          CustomColors.Strings = (
            'Black=000000'
            'Maroon=000080'
            'Olive=008080'
            'White=FFFFFF'
            'Blue=FF0000'
            'Navy=800000'
            'Yellow=00FFFF'
            'Green=008000'
            'Purple=800080'
            'Gray=808080'
            'Silver=C0C0C0'
            'Lime=00FF00'
            'Fuschia=FF00FF'
            'Aqua=FFFF00'
            'Teal=808000'
            'VeryDarkBrown=33405C'
            'DarkGreen=2F4F2F'
            'Brown=2A2AA6'
            'Copper=3373B8'
            'DarkPurple=781F87'
            'Gold=327FCD'
            'LightBlue=D9D9C0'
            'LightGrey=A8A8A8'
            'LightSteelBlue=BD8F8F'
            'Bronze=53788C'
            'SkyBlue=CC9932'
            'Wheat=BFD8D8'
            'VeryLightGrey=CDCDCD')
          DropDownCount = 8
          ReadOnly = False
          SelectedColor = clBlack
          TabOrder = 0
        end
        object Sfondo: TfcColorCombo
          Left = 286
          Top = 47
          Width = 105
          Height = 21
          AutoDropDown = True
          Color = clWhite
          ColorDialogOptions = [cdoEnabled, cdoPreventFullOpen]
          ColorListOptions.Font.Charset = DEFAULT_CHARSET
          ColorListOptions.Font.Color = clWindowText
          ColorListOptions.Font.Height = -11
          ColorListOptions.Font.Name = 'MS Sans Serif'
          ColorListOptions.Font.Style = []
          ColorListOptions.Options = [ccoShowColorNone, ccoShowStandardColors, ccoShowColorNames]
          DropDownCount = 8
          ReadOnly = False
          SelectedColor = clNone
          Style = csDropDown
          TabOrder = 1
        end
        object Button2: TButton
          Left = 9
          Top = 30
          Width = 75
          Height = 23
          Caption = 'Font...'
          TabOrder = 2
        end
        object Panel1: TPanel
          Left = 100
          Top = 15
          Width = 127
          Height = 53
          TabOrder = 3
          object Esempio: TMemo
            Left = 5
            Top = 5
            Width = 116
            Height = 42
            Lines.Strings = (
              ' Testo'
              ' di esempio')
            TabOrder = 0
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Tcp/Ip'
      object GroupBox5: TGroupBox
        Left = 15
        Top = 153
        Width = 200
        Height = 104
        Caption = 'Proxy Server:'
        TabOrder = 0
      end
      object GroupBox1: TGroupBox
        Left = 15
        Top = 74
        Width = 400
        Height = 69
        Caption = 'Memoria Sistema:'
        TabOrder = 1
      end
      object GroupBox3: TGroupBox
        Left = 15
        Top = 14
        Width = 200
        Height = 49
        Caption = 'Nome Computer:'
        TabOrder = 2
        object Label1: TLabel
          Left = 9
          Top = 17
          Width = 60
          Height = 13
          Caption = 'Identificativo'
        end
      end
      object BackupPanel: TGroupBox
        Left = 226
        Top = 14
        Width = 189
        Height = 49
        Caption = 'Indirizzo IP:'
        TabOrder = 3
      end
      object GroupBox7: TGroupBox
        Left = 226
        Top = 153
        Width = 189
        Height = 104
        Caption = 'Browser html:'
        TabOrder = 4
      end
      object GroupBox8: TGroupBox
        Left = 15
        Top = 268
        Width = 400
        Height = 55
        Caption = 'SSL:'
        TabOrder = 5
      end
    end
  end
end
