Class {
	#name : #OBlDefaultItemTheme,
	#superclass : #OBlTheme,
	#instVars : [
		'selectedColor',
		'deselectedColor',
		'focusedBorderColor',
		'hoveredBorderColor',
		'pressedBorderColor',
		'hoveredBackgroundColor',
		'defaultBackgroundColor',
		'pressedBackgroundColor'
	],
	#category : #'OnBloc-Theme'
}

{ #category : #accessing }
OBlDefaultItemTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #initialization }
OBlDefaultItemTheme >> defaultBorderColor [

	^ self deselectedColor 
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
OBlDefaultItemTheme >> hoveredBackgroundColor [
	^ hoveredBackgroundColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> hoveredBackgroundColor: anObject [
	hoveredBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultItemTheme >> hoveredBorderColor [
	^ hoveredBorderColor
]

{ #category : #initialization }
OBlDefaultItemTheme >> initialize [
	super initialize.
	selectedColor := OBlDefaultColors selectedListItemColor.
	deselectedColor := OBlDefaultColors deselectedListItemColor.
	hoveredBackgroundColor := OBlDefaultColors hoveredListItemBackgroundColor.
	hoveredBorderColor := OBlDefaultColors hoveredListItemBorderColor.
	defaultBackgroundColor := OBlDefaultColors defaultListItemBackgroundColor.
	focusedBorderColor := OBlDefaultColors focusedListItemBorder.
	pressedBorderColor := OBlDefaultColors pressedListItemBorderColor.
	pressedBackgroundColor := OBlDefaultColors pressedListItemColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> pressedBackgroundColor [
	^ pressedBackgroundColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> pressedBackgroundColor: anObject [
	pressedBackgroundColor := anObject
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
OBlDefaultItemTheme >> selectedColor [
	^ selectedColor
]

{ #category : #accessing }
OBlDefaultItemTheme >> selectedColor: anObject [
	selectedColor := anObject
]
