�
 TORGSELECTFORM 0�  TPF0TOrgSelectFormOrgSelectFormLeft� Top� CaptionOrgSelectFormClientHeight�ClientWidthgColor @� Font.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder
OnActivateFormActivatePixelsPerInch`
TextHeight TLabelLabel1Left�ToptWidthHeight	AlignmenttaCenterFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabelLabel3Left�TopPWidth� HeightCaption:Select an organism by double clicking its CODE in the listFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontWordWrap	  	TCheckBoxPreferredCBLeftTop�Width� HeightCaptionShow only preferred namesChecked	State	cbCheckedTabOrder OnClickPreferredCBClick  TButtonAddOrgButtonLeft�Top� Width� Height9CaptionCIf the organism is not in the list, click HERE to edit the databaseTabOrderWordWrap	OnClickAddOrgButtonClick  TButtonCancelButtonLeft�Top Width� HeightCaptionCancel (no selection)ModalResultTabOrder  TIB_GridOrganismListLeftTopWidth�HeightEColorclWhite
DataSourceOrganismNameListDSFont.CharsetDEFAULT_CHARSET
Font.Color @� Font.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgConfirmDeletedgCancelOnExitdgMultiSelect 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWhiteTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style 
OnDblClickOrganismListDblClick  TRadioGroupSortRGLeft�ToplWidthQHeightMCaptionSort by	ItemIndex Items.StringsCodeName TabOrderOnClickSortRGClick  	TGroupBoxFilterGBLeftTopdWidth�Height1CaptionFilterTabOrder TLabelLabel4Left� TopWidthHeightCaption=Font.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  	TComboBoxFilterFieldCBLeft\TopWidthmHeightColorclWhiteFont.CharsetDEFAULT_CHARSET
Font.Color @� Font.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder Items.Stringspart of namegenusfamilyorder   TEdit	FilterStrLeft� TopWidth� HeightFont.CharsetDEFAULT_CHARSET
Font.Color @� Font.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder  	TCheckBoxFilterCBLeftTopWidthAHeightCaption	Filter onTabOrderOnClickFilterCBClick   	TGroupBoxJumpGBLeft� Top�Width� Height1CaptionJump to value startingTabOrder TButton
JumpButtonLeft� TopWidthAHeightCaptionGoTabOrder OnClickJumpButtonClick  TEditJumpLeftTopWidthrHeightFont.CharsetDEFAULT_CHARSET
Font.Color @� Font.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder   TButtonReturnButtonLeft�Top� Width� HeightCaptionReturn selectionTabOrderOnClickReturnButtonClick  TIB_DataSourceOrganismNameListDSDataSetOrgNamesForListQueryLeft�Top  	TIB_QueryOrgNamesForListQueryParams RecordCountAccurate	FieldOptions Left,Top   