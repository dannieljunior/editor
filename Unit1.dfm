object Form1: TForm1
  Left = 294
  Top = 125
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EngeAutenticador1: TEngeAutenticador
    TipoAutenticacao = taLauncher
    Sistema = siProtesto
    TipoConexao = tcFirebird
    WaitOnLocks = False
    ExtrairDlls = False
    Driver = tdNativo
    UsaServicoAuditoria = False
    Left = 48
    Top = 72
  end
end
