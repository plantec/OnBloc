Class {
	#name : #OblDefaultItemTheme,
	#superclass : #OblTheme,
	#instVars : [
		'selectedColor',
		'deselectedColor',
		'hoveredColor',
		'defaultColor',
		'focusedBorderColor',
		'pressedColor'
	],
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OblDefaultItemTheme >> defaultColor [
	^ defaultColor
]

{ #category : #accessing }
OblDefaultItemTheme >> defaultColor: anObject [
	defaultColor := anObject
]

{ #category : #accessing }
OblDefaultItemTheme >> deselectedColor [
	^ deselectedColor
]

{ #category : #accessing }
OblDefaultItemTheme >> deselectedColor: anObject [
	deselectedColor := anObject
]

{ #category : #accessing }
OblDefaultItemTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
OblDefaultItemTheme >> focusedBorderColor: anObject [
	focusedBorderColor := anObject
]

{ #category : #accessing }
OblDefaultItemTheme >> hoveredColor [
	^ hoveredColor
]

{ #category : #accessing }
OblDefaultItemTheme >> hoveredColor: anObject [
	hoveredColor := anObject
]

{ #category : #initialization }
OblDefaultItemTheme >> initialize [
	super initialize.
	selectedColor := OblDefaultColors selectedListItemColor.
	deselectedColor := OblDefaultColors deselectedListItemColor.
	hoveredColor := OblDefaultColors hoveredListItemColor.
	defaultColor := OblDefaultColors defaultListItemColor.
	focusedBorderColor := OblDefaultColors focusedListItemBorder.
	pressedColor := OblDefaultColors pressedListItemColor
]

{ #category : #accessing }
OblDefaultItemTheme >> pressedColor [
	^ pressedColor
]

{ #category : #accessing }
OblDefaultItemTheme >> pressedColor: anObject [
	pressedColor := anObject
]

{ #category : #accessing }
OblDefaultItemTheme >> selectedColor [
	^ selectedColor
]

{ #category : #accessing }
OblDefaultItemTheme >> selectedColor: anObject [
	selectedColor := anObject
]
