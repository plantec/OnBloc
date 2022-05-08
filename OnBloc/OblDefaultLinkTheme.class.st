Class {
	#name : #OblDefaultLinkTheme,
	#superclass : #OblTheme,
	#instVars : [
		'color',
		'errorColor'
	],
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OblDefaultLinkTheme >> color [
	^ color
]

{ #category : #accessing }
OblDefaultLinkTheme >> color: anObject [
	color := anObject
]

{ #category : #accessing }
OblDefaultLinkTheme >> errorColor [
	^ errorColor
]

{ #category : #accessing }
OblDefaultLinkTheme >> errorColor: anObject [
	errorColor := anObject
]

{ #category : #initialization }
OblDefaultLinkTheme >> initialize [
	super initialize.
	color := OblDefaultColors linkColor.
	errorColor := OblDefaultColors linkWithErrorColor
]
