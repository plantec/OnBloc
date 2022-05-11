Class {
	#name : #OblDefaultButtonTheme,
	#superclass : #OblTheme,
	#instVars : [
		'disabledBackgroundColor',
		'disabledTextColor',
		'disabledBorderColor',
		'pressedBorderColor',
		'defaultBorderColor',
		'defaultTextColor',
		'hoveredBorderColor',
		'pressedTextColor',
		'defaultBackgroundColor',
		'hoveredTextColor',
		'textHighlightColor'
	],
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OblDefaultButtonTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #accessing }
OblDefaultButtonTheme >> defaultBorderColor [
	^ defaultBorderColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> defaultBorderColor: anObject [
	defaultBorderColor := anObject
]

{ #category : #accessing }
OblDefaultButtonTheme >> defaultTextColor [
	^ defaultTextColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> defaultTextColor: anObject [
	defaultTextColor := anObject
]

{ #category : #accessing }
OblDefaultButtonTheme >> disabledBackgroundColor [
	^ disabledBackgroundColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> disabledBackgroundColor: anObject [
	disabledBackgroundColor := anObject
]

{ #category : #accessing }
OblDefaultButtonTheme >> disabledBorderColor [
	^ disabledBorderColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> disabledBorderColor: anObject [
	disabledBorderColor := anObject
]

{ #category : #accessing }
OblDefaultButtonTheme >> disabledTextColor [
	^ disabledTextColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> disabledTextColor: anObject [
	disabledTextColor := anObject
]

{ #category : #accessing }
OblDefaultButtonTheme >> hoveredBorderColor [
	^ hoveredBorderColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> hoveredBorderColor: anObject [
	hoveredBorderColor := anObject
]

{ #category : #accessing }
OblDefaultButtonTheme >> hoveredTextColor [
	^ hoveredTextColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> hoveredTextColor: anObject [
	hoveredTextColor := anObject
]

{ #category : #initialization }
OblDefaultButtonTheme >> initialize [
	super initialize.
	disabledBackgroundColor := OblDefaultColors
		disabledButtonBackgroundColor.
	disabledTextColor := OblDefaultColors disabledButtonTextColor.
	disabledBorderColor := OblDefaultColors disabledButtonBorderColor.
	pressedBorderColor := OblDefaultColors pressedButtonBorderColor.
	defaultBorderColor := OblDefaultColors defaultButtonBorderColor.
	defaultTextColor := OblDefaultColors defaultButtonTextColor.
	hoveredBorderColor := OblDefaultColors hoveredButtonBorderColor.
	pressedTextColor := OblDefaultColors pressedButtonTextColor.
	defaultBackgroundColor := OblDefaultColors
		defaultButtonBackgroundColor.
	hoveredTextColor := OblDefaultColors hoveredButtonTextColor.
	textHighlightColor := OblDefaultColors textHighlightColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> pressedBorderColor [
	^ pressedBorderColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> pressedBorderColor: anObject [
	pressedBorderColor := anObject
]

{ #category : #accessing }
OblDefaultButtonTheme >> pressedTextColor [
	^ pressedTextColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> pressedTextColor: anObject [
	pressedTextColor := anObject
]

{ #category : #accessing }
OblDefaultButtonTheme >> textHighlightColor [
	^ textHighlightColor
]

{ #category : #accessing }
OblDefaultButtonTheme >> textHighlightColor: anObject [
	textHighlightColor := anObject
]
