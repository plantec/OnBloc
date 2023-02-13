Class {
	#name : #OBlDefaultItemTheme,
	#superclass : #OBlTheme,
	#instVars : [
		'selectedColor',
		'deselectedColor',
		'hoveredColor',
		'defaultColor',
		'focusedBorderColor',
		'pressedColor',
		'hoveredBorderColor',
		'pressedBorderColor'
	],
	#category : #'OnBloc-Theme'
}

{ #category : #accessing }
OBlDefaultItemTheme >> defaultColor [
	^ defaultColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> defaultColor: anObject [
	defaultColor := anObject
]

{ #category : #accessing }
OBlDefaultItemTheme >> deselectedColor [
	^ deselectedColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> deselectedColor: anObject [
	deselectedColor := anObject
]

{ #category : #accessing }
OBlDefaultItemTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> focusedBorderColor: anObject [
	focusedBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultItemTheme >> hoveredBorderColor [
	^ hoveredBorderColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> hoveredColor [
	^ hoveredColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> hoveredColor: anObject [
	hoveredColor := anObject
]

{ #category : #initialization }
OBlDefaultItemTheme >> initialize [
	super initialize.
	selectedColor := OBlDefaultColors selectedListItemColor.
	deselectedColor := OBlDefaultColors deselectedListItemColor.
	hoveredColor := OBlDefaultColors hoveredListItemColor.
	hoveredBorderColor := OBlDefaultColors hoveredListItemBorderColor.
	defaultColor := OBlDefaultColors defaultListItemColor.
	focusedBorderColor := OBlDefaultColors focusedListItemBorder.
	pressedBorderColor := OBlDefaultColors pressedListItemBorderColor.
	pressedColor := OBlDefaultColors pressedListItemColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> pressedBorderColor [

	^ pressedBorderColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> pressedBorderColor: aColor [

	pressedBorderColor := aColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> pressedColor [
	^ pressedColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> pressedColor: anObject [
	pressedColor := anObject
]

{ #category : #accessing }
OBlDefaultItemTheme >> selectedColor [
	^ selectedColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> selectedColor: anObject [
	selectedColor := anObject
]
