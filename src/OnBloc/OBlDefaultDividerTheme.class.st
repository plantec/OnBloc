Class {
	#name : #OBlDefaultDividerTheme,
	#superclass : #OBlTheme,
	#instVars : [
		'disabledBackgroundColor',
		'disabledBorderColor',
		'pressedBorderColor',
		'defaultBorderColor',
		'hoveredBorderColor',
		'defaultBackgroundColor',
		'hoveredBackgroundColor',
		'pressedBackgroundColor'
	],
	#category : #'OnBloc-Theme'
}

{ #category : #accessing }
OBlDefaultDividerTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
OBlDefaultDividerTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultDividerTheme >> defaultBorderColor [
	^ defaultBorderColor
]

{ #category : #accessing }
OBlDefaultDividerTheme >> defaultBorderColor: anObject [
	defaultBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultDividerTheme >> disabledBackgroundColor [
	^ disabledBackgroundColor
]

{ #category : #accessing }
OBlDefaultDividerTheme >> disabledBackgroundColor: anObject [
	disabledBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultDividerTheme >> disabledBorderColor [
	^ disabledBorderColor
]

{ #category : #accessing }
OBlDefaultDividerTheme >> disabledBorderColor: anObject [
	disabledBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultDividerTheme >> hoveredBackgroundColor [
	^ hoveredBackgroundColor
]

{ #category : #accessing }
OBlDefaultDividerTheme >> hoveredBackgroundColor: anObject [
	hoveredBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultDividerTheme >> hoveredBorderColor [
	^ hoveredBorderColor
]

{ #category : #accessing }
OBlDefaultDividerTheme >> hoveredBorderColor: anObject [
	hoveredBorderColor := anObject
]

{ #category : #initialization }
OBlDefaultDividerTheme >> initialize [
	super initialize.
	defaultBorderColor := OBlDefaultColors defaultDividerBorderColor.
	defaultBackgroundColor := OBlDefaultColors defaultDividerBackgroundColor.
	disabledBackgroundColor := OBlDefaultColors disabledDividerBackgroundColor.
	disabledBorderColor := OBlDefaultColors disabledDividerBorderColor.
	pressedBorderColor := OBlDefaultColors pressedDividerBorderColor.
	pressedBackgroundColor := OBlDefaultColors pressedDividerBackgroundColor.
	hoveredBorderColor := OBlDefaultColors hoveredDividerBorderColor.
	hoveredBackgroundColor := OBlDefaultColors hoveredDividerBackgroundColor.

]

{ #category : #accessing }
OBlDefaultDividerTheme >> pressedBackgroundColor [
	^ pressedBackgroundColor
]

{ #category : #accessing }
OBlDefaultDividerTheme >> pressedBackgroundColor: aColor [
	pressedBackgroundColor := aColor
]

{ #category : #accessing }
OBlDefaultDividerTheme >> pressedBorderColor [
	^ pressedBorderColor
]

{ #category : #accessing }
OBlDefaultDividerTheme >> pressedBorderColor: anObject [
	pressedBorderColor := anObject
]
