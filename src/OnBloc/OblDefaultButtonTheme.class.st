Class {
	#name : #OBlDefaultButtonTheme,
	#superclass : #OBlTheme,
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
	#category : #'OnBloc-Theme'
}

{ #category : #accessing }
OBlDefaultButtonTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultButtonTheme >> defaultBorderColor [
	^ defaultBorderColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> defaultBorderColor: anObject [
	defaultBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultButtonTheme >> defaultTextColor [
	^ defaultTextColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> defaultTextColor: anObject [
	defaultTextColor := anObject
]

{ #category : #accessing }
OBlDefaultButtonTheme >> disabledBackgroundColor [
	^ disabledBackgroundColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> disabledBackgroundColor: anObject [
	disabledBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultButtonTheme >> disabledBorderColor [
	^ disabledBorderColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> disabledBorderColor: anObject [
	disabledBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultButtonTheme >> disabledTextColor [
	^ disabledTextColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> disabledTextColor: anObject [
	disabledTextColor := anObject
]

{ #category : #accessing }
OBlDefaultButtonTheme >> hoveredBorderColor [
	^ hoveredBorderColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> hoveredBorderColor: anObject [
	hoveredBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultButtonTheme >> hoveredTextColor [
	^ hoveredTextColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> hoveredTextColor: anObject [
	hoveredTextColor := anObject
]

{ #category : #initialization }
OBlDefaultButtonTheme >> initialize [
	super initialize.
	disabledBackgroundColor := OBlDefaultColors
		disabledButtonBackgroundColor.
	disabledTextColor := OBlDefaultColors disabledButtonTextColor.
	disabledBorderColor := OBlDefaultColors disabledButtonBorderColor.
	pressedBorderColor := OBlDefaultColors pressedButtonBorderColor.
	defaultBorderColor := OBlDefaultColors defaultButtonBorderColor.
	defaultTextColor := OBlDefaultColors defaultButtonTextColor.
	hoveredBorderColor := OBlDefaultColors hoveredButtonBorderColor.
	pressedTextColor := OBlDefaultColors pressedButtonTextColor.
	defaultBackgroundColor := OBlDefaultColors
		defaultButtonBackgroundColor.
	hoveredTextColor := OBlDefaultColors hoveredButtonTextColor.
	textHighlightColor := OBlDefaultColors textHighlightColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> pressedBorderColor [
	^ pressedBorderColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> pressedBorderColor: anObject [
	pressedBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultButtonTheme >> pressedTextColor [
	^ pressedTextColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> pressedTextColor: anObject [
	pressedTextColor := anObject
]

{ #category : #accessing }
OBlDefaultButtonTheme >> textHighlightColor [
	^ textHighlightColor
]

{ #category : #accessing }
OBlDefaultButtonTheme >> textHighlightColor: anObject [
	textHighlightColor := anObject
]
