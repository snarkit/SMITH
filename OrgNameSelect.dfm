�
 TORGNAMESELECTFORM 0  TPF0TOrgNameSelectFormOrgNameSelectFormLeft� Top� Margins.Left
Margins.Top
Margins.Right
Margins.Bottom
Caption$Find an organism by one of its namesClientHeight�ClientWidth�Color��� Font.CharsetDEFAULT_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameArial Unicode MS
Font.Style OldCreateOrder
OnActivateFormActivateOnClose	FormCloseOnCreate
FormCreate	OnDestroyFormDestroy
DesignSize�� PixelsPerInchx
TextHeight TPanelNavPanelLeft Top Width�HeightAAlignalTopCaptionNavPanelShowCaptionTabOrder 
DesignSize�A  	TGroupBoxJumpGBLeft�TopWidthHeight<Margins.LeftMargins.TopMargins.RightMargins.BottomCaptionJump to next name containingTabOrder  TButton
JumpButtonLeft� TopWidthPHeightMargins.LeftMargins.TopMargins.RightMargins.BottomCaptionGoTabOrder OnClickJumpButtonClick  TEditJumpLeftTopWidth� HeightMargins.LeftMargins.TopMargins.RightMargins.BottomFont.CharsetDEFAULT_CHARSET
Font.Color @� Font.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder   TRadioGroupSortRGLeftTop Width�Height6Margins.LeftMargins.TopMargins.RightMargins.BottomCaptionSort byColumns	ItemIndex Items.StringsCodeNameLanguageDate modified TabOrderOnClickSortRGClick  TButtonCancelButtonLeft;TopWidth`Height%AnchorsakTopakRight Caption
Close listModalResultTabOrderOnClickCancelButtonClick  TIB_NavigationBarIB_NavigationBar1LeftTopWidth� HeightCtl3DParentCtl3DTabOrder
DataSource
NameGridDSReceiveFocusCustomGlyphsSupplied VisibleButtonsnbFirst	nbJumpBcknbPriornbNext	nbJumpFwdnbLast    TIB_GridNameQueryGridAlignWithMargins	Left
TopKWidth�Height�Margins.Left
Margins.Top
Margins.Right
Margins.Bottom
CustomGlyphsSupplied DefDrawBefore
DataSource
NameGridDSIgnoreColorScheme	AlignalClientFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial Unicode MS
Font.Style 
ParentFontOnClickNameQueryGridClickTabOrderDefaultRowHeightTrackGridRow	GridLinks.Strings                       ORGCODE)                       FULLNAME=WIDTH=300                        AUTHORITY                       LANGNAME                        PREFERRED#                       DATEMODIFIED                       COMMENTS EditLinks.StringsORGCODE                       FULLNAME                        AUTHORITY                       LANGUAGE                        PREFERRED#                       DATEMODIFIED                       COMMENTS RowLinesDrawingStyle
gdsClassicCurrentRowColor	clBtnFaceCurrentRowFont.CharsetDEFAULT_CHARSETCurrentRowFont.ColorclNavyCurrentRowFont.Height�CurrentRowFont.NameArial Unicode MSCurrentRowFont.Style OrderingFont.CharsetDEFAULT_CHARSETOrderingFont.ColorclMaroonOrderingFont.Height�OrderingFont.NameArial Unicode MSOrderingFont.Style FixedFont.CharsetDEFAULT_CHARSETFixedFont.ColorclMaroonFixedFont.Height�FixedFont.NameArial Unicode MSFixedFont.Style 
OnDrawCellNameQueryGridDrawCell  TPanelFilterPanelLeft�TopAWidth� Height�AlignalRightCaptionFilter ShowCaptionTabOrderVerticalAlignment
taAlignTop 	TGroupBoxContentFilterGBLeftTop:Width� HeighthMargins.LeftMargins.TopMargins.RightMargins.BottomCaptionShown names containTabOrder  TEditNameStrFilterLeftTopWidth� HeightMargins.LeftMargins.TopMargins.RightMargins.BottomFont.CharsetDEFAULT_CHARSET
Font.Color @� Font.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder OnEnterNameStrFilterEnterOnExitNameStrFilterExit  	TCheckBoxNameStrFilterCBLeftTopAWidth� HeightMargins.LeftMargins.TopMargins.RightMargins.BottomCaptionName string filter onTabOrderOnClickNameStrFilterCBClick   	TGroupBoxLanguageFilterGBLeftTop
Width� HeighthCaptionShow languagesTabOrder TLabelLabel1LeftTop_Width� HeightCaptionCTRL click for several  TListBoxLanguageListLeftTopxWidth� Height� StylelbOwnerDrawFixed
ItemHeightMultiSelect	TabOrder 
OnDrawItemLanguageListDrawItemOnEnterLanguageListEnterOnExitLanguageListExit  	TCheckBoxLanguageFilterCBLeft	Top>Width� HeightCaptionLanguages listed belowTabOrderOnClickLanguageFilterCBClick  	TCheckBoxPreferredOnlyCBLeft	Top Width� HeightMargins.LeftMargins.TopMargins.RightMargins.BottomCaptionOnly preferred namesChecked	State	cbCheckedTabOrderOnClickPreferredOnlyCBClick   	TGroupBoxPrefNameStringGBLeftTop�Width� HeightgMargins.LeftMargins.TopMargins.RightMargins.BottomCaptionPreferred name containsTabOrder TEditPrefnameFilterStrLeftTopWidth� HeightMargins.LeftMargins.TopMargins.RightMargins.BottomFont.CharsetDEFAULT_CHARSET
Font.Color @� Font.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder OnEnterPrefnameFilterStrEnterOnExitPrefnameFilterStrExit  	TCheckBoxPrefNameFilterCBLeftTopAWidth� HeightMargins.LeftMargins.TopMargins.RightMargins.BottomCaptionPref name filter onTabOrderOnClickPrefNameFilterCBClick   	TCheckBoxFromStartCBLeft&TopWidth� HeightCaptionFrom string startTabOrderOnClickFromStartCBClick  	TCheckBoxCaseCBLeft&TopWidth� HeightCaptionCase sensitiveTabOrderOnClickCaseCBClick   TButtonAcceptButtonLeft�TopWidthwHeight%AnchorsakTopakRight CaptionAcceptModalResultTabOrderOnClickAcceptButtonClick  TIB_DataSource
NameGridDSAutoEdit
AutoInsertDataset	NameQueryLeft�TopG  	TIB_Query	NameQueryColumnAttributes.StringsPREFERRED=BOOLEAN=', ' DatabaseName
LocalIMSDBFieldsDisplayLabel.StringsPREFERRED=PrefORGCODE=Code	NAME=NameAUTHORITY=AuthorityDATEMODIFIED=ModifiedL.LANGNAME=Language FieldsDisplayWidth.StringsPREFERRED=80
ORGCODE=80L.LANGNAME=110NAME=250 IB_ConnectionIMSDM.FBConnectionSQL.StringsSELECT l.sortorder, l.langname
, n.nameid, n.orgcode, n.fullname, n.authority, n.preferred, n.language, n.datemodified, n.commentsFROM EUORGNAMES n)JOIN LANGUAGES l ON l.langcode=n.language Left�TopD   