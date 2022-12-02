Class {
	#name : #OBlDefaultDefaultTheme,
	#superclass : #OBlTheme,
	#instVars : [
		'defaultShadowColor',
		'backdropColor',
		'primaryBorderColor',
		'darkBorderColor',
		'distinctTenStrongColors',
		'newsBackgroundColor',
		'lightBorderColor',
		'expandCollapseTriangleBackgroundColor',
		'shadowColor',
		'distinctTenLightColors',
		'contentBackgroundColor'
	],
	#category : #'OnBloc-Theme'
}

{ #category : #accessing }
OBlDefaultDefaultTheme >> backdropColor [
	^ backdropColor
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> backdropColor: anObject [
	backdropColor := anObject
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> contentBackgroundColor [
	^ contentBackgroundColor
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> contentBackgroundColor: aColor [
	contentBackgroundColor := aColor
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> darkBorderColor [
	^ darkBorderColor
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> darkBorderColor: anObject [
	darkBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> defaultShadowColor [
	^ defaultShadowColor
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> defaultShadowColor: anObject [
	defaultShadowColor := anObject
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> distinctTenLightColors [
	^ distinctTenLightColors
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> distinctTenLightColors: anObject [
	distinctTenLightColors := anObject
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> distinctTenStrongColors [
	^ distinctTenStrongColors
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> distinctTenStrongColors: anObject [
	distinctTenStrongColors := anObject
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> expandCollapseTriangleBackgroundColor [
	^ expandCollapseTriangleBackgroundColor
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> expandCollapseTriangleBackgroundColor: anObject [
	expandCollapseTriangleBackgroundColor := anObject
]

{ #category : #initialization }
OBlDefaultDefaultTheme >> initialize [
	super initialize.
	contentBackgroundColor := Color white.
	defaultShadowColor := OBlDefaultColors defaultShadowColor.
	backdropColor := OBlDefaultColors backdropColor.
	primaryBorderColor := OBlDefaultColors primaryBorderColor.
	darkBorderColor := OBlDefaultColors darkBorderColor.
	distinctTenStrongColors := OBlDefaultColors distinctTenStrongColors.
	newsBackgroundColor := OBlDefaultColors newsBackgroundColor.
	lightBorderColor := OBlDefaultColors lightBorderColor.
	expandCollapseTriangleBackgroundColor := OBlDefaultColors
		expandCollapseTriangleBackgroundColor.
	shadowColor := OBlDefaultColors shadowColor.
	distinctTenLightColors := OBlDefaultColors distinctTenLightColors
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> lightBorderColor [
	^ lightBorderColor
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> lightBorderColor: anObject [
	lightBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> newsBackgroundColor [
	^ newsBackgroundColor
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> newsBackgroundColor: anObject [
	newsBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> primaryBorderColor [
	^ primaryBorderColor
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> primaryBorderColor: anObject [
	primaryBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> shadowColor [
	^ shadowColor
]

{ #category : #accessing }
OBlDefaultDefaultTheme >> shadowColor: anObject [
	shadowColor := anObject
]
