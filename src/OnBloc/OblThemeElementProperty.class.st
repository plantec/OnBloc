Class {
	#name : #OBlThemeElementProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'theme'
	],
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OBlThemeElementProperty >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ theme = anObject theme
]

{ #category : #accessing }
OBlThemeElementProperty >> applyOnElement: anElement [
	anElement userData at: #OBlTheme put: theme.	
]

{ #category : #accessing }
OBlThemeElementProperty >> canPropagateToChildren [
	^ true
]

{ #category : #accessing }
OBlThemeElementProperty >> hash [
	^ theme hash
]

{ #category : #accessing }
OBlThemeElementProperty >> theme [
	^ theme
]

{ #category : #accessing }
OBlThemeElementProperty >> theme: aTheme [
	theme := aTheme
]
