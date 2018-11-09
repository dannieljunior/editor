unit WPTools_Reg;
{ -----------------------------------------------------------------------------
  Copyright (C) 2002-2017 by wpcubed GmbH - Author: Julian Ziersch
  info: http://www.wptools.de                       mailto:support@wptools.de
              _______ _________ _______  _______  _        _______
    |\     /|(  ____ )\__   __/(  ___  )(  ___  )( \      (  ____ \
    | )   ( || (    )|   ) (   | (   ) || (   ) || (      | (    \/
    | | _ | || (____)|   | |   | |   | || |   | || |      | (_____
    | |( )| ||  _____)   | |   | |   | || |   | || |      (_____  )
    | || || || (         | |   | |   | || |   | || |            ) |
    | () () || )         | |   | (___) || (___) || (____/\/\____) |
    (_______)|/          )_(   (_______)(_______)(_______/\_______)
  *****************************************************************************
  * WPRTEDefs - WPTools 7 RTF Engine Data Structures and the basic RTFEngine
  * This unit contains all important objects and helper classes
  -----------------------------------------------------------------------------
  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
  KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
  ----------------------------------------------------------------------------- }
 
{-$DEFINE NODsgnIntf }
{-$DEFINE NODB}

interface

{$I WPINC.INC}
{$IFDEF WPQUICK4}{$DEFINE WPQUICK}{$ENDIF}
{$IFDEF WPPDFEX}
{$I wpdf_inc.inc} // to embedd wPDF directly in WPTools package
{$IFDEF WPQUICk}{$DEFINE WPDF_QR}{$ENDIF}
{$ENDIF}
{$IFDEF VER130}
{$UNDEF DELPHI6ANDUP} // Delphi 5 or BCB5
{$ENDIF}
{$DEFINE IWPGUTTER}

{$IFDEF WPPREMIUM}
  {$DEFINE WPREPORTER}
{$ENDIF}

uses
{$IFDEF DELPHIXE}
         WinAPI.Windows,
         System.SysUtils, VCL.Dialogs, System.Classes, VCL.ActnList, VCL.Forms,
 {$ELSE} Windows,
         SysUtils, Dialogs, Classes, ActnList, Forms,
 {$ENDIF}
 {$IFDEF DELPHIXE3} System.Actions, {$ENDIF}
  WPRteDefs,  WPUtil, WPRTEPaint,
  WPCTRRich, WPCtrMemo, WPCTRLabel, WPCTRStyleScroller,
  wptexpert, wppanel, wptbar, wpruler, wpaction, WPCTRStyleCol, WPCtrPrint,
  {$IFDEF DELPHI5} WPDefActions, {$ELSE}  WPDefActions7, {$ENDIF}
  WPWordConv, WPRTEDefsConsts, WPRTEPlatform, WPSearchDlg,
  WPTbarConfig, WPRTEEDit,
  WPRTEFormatB, // Old Standard
{$IFDEF LIVEBIND}//<WP8
  Data.Bind.Components,
{$ENDIF}//>WP8
{$IFDEF IWPGUTTER}wpgutter, {$ENDIF}
  // -----------------------------------------------------------------------------
{$IFDEF WPPDFEX}{$IFDEF WPDF_SOURCE} WPPDFR1_src {$ELSE} WPPDFR1 {$ENDIF},
  WPPDFPRP, WPPDFR2, WPPDFWP, WPToPDFDlg,
{$IFDEF WPDF_QR}wppdfQR, {$ENDIF}
{$ENDIF} // wPDF Support - PDF export from WPTools
  // -----------------------------------------------------------------------------
{$IFDEF WPQUICK} WPQuickR,
{$IFNDEF NODB} WPDQuick, {$ENDIF}
{$ENDIF}
  // -----------------------------------------------------------------------------
  // Dialogs:
  WPPrvFrm, Wpspdlg1, WPParPrp, WPStrDlg, WPParBrd, Wppagprp, WPTabDlg,
  WPTblDlg,
  WPBltDlg, WPSymDlg, wpstyles, wp1style, wpDefEditor,
  wpManHeadFoot
{$IFNDEF NODsgnIntf}
  // ---------------------------------------------------------------------------
  // If you get the compiler error "DsgnIntf not found"
  // 1) make the package a "design package" (Properties, Description)
  // 2) add the package  designide.bpi  / dsnide50.bpi
  // 3) C++Builder 5&6: Goto Project/Edit Options Source and add -LUvcl50 to PFLAGS
  //    In later C++Builder editions add
  //          -LUDesignIDE
  //    under Delphi/Compiler Options/Other Options
  //
  // Unit namespaces in project should read:
  // Vcl;Winapi;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win;Bde;System;Xml;Data;Datasnap;Web;Soap
  // ---------------------------------------------------------------------------
  {$IFDEF BCB}
     {$IFDEF DELPHIXE}
      ,DesignIntf, DesignEditors
     {$ELSE}
     , DsgnIntf
     {$ENDIF}
  {$ELSE}
  {$IFDEF DELPHI6ANDUP}, DesignIntf, DesignEditors{$ELSE}, DsgnIntf{$ENDIF} {$ENDIF},
  WPPrButt
{$ENDIF}
{$IFNDEF NODB}
    , WPDBRich
    {$IFDEF WP8}
    {$IFDEF DELPHIXE}
    , Data.DB
    {$ENDIF}
	
	{$IFDEF WP6}
     ,DB
    {$ENDIF}
	
	
    {$ENDIF}

{$ENDIF}
  // -----------------------------------------------------------------------------
    , WPSymDlgEx, WPParBrd2
{$IFDEF _____WPREMIUM}
    , WPXMLSchmema
{$ENDIF}
  // -----------------------------------------------------------------------------
{$IFDEF WPREPORTER}
    , WPRTEReport, WPRepED, WPEval, WPTblCalc {$IFNDEF NODB}, WPDBEval {$ENDIF}
{$ENDIF}
  // -----------------------------------------------------------------------------
{$IFDEF WPSPELL}
    , WPSpell_Controller
{$ENDIF}
  // -----------------------------------------------------------------------------
{$IFDEF WPDEMO}
    , wpshared
{$ELSE}
{$IFDEF INCLUDE_WPSHARED}
    , wpshared
{$ENDIF}
{$ENDIF}
  // -----------------------------------------------------------------------------
{$IFDEF INCLUDE_WPFORM} // Compile in WPFORM
    , wpf_reg, wpf_engl, wpfrtf5
{$ENDIF}
    , WPRTEFormatA

{$IFDEF WP8}  // WPTools 8 - TableProduce
  {$IFDEF WPREPORTER} // Optional in wpreporter or premium edition!
    , WPCTRTextProducer , WPCTRTextProducerDB
  {$ENDIF}
    , WPDataSetTools
{$ENDIF}
    ;

{$IFNDEF NODsgnIntf}
type

  TWPRTFTextEdit = class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TRtfTextProperty = class(TPropertyEditor)
  private
    RtfTextDlg: TWPToolsEditor;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    procedure SetValue(const Value: string); override;
    function GetValue: string; override;
  end;

  {$IFDEF WP8}//<WP8
  TWPAStyleProperty = class(TPropertyEditor)
  public
    destructor Destroy; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    procedure SetValue(const Value: string); override;
    function GetValue: string; override;
  end;
  {$ENDIF}//>WP8


  TWPStylesProperty = class(TPropertyEditor)
  public
    destructor Destroy; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    procedure SetValue(const Value: string); override;
    function GetValue: string; override;
  end;

  TWPStyleCollectEdit = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


  TWPToolbarConfigStringEdit = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TWPToolbarConfigStringProperty = class(TPropertyEditor)
  private
    Fvalue: string;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    procedure SetValue(const Value: string); override;
    function GetValue: String; override;
  end;

{$IFDEF DELPHI6ANDUP}

  TWPCustomAttrDlgEdit = class(TComponentEditor)
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    function GetAttributes: TPropertyAttributes;
    procedure Edit; override;
  end;
{$ENDIF}


{$IFDEF WP8}
{$IFDEF WPREPORTER}
  TWPDBFieldNameProperty = class(TStringProperty)    // TWPColTemplateDB
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TWPDBSourceNameProperty = class(TStringProperty)    // TWPBlockTemplate
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TWPBlockNameProperty = class(TStringProperty)    // TWPBlockTemplate
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;
 {$ENDIF}
{$ENDIF}

{$ENDIF NODsgnIntf}


procedure Register;

implementation

{$IFNDEF NODsgnIntf} uses WPSplash; {$ENDIF}
{$R WptoRES7.res}
{$IFDEF WPREPORTER}{$R WPReport.RES}{$ENDIF}
{$IFDEF WPPDFEX}
{$R WPPDFREG.RES}
{$ENDIF}

procedure Register;
begin

{$IFDEF WPPDFEX}
  RegisterComponents('wPDF', [TWPPDFExport]);
  RegisterComponents('wPDF', [TWPPDFPrinter, TWPPDFProperties]);
  RegisterComponents('WPToolsDlg', [TWPCreatePDFDlg]);
{$IFDEF PDFIMPORT}
  //RegisterComponents('wPDF', [TWPDFPagesImport]); // Obsolet. Use WPViewPDF!
{$ENDIF}
{$IFDEF WPDF_QR}
  RegisterComponents('wPDF', [TQRwPDFFilter]);
{$ENDIF}
{$ENDIF}
  RegisterComponents('WPTools', [TWPDefaultActions, TWPPaintEngine,
    TWPRTFStorage, TWPRichText, TWPRichTextLabel, TWPPreview, TWPSuperPrint]);

{$IFNDEF NODB}
  RegisterComponents('WPTools', [TDBWPRichText, TWPMMDataProvider]);
{$ENDIF}
{$IFDEF WPQUICK}
  RegisterComponents('WPTools', [TWPQuickPrint]);
{$IFNDEF NODB}
  RegisterComponents('WPTools', [TWPDBQuickPrint]);
{$ENDIF}
{$ENDIF}

  RegisterComponents('WPTools', [TWPTextObjectClasses, TWPImagelist, TWPRTFProps, TWPStyleScroller,
    // added to WPTools 7
{$IFDEF USEWPRESCOMP}TWPResLabel, TWPResCheckBox, {$ENDIF}
    TWPValueEdit, TWPShadedPanel, TWPContainer, TWPWallPaper]);
  RegisterComponents('WPTools', [TWPToolBar, TWPToolPanel, TWPComboBox,
    TWPToolButton, TWPRuler, TWPVertRuler, TWPStyleCollection]);

  RegisterComponents('WPToolsDlg', [TWPDialogCollection, TWPSearchReplaceDlg,
    TWPPreviewDlg, TWPPagePropDlg, TWPManageHeaderFooterDlg,
    TWPParagraphPropDlg, TWPParagraphBorderDlgEx, TWPParagraphBorderDlg,
    TWPStyleDlg, TWPOneStyleDlg, TWPTabDlg, TWPSymbolDlg, TWPSymbolDlgEx,
    TWPTableDlg, TWPBulletDlg, TWPSpellCheckDlg, TWPStringDlg]);

{$IFDEF ___WPREMIUM}
  RegisterComponents('WPTools', [TWPXMLSchmema]);
{$ENDIF}
{$IFDEF IWPGUTTER}RegisterComponents('WPTools', [TWPGutter]); {$ENDIF}
{$IFDEF WPREPORTER}
  RegisterComponents('WPReporter', [TWPSuperMerge, TWPFormulaInterface,
    TWPEvalEngine{$IFNDEF NODB}, TDBWPEvalEngine{$ENDIF}]);
  RegisterComponents('WPToolsDlg', [TWPReportBandsDialog]);
{$ENDIF}

{$IFDEF WP8}  // WPReporter!
  {$IFNDEF NODsgnIntf}
  {$IFDEF WPREPORTER}
       RegisterComponents('WPTools', [TWPDataSetAdapter, TWPTableProducer, TWPTableProducerDB]);
       RegisterPropertyEditor(TypeInfo(string), TWPColTemplateDB, 'FieldName', TWPDBFieldNameProperty);
       RegisterPropertyEditor(TypeInfo(string), TWPBlockTemplate, 'ClientName', TWPBlockNameProperty);
       RegisterPropertyEditor(TypeInfo(string), TWPBlockTemplate, 'NextName', TWPBlockNameProperty);
       RegisterPropertyEditor(TypeInfo(string), TWPBlockTemplateDB, 'DataSourceName', TWPDBSourceNameProperty);
       RegisterPropertyEditor(TypeInfo(string), TWPTableProducer, 'ActiveTemplate', TWPBlockNameProperty);
       RegisterPropertyEditor(TypeInfo(string), TWPDataSourceLink, 'UIDFieldName', TWPDBFieldNameProperty);
       RegisterPropertyEditor(TypeInfo(TWPRTFBlobContents), TWPBlockTemplate, 'TemplateText', TRtfTextProperty);
       RegisterPropertyEditor(TypeInfo(TWPValueList), TWPColTemplate, '', TWPAStyleProperty);
       RegisterPropertyEditor(TypeInfo(TWPValueList), TWPTemplateStyle, '', TWPAStyleProperty);
  {$ENDIF}
  {$ENDIF}
{$ENDIF}


  // -------------- Editors  ---------------------------------------------------
{$IFNDEF NODsgnIntf}
  RegisterPropertyEditor(TypeInfo(TWPRTFBlobContents), TWPCustomRtfEdit,
    'RtfText', TRtfTextProperty);
  RegisterPropertyEditor(TypeInfo(TWPRTFBlobContents), TWPRichTextLabel,
    'RtfText', TRtfTextProperty);
  RegisterPropertyEditor(TypeInfo(TWPRTFBlobContents), TWPRTFStorage, 'RtfText',
    TRtfTextProperty);
{$IFDEF WPQUICK4}
  RegisterPropertyEditor(TypeInfo(TWPRTFBlobContents), TWPQuickPrint, 'RtfText',
    TRtfTextProperty);
{$ENDIF}
  RegisterComponentEditor(TWPRichTextLabel, TWPRTFTextEdit);
  RegisterComponentEditor(TWPCustomRtfEdit, TWPRTFTextEdit);
  RegisterComponentEditor(TWPRTFStorage, TWPRTFTextEdit);
  RegisterComponentEditor(TWPStyleCollection, TWPStyleCollectEdit);
  RegisterComponentEditor(TWPRTFProps, TWPStyleCollectEdit);
  RegisterComponentEditor(TWPToolBar, TWPToolbarConfigStringEdit);
{$IFDEF DELPHI6ANDUP}
  RegisterComponentEditor(TWPSymbolDlgEx, TWPCustomAttrDlgEdit);
  RegisterComponentEditor(TWPSymbolDlg, TWPCustomAttrDlgEdit);
  RegisterComponentEditor(TWPTableDlg, TWPCustomAttrDlgEdit);
  RegisterComponentEditor(TWPBulletDlg, TWPCustomAttrDlgEdit);
{$ENDIF}
  RegisterPropertyEditor(TypeInfo(TWPSpeedButtonStyle), TWPToolButton,
    'StyleName', TWPSpeedButtonProperty);
  RegisterPropertyEditor(TypeInfo(TWPToolBarConfigString), TWPToolBar,
    'ConfigString', TWPToolbarConfigStringProperty);
  {$IFDEF WP8}
  RegisterPropertyEditor(TypeInfo(TWPValueList), TWPParStyle,
    'Values', TWPAStyleProperty);
  {$ENDIF}
{$ENDIF}
  // -------------- Action Classes ---------------------------------------------
  RegisterActions('WPT_COMBOS', [TWPToolsCustomEditContolAction], nil);

  RegisterActions('WPT_Zoom', [TWPAZoomOut, TWPAZoomIn, TWPAZoom100,
    TWPAFitWidth, TWPAFitHeight, // Obsolet
    TWPAZoomWidth, TWPAZoomFull, TWPALayoutNormal, TWPALayoutFull,
    TWPALayoutDouble, TWPALayoutColumns], nil);

  RegisterActions('WPT_Edit', [TWPAUndo, TWPARedo, TWPACopy, TWPACut, TWPAPaste,
    TWPASearch, TWPAReplace, TWPASellAll, TWPAHideSelection,
    { TWPAFindNext, } TWPASpellcheck, TWPASpellAsYouGo, TWPAStartThesaurus,
    TWPADeleteText, TWPACopyAttributes], nil);
  RegisterActions('WPT_Table', [TWPABBottom, TWPABRight, TWPABLeft, TWPABTop,
    TWPABAllOff, TWPABAllOn, TWPADelRow, TWPABInner, TWPABOuter,
    TWPACreateTable, TWPACombineCell, TWPASplitCells, TWPAInsRow,
    TWPASelectColumn, TWPASelectRow, TWPAInsCol, TWPADelCol, TWPACombineColumns,
    TWPASplitColumns, TWPASplitRows, TWPAMergeRows, TWPACombineTables,
    TWPASplitTable], nil);

  RegisterActions('WPT_ParAttr', [TWPALeft, TWPACenter, TWPARight,
    TWPAJustified, TWPABullets, TWPANumbers, TWPADecIndent, TWPAIncIndent
    { 7 } , TWPAParagraphProtect, TWPAParagraphKeepTogether,
    TWPANormalizeParagraph], nil);
  RegisterActions('WPT_Outlines', [TWPAIsOutlineMode, TWPAInOutlineUp,
    TWPAInOutlineDown], nil);
  RegisterActions('WPT_CharAttr', [TWPAIncreaseFontsize, TWPADecreaseFontsize,
    TWPANorm, TWPABold, TWPAItalic, TWPAProtected, TWPAHidden, TWPARTFCode,
    TWPAUnderline, TWPAStrikeout, TWPASubscript, TWPASuperscript,
    TWPAAttributesBrush, TWPAToUppercase, TWPAToLowercase], nil);
  RegisterActions('WPT_File', [TWPAOpen, TWPASave, TWPAExit, TWPAClose,
    TWPANew], nil);
  RegisterActions('WPT_Data', [TWPACancel, TWPADelete, TWPAAdd, TWPAEdit,
    TWPANext, TWPABack, TWPAOK, TWPAToEnd, TWPAToStart], nil);
  RegisterActions('WPT_Move', [TWPAMoveNextItem, TWPAMoveHighlight,
    TWPAMoveTable, TWPAMoveBookmark, TWPAMoveImage, TWPAMoveHeader,
    TWPAMoveFooter, TWPAMoveHyperlink, TWPAMoveAnnotation, TWPAMovePagebreak,
    TWPAMoveField, TWPAMoveFootnote], nil);

  RegisterActions('WPT_Insert', [TWPAInsertSymbol, TWPAInsertPagenumber,
    TWPAInsertPagecount, TWPAInsertFootnote, TWPAInsPagenrNext,
    TWPAInsPagenrPrev, TWPAInsDate, TWPAInsertNumber, TWPAInsertField,
    TWPAEditHyperlink], nil);

  RegisterActions('WPT_Image', [TWPAInsertImage, TWPAImageWrapRight,
    TWPAImageWrapLeft, TWPAImageWrapBoth, TWPAImageNoWrap,
    TWPAImageProperties], nil);

  RegisterActions('WPT_Columns', [TWPAColumnsOFF, TWPAColumnsSet2,
    TWPAColumnsSet3, TWPAColumnsSet4], nil);

  RegisterActions('WPT_View', [TWPAPrint, TWPAPrinterSetup, TWPAPriorPage,
    TWPANextPage, TWPAShowMargins, TWPAShowGridlines,
    TWPAShowSpecialchar], nil);

  RegisterActions('WPT_Dialogs', [TWPASetupPage, TWPAPreviewDialog,
    TWPAManageHeaderFooter, TWPADiaBorders, TWPADiaBulletOutline,
    TWPADiaFormulas, TWPADiaParagraphProperties, TWPADiaTabstops,
    TWPADiaEditCurrentStyle, TWPADiaStyleSheet, TWPADiaSectionProps,
    TWPADiaCreateTable, TWPADiaReportBand, TWPAPrintDia, TWPADiaPDFExport], nil);

end;

{$IFNDEF NODsgnIntf}

procedure WPToolsInfo;
begin
  with TWPSplashForm.Create(Application) do
  begin
    InfoLabel.Caption := String('Version ' + WPToolsVersion);
{$IFDEF WPDEMO}
    TopInfo.Caption := 'EVALUATION VERSION';
{$ENDIF}
    ShowModal;
    // Free on Close !
  end;
end;

function TRtfTextProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TRtfTextProperty.SetValue(const Value: string);
var
  ed: TPersistent;
begin
  if CompareText(Value, 'empty!') = 0 then
  begin
    ed := GetComponent(0);
    if ed <> nil then
    begin
      if ed is TWPCustomRtfEdit then
      begin
        (ed as TWPCustomRtfEdit).RtfText.Clear;
        Modified;
        (ed as TWPCustomRtfEdit).Invalidate;
      end
      else if ed is TWPCustomRtfLabel then
      begin
        (ed as TWPCustomRtfLabel).RtfText.Clear;
        Modified;
        (ed as TWPCustomRtfLabel).Invalidate;
      end
      else if ed is TWPRTFStorage then
      begin
        (ed as TWPRTFStorage).RtfText.Clear;
        Modified;
      end
{$IFDEF WPQUICK}
      else if ed is TWPQuickPrint then
      begin
        (ed as TWPQuickPrint).RtfText.Clear;
        Modified;
      end
{$ENDIF}
{$IFDEF WP8}
  {$IFDEF WPREPORTER}
      else if ed is TWPTableProducer then
      begin
        (ed as TWPBlockTemplate).TemplateText.Clear;
        Modified;
      end;
  {$ENDIF}
{$ENDIF}
        ;
    end;
  end;
end;

function TRtfTextProperty.GetValue: string;
var
  ed: TPersistent;
begin
  Result := String('empty. [V' + WPToolsVersion + ']');
{$IFDEF WPDEMO}
  Result := Result + ' DEMO';
{$ELSE}
{$IFDEF WPREPORTER}
{$IFDEF WPREPORTDEMO}
  Result := Result + ' WPREPORTER DEMO';
{$ELSE}
  Result := Result + ' BUNDLE';
{$ENDIF}
{$ENDIF WPREPORTER}
{$ENDIF WPDEMO}
  ed := GetComponent(0);
  if ed <> nil then
  begin
    if ed is TWPCustomRtfEdit then
      Result := (ed as TWPCustomRtfEdit).RtfText.GetDescription  + ' [V' + WPToolsVersion + ']'
    else if ed is TWPCustomRtfLabel then
      Result := (ed as TWPCustomRtfLabel).RtfText.GetDescription  + ' [V' + WPToolsVersion + ']'
    else if ed is TWPRTFStorage then
      Result := (ed as TWPRTFStorage).RtfText.GetDescription  + ' [V' + WPToolsVersion + ']'
{$IFDEF WPQUICK}
    else if ed is TWPQuickPrint then
      Result := (ed as TWPQuickPrint).RtfText.GetDescription   + ' [V' + WPToolsVersion + ']'
{$ENDIF}
{$IFDEF WP8}
   {$IFDEF WPREPORTER}
      else if ed is TWPBlockTemplate then
      begin
        Result := (ed as TWPBlockTemplate).TemplateText.GetDescription
      end;
   {$ENDIF}
{$ENDIF}
        ;
  end;
end;

procedure TRtfTextProperty.Edit;
var
  ed: TPersistent;
  {$IFDEF WP8}
  list : TStringList;
  {$ENDIF}
begin
  try
    RtfTextDlg := TWPToolsEditor.Create(nil);
    RtfTextDlg.WPDefAct.OnInfo := WPToolsInfo;
    RtfTextDlg.WPDefAct.InsertFormField1.Visible := TRUE;
    RtfTextDlg.ToolPanel.Visible := TRUE;

    ed := GetComponent(0);
    if ed <> nil then
    begin
      if ed is TWPCustomRtfEdit then
      begin
        RtfTextDlg.WPRichText1.Header.Assign((ed as TWPCustomRtfEdit).Header);
        RtfTextDlg.GetFromRTFText((ed as TWPCustomRtfEdit).RtfText);
      end
      else if ed is TWPCustomRtfLabel then
      begin
        RtfTextDlg.WPRichText1.Header.Assign((ed as TWPCustomRtfLabel)
          .RTFData.Header);
        RtfTextDlg.GetFromRTFText((ed as TWPCustomRtfLabel).RtfText);
      end
      else if ed is TWPRTFStorage then
        RtfTextDlg.GetFromRTFText((ed as TWPRTFStorage).RtfText)
{$IFDEF WPQUICK}
      else if ed is TWPQuickPrint then
      begin
        RtfTextDlg.GetFromRTFText((ed as TWPQuickPrint).RtfText);
        RtfTextDlg.WPRichText1.Header.SetPageWH
          (MulDiv((ed as TWPQuickPrint).Width, 1440,
          WPScreenPixelsPerInch), $FFFF);
      end;
{$ENDIF}
{$IFDEF WP8}
   {$IFDEF WPREPORTER}
      else if ed is TWPBlockTemplate then
      begin
                  RtfTextDlg.GetFromRTFText((ed as TWPBlockTemplate).TemplateText);
                  list := TStringList.Create;
                  (ed as TWPBlockTemplate).TableTemplates.GetNameList(list);
                  RtfTextDlg.AllowInsNamedPar(list);
                  list.Free;
                (*
                  RtfTextDlg.WPRichText1.RTFData.GetLayerNames(wpIsOwnerSelected, RtfTextDlg.cbLayerList.Items, true);
                  if RtfTextDlg.cbLayerList.Items.Count>0 then
                  begin
                     rtf := TWPRTFDataBlock(RtfTextDlg.cbLayerList.Items.Objects[0]);
                     RtfTextDlg.cbLayerList.ItemIndex := 0;
                  end
                  else
                  begin
                     rtf := TWPRTFDataBlock(RtfTextDlg.WPRichText1.RTFData.Add);
                     rtf.Kind := wpIsOwnerSelected;
                     rtf.Name := 'New' + IntToStr(RtfTextDlg.WPRichText1.RTFData.Count);
                  end;
                  RtfTextDlg.WPRichText1.DisplayedText := rtf;
                  RtfTextDlg.WPRichText1.ActiveText := rtf;
                  RtfTextDlg.WPRichText1.WordWrap := true;
                  RtfTextDlg.WPRichText1.LayoutMode := wplayNormal;   *)

      end;
    {$ENDIF}
{$ENDIF}
      ;
    end;
    // RtfTextDlg.RtfTextEdit.LayoutMode := wplayNormal;
    if RtfTextDlg.ShowModal = IDOK then
    begin
      ed := GetComponent(0);
      if ed <> nil then
      begin
        if ed is TWPCustomRtfEdit then
        begin
          RtfTextDlg.SetToRTFText((ed as TWPCustomRtfEdit).RtfText);
          (ed as TWPCustomRtfEdit).Header.SetDefaultWH
            (RtfTextDlg.WPRichText1.Header); // V5.12.5
          (ed as TWPCustomRtfEdit).ReformatAll;
        end
        else if ed is TWPCustomRtfLabel then
        begin
          RtfTextDlg.SetToRTFText((ed as TWPCustomRtfLabel).RtfText);
          (ed as TWPCustomRtfLabel).RTFData.Header.SetDefaultWH
            (RtfTextDlg.WPRichText1.Header); // V5.12.5
          (ed as TWPCustomRtfLabel).ReformatAll;
        end
        else if ed is TWPRTFStorage then
        begin
          RtfTextDlg.SetToRTFText((ed as TWPRTFStorage).RtfText);
        end
{$IFDEF WPQUICK}
        else if ed is TWPQuickPrint then
          RtfTextDlg.SetToRTFText((ed as TWPQuickPrint).RtfText)
{$ENDIF}
{$IFDEF WP8}
    {$IFDEF WPREPORTER}
        else if ed is TWPBlockTemplate then
        begin
          RtfTextDlg.SetToRTFText((ed as TWPBlockTemplate).TemplateText);
        end;
    {$ENDIF}
{$ENDIF}
            ;
        Modified;
      end;
    end;
  finally
    RtfTextDlg.Free;
  end;
end;

// -------------------------------------------------------------------- TEXT ---

procedure TWPRTFTextEdit.Edit;
begin
  ExecuteVerb(1);
end;

procedure TWPRTFTextEdit.ExecuteVerb(Index: Integer);
var
  ed: TPersistent;
  RtfTextDlg: TWPToolsEditor;
  function GetRTFText: TWPRTFBlobContents;
  begin
    if ed is TWPCustomRtfEdit then
      Result := (ed as TWPCustomRtfEdit).RtfText
    else if ed is TWPCustomRtfLabel then
      Result := (ed as TWPCustomRtfLabel).RtfText
    else if ed is TWPRTFStorage then
      Result := (ed as TWPRTFStorage).RtfText
{$IFDEF WPQUICK}
    else if ed is TWPQuickPrint then
      Result := (ed as TWPQuickPrint).RtfText
{$ENDIF}
{$IFDEF WP8}
  {$IFDEF WPREPORTER}
    else if ed is TWPBlockTemplate then
      Result := (ed as TWPBlockTemplate).TemplateText
  {$ENDIF}
{$ENDIF}
    else
      raise Exception.Create('Wrong Control for Command');
  end;

var
  wp: TWPCustomRtfEdit;
  dia: TWPPagePropDlg;
  {$IFDEF WP8}
  rtf : TWPRTFDataBlock;
  {$ENDIF}
begin
  RtfTextDlg := nil;
  ed := Component;
  if Index = 1 then
    try
      RtfTextDlg := TWPToolsEditor.Create(nil);
      RtfTextDlg.WPDefAct.OnInfo := WPToolsInfo;
      RtfTextDlg.WPDefAct.InsertFormField1.Visible := TRUE;
      RtfTextDlg.ToolPanel.Visible := TRUE;
      if ed <> nil then
      begin
        RtfTextDlg.GetFromRTFText(GetRTFText);
        if ed is TWPCustomRtfEdit then
          RtfTextDlg.WPRichText1.Header.Assign(TWPCustomRtfEdit(ed).Header)
          {$IFDEF WP8}
            {$IFDEF WPREPORTER}
              else if ed is TWPTableProducer then
              begin
                  RtfTextDlg.WPRichText1.RTFData.GetLayerNames(wpIsOwnerSelected, RtfTextDlg.cbLayerList.Items, true);
                  if RtfTextDlg.cbLayerList.Items.Count>0 then
                  begin
                     rtf := TWPRTFDataBlock(RtfTextDlg.cbLayerList.Items.Objects[0]);
                     RtfTextDlg.cbLayerList.ItemIndex := 0;
                  end
                  else
                  begin
                     rtf := TWPRTFDataBlock(RtfTextDlg.WPRichText1.RTFData.Add);
                     rtf.Kind := wpIsOwnerSelected;
                     rtf.Name := 'New' + IntToStr(RtfTextDlg.WPRichText1.RTFData.Count);
                  end;
                  RtfTextDlg.WPRichText1.DisplayedText := rtf;
                  RtfTextDlg.WPRichText1.ActiveText := rtf;
                  RtfTextDlg.WPRichText1.WordWrap := true;
                  RtfTextDlg.WPRichText1.LayoutMode := wplayNormal;
              end
            {$ENDIF}
          {$ENDIF}
          ;

      end;

      if RtfTextDlg.ShowModal = IDOK then
      begin
        ed := Component;
        if ed <> nil then
        begin
          RtfTextDlg.SetToRTFText(GetRTFText);
          if ed is TWPCustomRtfEdit then
            TWPCustomRtfEdit(ed).Header.SetDefaultWH
              (RtfTextDlg.WPRichText1.Header);
        end;
      end;
      Designer.Modified;
    finally
      RtfTextDlg.Free;
    end
  else if Index = 2 then
  begin
    with TOpenDialog.Create(nil) do
      try
        Filter := WPLoadStr(meFilter);
        if execute then
          GetRTFText.LoadFromFile(FileName);
        if ed is TWPCustomRtfEdit then
        begin
          (ed as TWPCustomRtfEdit).RtfText.Apply;
          (ed as TWPCustomRtfEdit).ReformatAll;
        end
        else if ed is TWPCustomRtfLabel then
        begin
          (ed as TWPCustomRtfLabel).RtfText.Apply;
          (ed as TWPCustomRtfLabel).ReformatAll;
        end;
      finally
        Free;
      end;
    Designer.Modified;
  end
  else if Index = 3 then
  begin
    with TSaveDialog.Create(nil) do
      try
        Filter := WPLoadStr(meFilter);
        if execute then
          GetRTFText.SaveToFile(FileName);
      finally
        Free;
      end;
    Designer.Modified;
  end
  else if Index = 4 then
  begin
    if MessageDlg('Clear the text?', mtConfirmation, [mbYes, mbNo], 0) = idYes
    then
    begin
      GetRTFText.Clear;
      if ed is TWPCustomRtfEdit then
      begin
        (ed as TWPCustomRtfEdit).Clear;
        (ed as TWPCustomRtfEdit).Invalidate;
      end
      else if ed is TWPCustomRtfLabel then
      begin
        (ed as TWPCustomRtfLabel).Clear;
        (ed as TWPCustomRtfLabel).Invalidate;
      end;
    end;
  end
  else if Index = 5 then // Change Page Size (Current and Default)
  begin
    wp := TWPCustomRtfEdit.CreateDynamic;

    if ed is TWPCustomRtfEdit then
      wp.Header._Layout := TWPCustomRtfEdit(ed).Header._Layout
    else if ed is TWPCustomRtfLabel then
      wp.Header._Layout := TWPCustomRtfLabel(ed).Header._Layout;

    dia := TWPPagePropDlg.Create(nil);
    dia.Options := [];
    dia.EditBox := wp;
    try
      if dia.execute then
      begin
        if ed is TWPCustomRtfEdit then
        begin
          TWPCustomRtfEdit(ed).Header._Layout := wp.Header._Layout;
          TWPCustomRtfEdit(ed).Header.RecalcLayout;
          { TWPCustomRtfEdit(ed).Header.Landscape := FALSE;
            TWPCustomRtfEdit(ed).Header.SetPageWH(
            wp.Header.PageWidth, wp.Header.PageHeight,
            wp.Header.LeftMargin, wp.Header.TopMargin,
            wp.Header.RightMargin, wp.Header.BottomMargin);
            TWPCustomRtfEdit(ed).Header.MarginHeader := wp.Header.MarginHeader;
            TWPCustomRtfEdit(ed).Header.MarginFooter := wp.Header.MarginFooter;
            TWPCustomRtfEdit(ed).Header.Landscape := wp.Header.Landscape;
          }
          TWPCustomRtfEdit(ed).Header.SetDefaultWH(wp.Header);

          TWPCustomRtfEdit(ed).ReformatAll(false, false);
        end
        else if ed is TWPCustomRtfLabel then
        begin
          TWPCustomRtfLabel(ed).Header._Layout := wp.Header._Layout;
          TWPCustomRtfLabel(ed).Header.RecalcLayout;
          { TWPCustomRtfLabel(ed).Header.Landscape := FALSE;
            TWPCustomRtfLabel(ed).Header.SetPageWH(
            wp.Header.PageWidth, wp.Header.PageHeight,
            wp.Header.LeftMargin, wp.Header.TopMargin,
            wp.Header.RightMargin, wp.Header.BottomMargin);
            TWPCustomRtfLabel(ed).Header.MarginHeader := wp.Header.MarginHeader;
            TWPCustomRtfLabel(ed).Header.MarginFooter := wp.Header.MarginFooter;
            TWPCustomRtfLabel(ed).Header.Landscape := FALSE;
            wp.Header.Landscape; }

          TWPCustomRtfLabel(ed).Header.DefaultLandscape := wp.Header.Landscape;
          TWPCustomRtfLabel(ed).Header.DefaultPageWidth := wp.Header.PageWidth;
          TWPCustomRtfLabel(ed).Header.DefaultPageHeight :=
            wp.Header.PageHeight;
          TWPCustomRtfLabel(ed).Header.DefaultLeftMargin :=
            wp.Header.LeftMargin;
          TWPCustomRtfLabel(ed).Header.DefaultTopMargin := wp.Header.TopMargin;
          TWPCustomRtfLabel(ed).Header.DefaultRightMargin :=
            wp.Header.RightMargin;
          TWPCustomRtfLabel(ed).Header.DefaultBottomMargin :=
            wp.Header.BottomMargin;
          TWPCustomRtfLabel(ed).Header.DefaultMarginHeader :=
            wp.Header.MarginHeader;
          TWPCustomRtfLabel(ed).Header.DefaultMarginFooter :=
            wp.Header.MarginFooter;
          TWPCustomRtfLabel(ed).ReformatAll(false, false);
          TWPCustomRtfLabel(ed).Invalidate;
        end;
      end;
    finally
      dia.Free;
      wp.Free;
    end;
  end
  else if (Index = 6) then
  begin
    if not(ed is TWPCustomRtfEdit) then
      ShowMessage('QuickConfig is only supported for editors!')
    else
      with TWPQuickConfig.Create(nil) do
        try
          EditBox := ed as TWPCustomRtfEdit;
          ShowModal;
        finally
          Free;
        end;
  end;
end;

function TWPRTFTextEdit.GetVerb(Index: Integer): string;
begin
  case Index of
    0:
      Result := String('WPTools by WPCubed GmbH, V' + #32 + WPToolsVersion);
    1:
      Result := 'Edit the Text';
    2:
      Result := 'Load the Text';
    3:
      Result := 'Save the Text';
    4:
      Result := 'Clear the Text';
    5:
      Result := 'Change Page Size (Current and Default)';
    6:
      Result := 'QuickConfig (FormatOptions, EditOptions, LayoutMode)'
  else
    Result := '';
  end;
end;

function TWPRTFTextEdit.GetVerbCount: Integer;
begin
  Result := 6;
  if Component is TWPCustomRichText then
    inc(Result);
end;



// ------------------------------------------------------- STYLE COLLECTION ----

procedure TWPToolbarConfigStringEdit.ExecuteVerb(Index: Integer);
var
  ed: TPersistent;
begin
  ed := Component;
  if (ed <> nil) and (ed is TWPToolBar) then
  begin
    if Index = 1 then
    begin
      TWPToolBar(ed).BeginUpdate;
      try
        TWPToolBar(ed).sel_ListBoxes := [];
        TWPToolBar(ed).sel_StatusIcons := [];
        TWPToolBar(ed).sel_ActionIcons := [];
        TWPToolBar(ed).sel_DatabaseIcons := [];
        TWPToolBar(ed).sel_EditIcons := [];
        TWPToolBar(ed).sel_InsertIcons := [];
        TWPToolBar(ed).sel_TableIcons := [];
        TWPToolBar(ed).sel_OutlineIcons := [];
      finally
        TWPToolBar(ed).EndUpdate;
      end;
      Designer.Modified;
    end
    else if WPToolbarConfigurate(TWPToolBar(ed), nil,
      TWPToolBar(ed).Name + '->ConfigString') then
      Designer.Modified;
  end;
end;

function TWPToolbarConfigStringEdit.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Configure Toolbar'
  else if Index = 1 then
    Result := 'Clear "Sel" properties';
end;

function TWPToolbarConfigStringEdit.GetVerbCount: Integer;
begin
  Result := 2;
end;

function TWPToolbarConfigStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TWPToolbarConfigStringProperty.SetValue(const Value: string);
var
  ed: TPersistent;
begin
  Fvalue := Value;
  ed := GetComponent(0);
  if ed <> nil then
  begin
    if ed is TWPToolBar then
      (ed as TWPToolBar).ConfigString := Value;
  end;
end;

function TWPToolbarConfigStringProperty.GetValue: String;
var
  ed: TPersistent;
begin
  ed := GetComponent(0);
  if ed <> nil then
  begin
    if ed is TWPToolBar then
      Result := (ed as TWPToolBar).ConfigString;
  end
  else
    Result := Fvalue;
end;

procedure TWPToolbarConfigStringProperty.Edit;
var
  ed: TPersistent;
begin
  ed := GetComponent(0);
  if ed <> nil then
  begin
    if (ed <> nil) and (ed is TWPToolBar) then
    begin
      if WPToolbarConfigurate(TWPToolBar(ed), nil, TWPToolBar(ed).Name +
        '->ConfigString') then
        Designer.Modified;
    end;
  end;
end;

// ------------------------------------------------------- STYLE COLLECTION ----

function TWPStyleCollectEdit.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TWPStyleCollectEdit.ExecuteVerb(Index: Integer);
var
  ed: TPersistent;
  StyleDlg: TWPStyleDlg;
begin
  if Index = 0 then
  begin
    StyleDlg := TWPStyleDlg.Create(nil);
    try
      ed := Component;
      if (ed <> nil) and (ed is TWPStyleCollection) then
      begin
        StyleDlg.StyleCollection := (ed as TWPStyleCollection);
        StyleDlg.execute;
        Designer.Modified;
      end
      else if (ed <> nil) and (ed is TWPRTFProps) then
      begin
        StyleDlg.WPRTFPropsComponent := (ed as TWPRTFProps);
        StyleDlg.execute;
        Designer.Modified;
      end;
    finally
      StyleDlg.Free;
    end;
  end;
end;

function TWPStyleCollectEdit.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Edit Styles';
end;

{ TWPStylesProperty }

function TWPStylesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TWPStylesProperty.SetValue(const Value: string);
begin

end;

function TWPStylesProperty.GetValue: string;
begin
  Result := 'Paragraph Styles';
end;

destructor TWPStylesProperty.Destroy;
begin
  inherited Destroy;
end;

procedure TWPStylesProperty.Edit;
var
  ed: TPersistent;
  StyleDlg: TWPStyleDlg;
begin
  StyleDlg := TWPStyleDlg.Create(nil);
  try
    ed := GetComponent(0);
    if (ed <> nil) and (ed is TWPStyleCollection) then
    begin
      StyleDlg.StyleCollection := (ed as TWPStyleCollection);
      StyleDlg.execute;
      Modified;
    end;
  finally
    StyleDlg.Free;
  end;
end;

{$IFDEF WP8}//<WP8
destructor TWPAStyleProperty.Destroy;
begin
   inherited Destroy;
end;

function TWPAStyleProperty.GetAttributes: TPropertyAttributes;
begin
   Result := [paDialog];
end;

procedure TWPAStyleProperty.Edit;
var
  ed: TPersistent;
  StyleDlg: TWPOneStyleDlg;
begin
  StyleDlg := TWPOneStyleDlg.Create(nil);
  try
    ed := GetComponent(0);
    if (ed <> nil) and (ed is TWPParStyle) then
    begin
      StyleDlg.ProtectNames := true;
      StyleDlg.StyleCollection := TWPParStyle(ed).StyleCollection;
      StyleDlg.StyleName := TWPParStyle(ed).Name;
      StyleDlg.StyleBasedOn := TWPParStyle(ed).BasedOnStyle;
      StyleDlg.StyleNext := TWPParStyle(ed).NextStyle;
      StyleDlg.execute;
      TWPParStyle(ed).Name := StyleDlg.StyleName;
      TWPParStyle(ed).BasedOnStyle := StyleDlg.StyleBasedOn;
      TWPParStyle(ed).NextStyle := StyleDlg.StyleNext;
      Modified;
    end;


    // Styles in a TWPValueList
    {$IFDEF WPREPORTER}
    if (ed <> nil) and (ed is TWPColTemplate) or (ed is TWPTemplateStyle) then
    begin
      StyleDlg.ProtectNames := true;
      StyleDlg.StyleCollection := nil;
      StyleDlg.StyleName := GetName;
      StyleDlg.StyleDef.Text := GetValue;;
      StyleDlg.StyleBasedOn := '';
      StyleDlg.StyleNext := '';
      StyleDlg.UseStyleDef := true;
      if StyleDlg.execute then
        SetValue(StyleDlg.StyleDef.Text);
      Modified;
    end;
    {$ENDIF}
  finally
    StyleDlg.Free;
  end;
end;

procedure TWPAStyleProperty.SetValue(const Value: string);
 var
  ed: TPersistent;
  n : String;
begin
  ed := GetComponent(0);
  if ed <> nil then
  begin
    if ed is TWPParStyle then
    begin
      // Writing to this string is not really supported.
      TWPParStyle(ed).Values.SemiColonText := Value;
    end
    {$IFDEF WPREPORTER}
    else if ed is TWPTemplateStyle then
    begin
      TWPTemplateStyle(ed).Style.Text := Value;
    end

    else if ed is TWPColTemplate then
    begin
      n := GetName;
    (*  if n='RowStyle' then TWPColTemplate(ed).RowStyle.Text := Value
      else if n='HeaderStyle' then TWPColTemplate(ed).HeaderStyle.Text := Value
      else if n='FooterStyle' then TWPColTemplate(ed).FooterStyle.Text := Value;  *)
    end
    {$ENDIF}
    else SetStrValue(Value);
  end
  else SetStrValue(Value);
end;

function TWPAStyleProperty.GetValue: string;
var
  ed: TPersistent; n : string;
begin
  ed := GetComponent(0);

  if ed <> nil then
  begin
    if ed is TWPParStyle then
      Result := TWPParStyle(ed).Values.SemiColonText
    {$IFDEF WPREPORTER}
    else if ed is TWPTemplateStyle then
    begin
     Result := TWPTemplateStyle(ed).Style.Text;
    end
    else if ed is TWPColTemplate then
    begin
      n := GetName;
    (*  if n='RowStyle' then Result := TWPColTemplate(ed).RowStyle.Text
      else if n='HeaderStyle' then Result := TWPColTemplate(ed).HeaderStyle.Text
      else if n='FooterStyle' then Result := TWPColTemplate(ed).FooterStyle.Text
      else *) Result := 'undef.';
    end
    {$ENDIF}
    else Result := GetStrValue;
  end else Result := GetStrValue;
end;

{$ENDIF}//>WP8

{$IFDEF DELPHI6ANDUP}

function TWPCustomAttrDlgEdit.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TWPCustomAttrDlgEdit.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Preview Dialog';
end;

function TWPCustomAttrDlgEdit.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TWPCustomAttrDlgEdit.Edit;
var
  ed: TPersistent;
begin
  try
    ed := GetComponent;
    if (ed <> nil) and (ed is TWPCustomAttrDlg) then
    begin
      TWPCustomAttrDlg(ed).execute;
    end;
  except
  end;
end;
{$ENDIF}



{$IFDEF WP8}
 {$IFDEF WPREPORTER}
{TWPFieldNameProperty}
function TWPDBFieldNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TWPDBFieldNameProperty.GetValueList(List: TStrings);
var
  iObjectWithDataset : IWPObjectWithDataset;
  Ctrl : TPersistent;
begin
  Ctrl :=  GetComponent(0);
  if Ctrl is TWPDataSourceLink then
  begin
    if (TWPDataSourceLink(Ctrl).DataSource<>nil) and
       (TWPDataSourceLink(Ctrl).DataSource.DataSet<>nil)
         then  TWPDataSourceLink(Ctrl).DataSource.DataSet.GetFieldNames(List);
  end else
  {$IFDEF WPREPORTER}
  if Ctrl is TWPColTemplateDB then
  begin
    if (TWPColTemplateDB(Ctrl).GetBlockTemplate<>nil) and
       (TWPColTemplateDB(Ctrl).GetBlockTemplate.DataLink<>nil) and
       (TWPColTemplateDB(Ctrl).GetBlockTemplate.DataLink.DataSet<>nil)
         then  TWPColTemplateDB(Ctrl).GetBlockTemplate.DataLink.DataSet.GetFieldNames(List);
  end else
  {$ENDIF}
  {$IFNDEF VER130}
  // This code disturbs the form designer
  if Ctrl.GetInterface(IWPObjectWithDataset, iObjectWithDataset) and
     (iObjectWithDataset.LinkedDataset<>nil) then
       TDataSet( iObjectWithDataset.LinkedDataset ).GetFieldNames(List)
   {$ENDIF}
     ; // Data.DB
end;

procedure TWPDBFieldNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;


function TWPDBSourceNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;


procedure TWPDBSourceNameProperty.GetValueList(List: TStrings);
var
  Ctrl : TPersistent;
begin
  Ctrl :=  GetComponent(0);
  if Ctrl is TWPBlockTemplateDB then
  begin
    TWPTableProducerDB(TWPBlockTemplateDB(Ctrl).TableTemplates.TableProducer).DataSourceLinks.GetNameList(List);
  end;
end;

procedure TWPDBSourceNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

function TWPBlockNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TWPBlockNameProperty.GetValueList(List: TStrings);
var
  Ctrl : TPersistent;
begin
  Ctrl :=  GetComponent(0);
  if Ctrl is TWPBlockTemplate then
       TWPBlockTemplate(Ctrl).TableTemplates.GetNameList(List)
  else if Ctrl is TWPTableProducer then
       TWPTableProducer(Ctrl).Blocks.GetNameList(List);

end;

procedure TWPBlockNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;
{$ENDIF}
{$ENDIF}

{$ENDIF NODsgnIntf}   


end.
