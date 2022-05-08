Class {
	#name : #OblThemeElementProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'theme'
	],
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OblThemeElementProperty >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ theme = anObject theme
]

{ #category : #accessing }
OblThemeElementProperty >> applyOnElement: anElement [
	anElement userData at: #OblTheme put: theme.	
]

{ #category : #accessing }
OblThemeElementProperty >> canPropagateToChildren [
	^ true
]

{ #category : #accessing }
OblThemeElementProperty >> hash [
	^ theme hash
]

{ #category : #accessing }
OblThemeElementProperty >> theme [
	^ theme
]

{ #category : #accessing }
OblThemeElementProperty >> theme: aTheme [
	theme := aTheme
]
