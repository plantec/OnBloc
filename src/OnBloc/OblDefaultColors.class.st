Class {
	#name : #OBlDefaultColors,
	#superclass : #SharedPool,
	#classVars : [
		'ActiveColor',
		'BackdropColor',
		'ButtonBackgroundColor',
		'ButtonBorderColor',
		'ButtonHoveredBackgroundColor',
		'ButtonPressedBackgroundColor',
		'ButtonTextColor',
		'DarkBorderColor',
		'DefaultDividerBackgroundColor',
		'DefaultDividerBorderColor',
		'DeselectedListItemBackgroundColor',
		'DisabledButtonBackgroundColor',
		'DisabledButtonBorderColor',
		'DisabledButtonTextColor',
		'DisabledDividerBackgroundColor',
		'DisabledDividerBorderColor',
		'DisabledHeaderTextColor',
		'EditorBorderColor',
		'ErrorBackgroundColor',
		'ErrorBorderColor',
		'ExpandCollapseTriangleBackgroundColor',
		'FailureBackgroundColor',
		'FailureBorderColor',
		'FocusedEditorBorderColor',
		'HeaderBackgroundColor',
		'HeaderTextColor',
		'HoveredButtonBorderColor',
		'HoveredButtonTextColor',
		'HoveredDividerBackgroundColor',
		'HoveredDividerBorderColor',
		'HoveredListItemBackgroundColor',
		'HoveredListItemBorderColor',
		'LightBorderColor',
		'LinkColor',
		'LinkWithErrorColor',
		'NeutralBackgroundColor',
		'NewsBackgroundColor',
		'PaleErrorBackgroundColor',
		'PressedButtonBorderColor',
		'PressedButtonTextColor',
		'PressedDividerBackgroundColor',
		'PressedDividerBorderColor',
		'PressedListItemBackgroundColor',
		'PressedListItemBorderColor',
		'PrimaryBorderColor',
		'SecondaryHeaderBackgroundColor',
		'SelectedListItemBackgroundColor',
		'ShadowColor',
		'SuccessBackgroundColor',
		'SuccessBorderColor',
		'TextHighlightColor',
		'TextMarkupColor'
	],
	#category : #'OnBloc-Theme'
}

{ #category : #accessing }
OBlDefaultColors class >> backdropColor [
	^ BackdropColor
]

{ #category : #accessing }
OBlDefaultColors class >> darkBorderColor [
	^ DarkBorderColor
]

{ #category : #accessing }
OBlDefaultColors class >> darkBorderColor: anObject [
	DarkBorderColor := anObject
]

{ #category : #'button - background' }
OBlDefaultColors class >> defaultButtonBackgroundColor [
	^ ButtonBackgroundColor
]

{ #category : #'button - background' }
OBlDefaultColors class >> defaultButtonBackgroundColor: anObject [
	ButtonBackgroundColor := anObject
]

{ #category : #'button - border' }
OBlDefaultColors class >> defaultButtonBorderColor [
	^ ButtonBorderColor
]

{ #category : #'button - border' }
OBlDefaultColors class >> defaultButtonBorderColor: anObject [
	ButtonBorderColor := anObject
]

{ #category : #'button - text' }
OBlDefaultColors class >> defaultButtonTextColor [
	^ ButtonTextColor
]

{ #category : #'button - text' }
OBlDefaultColors class >> defaultButtonTextColor: anObject [
	ButtonTextColor := anObject
]

{ #category : #divider }
OBlDefaultColors class >> defaultDividerBackgroundColor [

	^ DefaultDividerBackgroundColor
]

{ #category : #divider }
OBlDefaultColors class >> defaultDividerBackgroundColor: aColor [

	DefaultDividerBackgroundColor := aColor
]

{ #category : #divider }
OBlDefaultColors class >> defaultDividerBorderColor [

	^ DefaultDividerBorderColor
]

{ #category : #divider }
OBlDefaultColors class >> defaultDividerBorderColor: aColor [

	DefaultDividerBorderColor := aColor
]

{ #category : #'header - background' }
OBlDefaultColors class >> defaultHeaderBackgroundColor [
	^ HeaderBackgroundColor
]

{ #category : #'header - text' }
OBlDefaultColors class >> defaultHeaderTextColor [
	^ HeaderTextColor
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> defaultListItemColor [
	^ self deselectedListItemColor
]

{ #category : #accessing }
OBlDefaultColors class >> defaultShadowColor [
	^ ShadowColor
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> deselectedListItemColor [
	^ DeselectedListItemBackgroundColor
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> deselectedtListItemColor: aColor [
	DeselectedListItemBackgroundColor := aColor
]

{ #category : #'button - background' }
OBlDefaultColors class >> disabledButtonBackgroundColor [
	^ DisabledButtonBackgroundColor
]

{ #category : #'button - background' }
OBlDefaultColors class >> disabledButtonBackgroundColor: anObject [
	DisabledButtonBackgroundColor := anObject
]

{ #category : #'button - border' }
OBlDefaultColors class >> disabledButtonBorderColor [
	^ DisabledButtonBorderColor
]

{ #category : #'button - border' }
OBlDefaultColors class >> disabledButtonBorderColor: anObject [
	DisabledButtonBorderColor := anObject
]

{ #category : #'button - text' }
OBlDefaultColors class >> disabledButtonTextColor [
	^ DisabledButtonTextColor
]

{ #category : #'button - text' }
OBlDefaultColors class >> disabledButtonTextColor: anObject [
	DisabledButtonTextColor := anObject
]

{ #category : #divider }
OBlDefaultColors class >> disabledDividerBackgroundColor [

	^ DisabledDividerBackgroundColor
]

{ #category : #divider }
OBlDefaultColors class >> disabledDividerBackgroundColor: aColor [

	DisabledDividerBackgroundColor := aColor
]

{ #category : #divider }
OBlDefaultColors class >> disabledDividerBorderColor [

	^ DisabledDividerBorderColor
]

{ #category : #divider }
OBlDefaultColors class >> disabledDividerBorderColor: aColor [

	DisabledDividerBorderColor := aColor
]

{ #category : #'header - text' }
OBlDefaultColors class >> disabledHeaderTextColor [
	^ DisabledHeaderTextColor
]

{ #category : #accessing }
OBlDefaultColors class >> distinctTenLightColors [
	"This is a list of 10 light colors that can be distinguished b
	the typical human eye even when seen together in the same picture.
	They complement the distinctTenStrongColors.
	They are described in the Show Me the Numbers book by Stephen Few"

	^ OrderedCollection new
		"red"
		add: (Color 
					h: Color red hue
					s: 0.3
					v: Color red brightness);
		"blue"
		add: (Color 
					h: Color blue hue
					s: 0.3
					v: Color blue brightness);
		"orange"
		add: (Color 
					h: Color orange hue
					s: 0.3
					v: Color orange brightness);
		"cyan"
		add: (Color 
					h: Color cyan hue
					s: 0.3 
					v: Color cyan brightness );
		"green"
		add: (Color 
					h: Color lightGreen hue
					s: 0.1
					v: 0.7);
		"pink"
		add: (Color 
					h: Color pink hue
					s: 0.1
					v: Color pink brightness);
		"brown"
		add: (Color 
					h: Color brown hue
					s: 0.2
					v: 1 );
		"purple"
		add: (Color 
					h: Color purple hue
					s: 0.2
					v: Color purple brightness );
		"yellow"
		add: (Color 
					h: Color yellow hue
					s: 0.3
					v: Color yellow brightness);
		"gray"
		add: (Color veryLightGray);
		yourself;


		yourself
]

{ #category : #accessing }
OBlDefaultColors class >> distinctTenStrongColors [
	"This is a list of 10 light colors that can be distinguished b
	the typical human eye even when seen together in the same picture.
	They complement the distinctTenLightColors.
	They are described in the Show Me the Numbers book by Stephen Few"

	^ (OrderedCollection new)
			add: Color red;
			add: Color blue;
			add: Color orange;
			add: Color cyan;
			add: Color green;
			add: Color pink;
			add: Color brown;
			add: Color purple;
			add: Color yellow;
			add: Color gray;
			yourself
]

{ #category : #'editor - border' }
OBlDefaultColors class >> editorBorderColor [
	^ EditorBorderColor
]

{ #category : #'editor - border' }
OBlDefaultColors class >> editorBorderColor: anObject [
	EditorBorderColor := anObject
]

{ #category : #'status - background' }
OBlDefaultColors class >> errorBackgroundColor [
	^ ErrorBackgroundColor
]

{ #category : #'status - background' }
OBlDefaultColors class >> errorBackgroundColor: aColor [
	ErrorBackgroundColor := aColor
]

{ #category : #'status - border' }
OBlDefaultColors class >> errorBorderColor [
	^ ErrorBorderColor
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> expandCollapseTriangleBackgroundColor [
	^ ExpandCollapseTriangleBackgroundColor
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> expandCollapseTriangleBackgroundColor: aColor [
	ExpandCollapseTriangleBackgroundColor := aColor
]

{ #category : #'status - background' }
OBlDefaultColors class >> failureBackgroundColor [
	^ FailureBackgroundColor
]

{ #category : #'status - background' }
OBlDefaultColors class >> failureBackgroundColor: aColor [
	FailureBackgroundColor := aColor
]

{ #category : #'status - border' }
OBlDefaultColors class >> failureBorderColor [
	^ FailureBorderColor
]

{ #category : #'editor - border' }
OBlDefaultColors class >> focusedEditorBorderColor [
	^ FocusedEditorBorderColor
]

{ #category : #'editor - border' }
OBlDefaultColors class >> focusedEditorBorderColor: anObject [
	FocusedEditorBorderColor := anObject
]

{ #category : #'list and tree items - border' }
OBlDefaultColors class >> focusedListItemBorder [
	^ self primaryBorderColor
]

{ #category : #'button - background' }
OBlDefaultColors class >> hoveredButtonBackgroundColor [

	^ ButtonHoveredBackgroundColor
]

{ #category : #'button - border' }
OBlDefaultColors class >> hoveredButtonBorderColor [
	^ HoveredButtonBorderColor
]

{ #category : #'button - border' }
OBlDefaultColors class >> hoveredButtonBorderColor: anObject [
	HoveredButtonBorderColor := anObject
]

{ #category : #'button - text' }
OBlDefaultColors class >> hoveredButtonTextColor [
	^ HoveredButtonTextColor
]

{ #category : #'button - text' }
OBlDefaultColors class >> hoveredButtonTextColor: anObject [
	HoveredButtonTextColor := anObject
]

{ #category : #divider }
OBlDefaultColors class >> hoveredDividerBackgroundColor [

	^ HoveredDividerBackgroundColor
]

{ #category : #divider }
OBlDefaultColors class >> hoveredDividerBackgroundColor: aColor [

	HoveredDividerBackgroundColor := aColor
]

{ #category : #divider }
OBlDefaultColors class >> hoveredDividerBorderColor [

	^ HoveredDividerBorderColor
]

{ #category : #divider }
OBlDefaultColors class >> hoveredDividerBorderColor: aColor [

	HoveredDividerBorderColor := aColor
]

{ #category : #'list and tree items - border' }
OBlDefaultColors class >> hoveredListItemBorderColor [

	^ HoveredListItemBorderColor
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> hoveredListItemColor [
	^ HoveredListItemBackgroundColor
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> hoveredListItemColor: aColor [
	HoveredListItemBackgroundColor := aColor
]

{ #category : #initialization }
OBlDefaultColors class >> initialize [
	LightBorderColor := Color fromHexString: #d9d9d9.
	DarkBorderColor := Color darkGray.
	PrimaryBorderColor := Color fromHexString: #'45abfe'.
	ActiveColor := Color fromHexString: #'096dd9'.

	"buttons - border"
	ButtonBorderColor := LightBorderColor.
	HoveredButtonBorderColor := PrimaryBorderColor.
	PressedButtonBorderColor := ActiveColor.
	DisabledButtonBorderColor := LightBorderColor.

	"status - border"
	SuccessBorderColor := Color fromHexString: #'389e0d' "green-7".
	ErrorBorderColor := Color fromHexString: #'cf1322' "red-7".
	FailureBorderColor := Color fromHexString: #'d48806' "gold-7".

	"buttons - background"
	ButtonBackgroundColor := Color white.
	DisabledButtonBackgroundColor := Color fromHexString: #f5f5f5 "grey-3".
	ButtonHoveredBackgroundColor := Color white darker.
	ButtonPressedBackgroundColor := ButtonHoveredBackgroundColor darker.

	"status - background"
	PaleErrorBackgroundColor := Color fromHexString: #'#ffccc7' "red-2".
	ErrorBackgroundColor := Color fromHexString: #ff7875 "red-4".
	SuccessBackgroundColor := Color fromHexString: #'95de64' "green-4".
	FailureBackgroundColor := Color fromHexString: #ffd666 "gold-4".
	NeutralBackgroundColor := Color fromHexString: #'f0f0f0' "gray-4".
	NewsBackgroundColor := Color fromHexString: #'fff1b8' "gold-2".
	
	"buttons - text"
	ButtonTextColor := Color black alpha: 0.65.
	HoveredButtonTextColor := PrimaryBorderColor.
	PressedButtonTextColor := ActiveColor.
	DisabledButtonTextColor := Color black alpha: 0.25.

	"background"
	BackdropColor := Color r: 240 g: 240 b: 240 range: 255.
	ShadowColor := Color r: 200 g: 200 b: 200 range: 255.
	
	"header - background"
	HeaderBackgroundColor := Color fromHexString: #'d9d9d9'. "grey-5"
	SecondaryHeaderBackgroundColor := Color fromHexString: #'e8e8e8'. "grey-6"
	
	"header - text"
	HeaderTextColor := Color black alpha: 0.85.
	DisabledHeaderTextColor := Color black alpha: 0.25.
	
	"highlighting - text"
	TextHighlightColor := Color fromHexString: #ffd666.
	TextMarkupColor := Color black alpha: 0.6.
	
	"list and tree items"
	DeselectedListItemBackgroundColor := Color transparent.
	HoveredListItemBackgroundColor := Color veryVeryLightGray alpha: 0.1.
	HoveredListItemBorderColor := Color gray alpha: 0.3.
	SelectedListItemBackgroundColor := Color gray darker.
	PressedListItemBackgroundColor := Color gray alpha: 0.2. 
	PressedListItemBorderColor := Color gray alpha: 0.4. 
	ExpandCollapseTriangleBackgroundColor := Color fromHexString: #'d9d9d9'. "grey-5"

	"editors"
	EditorBorderColor := LightBorderColor.
	FocusedEditorBorderColor := PrimaryBorderColor.
	
	" dividers "
	DefaultDividerBorderColor := Color veryLightGray muchLighter.
	DefaultDividerBackgroundColor := Color veryLightGray muchLighter.
	DisabledDividerBackgroundColor := Color transparent.
	DisabledDividerBorderColor := Color transparent.
	PressedDividerBorderColor := Color transparent.
	PressedDividerBackgroundColor := Color lightGray.
	HoveredDividerBorderColor := Color transparent.
	HoveredDividerBackgroundColor := Color veryLightGray.
	
	"others"
	LinkColor := Color fromHexString: #'096dd9'.
	LinkWithErrorColor := Color fromHexString: #cf1322.
]

{ #category : #accessing }
OBlDefaultColors class >> lightBorderColor [
	^ LightBorderColor
]

{ #category : #accessing }
OBlDefaultColors class >> lightBorderColor: anObject [
	LightBorderColor := anObject
]

{ #category : #links }
OBlDefaultColors class >> linkColor [
	^ LinkColor
]

{ #category : #links }
OBlDefaultColors class >> linkWithErrorColor [
	^ LinkWithErrorColor
]

{ #category : #'status - background' }
OBlDefaultColors class >> neutralBackgroundColor [
	^ NeutralBackgroundColor
]

{ #category : #accessing }
OBlDefaultColors class >> newsBackgroundColor [
	^ NewsBackgroundColor
]

{ #category : #'status - background' }
OBlDefaultColors class >> paleErrorBackgroundColor [
	^ PaleErrorBackgroundColor
]

{ #category : #'button - background' }
OBlDefaultColors class >> pressedButtonBackgroundColor [

	^ ButtonPressedBackgroundColor
]

{ #category : #'button - border' }
OBlDefaultColors class >> pressedButtonBorderColor [
	^ PressedButtonBorderColor
]

{ #category : #'button - border' }
OBlDefaultColors class >> pressedButtonBorderColor: anObject [
	PressedButtonBorderColor := anObject
]

{ #category : #'button - text' }
OBlDefaultColors class >> pressedButtonTextColor [
	^ PressedButtonTextColor
]

{ #category : #'button - text' }
OBlDefaultColors class >> pressedButtonTextColor: anObject [
	PressedButtonTextColor := anObject
]

{ #category : #divider }
OBlDefaultColors class >> pressedDividerBackgroundColor [

	^ PressedDividerBackgroundColor
]

{ #category : #divider }
OBlDefaultColors class >> pressedDividerBackgroundColor: aColor [

	PressedDividerBackgroundColor := aColor
]

{ #category : #divider }
OBlDefaultColors class >> pressedDividerBorderColor [

	^ PressedDividerBorderColor
]

{ #category : #divider }
OBlDefaultColors class >> pressedDividerBorderColor: aColor [

	PressedDividerBorderColor := aColor
]

{ #category : #'list and tree items - border' }
OBlDefaultColors class >> pressedListItemBorderColor [

	^ PressedListItemBorderColor
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> pressedListItemColor [
	^ PressedListItemBackgroundColor 
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> pressedListItemColor: aColor [
	PressedListItemBackgroundColor := aColor
]

{ #category : #accessing }
OBlDefaultColors class >> primaryBorderColor [
	^ PrimaryBorderColor
]

{ #category : #accessing }
OBlDefaultColors class >> primaryBorderColor: anObject [
	PrimaryBorderColor := anObject
]

{ #category : #'header - background' }
OBlDefaultColors class >> secondaryHeaderBackgroundColor [
	^ SecondaryHeaderBackgroundColor
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> selectedListItemColor [
	^ SelectedListItemBackgroundColor
]

{ #category : #'list and tree items - background' }
OBlDefaultColors class >> selectedListItemColor: aColor [
	SelectedListItemBackgroundColor := aColor
]

{ #category : #accessing }
OBlDefaultColors class >> shadowColor [
	^ ShadowColor
]

{ #category : #'status - background' }
OBlDefaultColors class >> successBackgroundColor [
	^ SuccessBackgroundColor
]

{ #category : #'status - background' }
OBlDefaultColors class >> successBackgroundColor: aColor [
	SuccessBackgroundColor := aColor
]

{ #category : #'status - border' }
OBlDefaultColors class >> successBorderColor [
	^ SuccessBorderColor
]

{ #category : #'button - border' }
OBlDefaultColors class >> textHighlightColor [
	^ TextHighlightColor
]

{ #category : #'button - border' }
OBlDefaultColors class >> textHighlightColor: anObject [
	TextHighlightColor := anObject
]

{ #category : #'header - text' }
OBlDefaultColors class >> textMarkupColor [
	^ TextMarkupColor
]
