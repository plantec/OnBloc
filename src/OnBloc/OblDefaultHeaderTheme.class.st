Class {
	#name : #OBlDefaultHeaderTheme,
	#superclass : #OBlTheme,
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
OBlDefaultHeaderTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
OBlDefaultHeaderTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultHeaderTheme >> defaultTextColor [
	^ defaultTextColor
]

{ #category : #accessing }
OBlDefaultHeaderTheme >> defaultTextColor: anObject [
	defaultTextColor := anObject
]

{ #category : #accessing }
OBlDefaultHeaderTheme >> disabledTextColor [
	^ disabledTextColor
]

{ #category : #accessing }
OBlDefaultHeaderTheme >> disabledTextColor: anObject [
	disabledTextColor := anObject
]

{ #category : #initialization }
OBlDefaultHeaderTheme >> initialize [
	super initialize.
	textMarkupColor := OBlDefaultColors textMarkupColor.
	defaultBackgroundColor := OBlDefaultColors
		defaultHeaderBackgroundColor.
	disabledTextColor := OBlDefaultColors disabledHeaderTextColor.
	defaultTextColor := OBlDefaultColors defaultHeaderTextColor.
	secondaryBackgroundColor := OBlDefaultColors
		secondaryHeaderBackgroundColor
]

{ #category : #accessing }
OBlDefaultHeaderTheme >> secondaryBackgroundColor [
	^ secondaryBackgroundColor
]

{ #category : #accessing }
OBlDefaultHeaderTheme >> secondaryBackgroundColor: anObject [
	secondaryBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultHeaderTheme >> textMarkupColor [
	^ textMarkupColor
]

{ #category : #accessing }
OBlDefaultHeaderTheme >> textMarkupColor: anObject [
	textMarkupColor := anObject
]
