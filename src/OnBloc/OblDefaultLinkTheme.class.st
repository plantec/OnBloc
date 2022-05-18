Class {
	#name : #OBlDefaultLinkTheme,
	#superclass : #OBlTheme,
	#instVars : [
		'color',
		'errorColor'
	],
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OBlDefaultLinkTheme >> color [
	^ color
]

{ #category : #accessing }
OBlDefaultLinkTheme >> color: anObject [
	color := anObject
]

{ #category : #accessing }
OBlDefaultLinkTheme >> errorColor [
	^ errorColor
]

{ #category : #accessing }
OBlDefaultLinkTheme >> errorColor: anObject [
	errorColor := anObject
]

{ #category : #initialization }
OBlDefaultLinkTheme >> initialize [
	super initialize.
	color := OBlDefaultColors linkColor.
	errorColor := OBlDefaultColors linkWithErrorColor
]
