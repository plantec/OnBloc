Class {
	#name : #OblDefaultHeaderTheme,
	#superclass : #OblTheme,
	#instVars : [
		'textMarkupColor',
		'defaultBackgroundColor',
		'disabledTextColor',
		'defaultTextColor',
		'secondaryBackgroundColor'
	],
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OblDefaultHeaderTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
OblDefaultHeaderTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #accessing }
OblDefaultHeaderTheme >> defaultTextColor [
	^ defaultTextColor
]

{ #category : #accessing }
OblDefaultHeaderTheme >> defaultTextColor: anObject [
	defaultTextColor := anObject
]

{ #category : #accessing }
OblDefaultHeaderTheme >> disabledTextColor [
	^ disabledTextColor
]

{ #category : #accessing }
OblDefaultHeaderTheme >> disabledTextColor: anObject [
	disabledTextColor := anObject
]

{ #category : #initialization }
OblDefaultHeaderTheme >> initialize [
	super initialize.
	textMarkupColor := OblDefaultColors textMarkupColor.
	defaultBackgroundColor := OblDefaultColors
		defaultHeaderBackgroundColor.
	disabledTextColor := OblDefaultColors disabledHeaderTextColor.
	defaultTextColor := OblDefaultColors defaultHeaderTextColor.
	secondaryBackgroundColor := OblDefaultColors
		secondaryHeaderBackgroundColor
]

{ #category : #accessing }
OblDefaultHeaderTheme >> secondaryBackgroundColor [
	^ secondaryBackgroundColor
]

{ #category : #accessing }
OblDefaultHeaderTheme >> secondaryBackgroundColor: anObject [
	secondaryBackgroundColor := anObject
]

{ #category : #accessing }
OblDefaultHeaderTheme >> textMarkupColor [
	^ textMarkupColor
]

{ #category : #accessing }
OblDefaultHeaderTheme >> textMarkupColor: anObject [
	textMarkupColor := anObject
]
