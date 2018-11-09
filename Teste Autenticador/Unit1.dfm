object Form1: TForm1
  Left = 290
  Top = 329
  Width = 701
  Height = 425
  BorderStyle = bsSizeToolWin
  Caption = 'Teste do Autenticador'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 685
    Height = 386
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 683
      Height = 128
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -31
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 129
      Width = 683
      Height = 215
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource1
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object Panel2: TPanel
      Left = 1
      Top = 344
      Width = 683
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Button1: TButton
        Left = 520
        Top = 4
        Width = 143
        Height = 33
        Caption = '&Fechar'
        TabOrder = 0
        OnClick = Button1Click
      end
    end
  end
  object SimpleDataSet1: TSimpleDataSet
    Aggregates = <>
    Connection = SQLConnection1
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 424
    Top = 71
  end
  object DataSource1: TDataSource
    DataSet = SimpleDataSet1
    Left = 136
    Top = 71
  end
  object SQLConnection1: TSQLConnection
    LoginPrompt = False
    Left = 401
    Top = 17
  end
  object autenticador: TEngeAutenticador
    TipoAutenticacao = taLauncher
    Conexao = SQLConnection1
    Sistema = siRics
    TipoConexao = tcOracle
    WaitOnLocks = False
    ExtrairDlls = False
    Driver = tdDevart
    OnDepoisAutenticar = autenticadorDepoisAutenticar
    Left = 233
    Top = 49
  end
end
