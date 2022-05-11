Class {
	#name : #OblDefaultDefaultTheme,
	#superclass : #OblTheme,
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
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OblDefaultDefaultTheme >> backdropColor [
	^ backdropColor
]

{ #category : #accessing }
OblDefaultDefaultTheme >> backdropColor: anObject [
	backdropColor := anObject
]

{ #category : #accessing }
OblDefaultDefaultTheme >> contentBackgroundColor [
	^ contentBackgroundColor
]

{ #category : #accessing }
OblDefaultDefaultTheme >> contentBackgroundColor: aColor [
	contentBackgroundColor := aColor
]

{ #category : #accessing }
OblDefaultDefaultTheme >> darkBorderColor [
	^ darkBorderColor
]

{ #category : #accessing }
OblDefaultDefaultTheme >> darkBorderColor: anObject [
	darkBorderColor := anObject
]

{ #category : #accessing }
OblDefaultDefaultTheme >> defaultShadowColor [
	^ defaultShadowColor
]

{ #category : #accessing }
OblDefaultDefaultTheme >> defaultShadowColor: anObject [
	defaultShadowColor := anObject
]

{ #category : #accessing }
OblDefaultDefaultTheme >> distinctTenLightColors [
	^ distinctTenLightColors
]

{ #category : #accessing }
OblDefaultDefaultTheme >> distinctTenLightColors: anObject [
	distinctTenLightColors := anObject
]

{ #category : #accessing }
OblDefaultDefaultTheme >> distinctTenStrongColors [
	^ distinctTenStrongColors
]

{ #category : #accessing }
OblDefaultDefaultTheme >> distinctTenStrongColors: anObject [
	distinctTenStrongColors := anObject
]

{ #category : #accessing }
OblDefaultDefaultTheme >> expandCollapseTriangleBackgroundColor [
	^ expandCollapseTriangleBackgroundColor
]

{ #category : #accessing }
OblDefaultDefaultTheme >> expandCollapseTriangleBackgroundColor: anObject [
	expandCollapseTriangleBackgroundColor := anObject
]

{ #category : #initialization }
OblDefaultDefaultTheme >> initialize [
	super initialize.
	contentBackgroundColor := Color white.
	defaultShadowColor := OblDefaultColors defaultShadowColor.
	backdropColor := OblDefaultColors backdropColor.
	primaryBorderColor := OblDefaultColors primaryBorderColor.
	darkBorderColor := OblDefaultColors darkBorderColor.
	distinctTenStrongColors := OblDefaultColors distinctTenStrongColors.
	newsBackgroundColor := OblDefaultColors newsBackgroundColor.
	lightBorderColor := OblDefaultColors lightBorderColor.
	expandCollapseTriangleBackgroundColor := OblDefaultColors
		expandCollapseTriangleBackgroundColor.
	shadowColor := OblDefaultColors shadowColor.
	distinctTenLightColors := OblDefaultColors distinctTenLightColors
]

{ #category : #accessing }
OblDefaultDefaultTheme >> lightBorderColor [
	^ lightBorderColor
]

{ #category : #accessing }
OblDefaultDefaultTheme >> lightBorderColor: anObject [
	lightBorderColor := anObject
]

{ #category : #accessing }
OblDefaultDefaultTheme >> newsBackgroundColor [
	^ newsBackgroundColor
]

{ #category : #accessing }
OblDefaultDefaultTheme >> newsBackgroundColor: anObject [
	newsBackgroundColor := anObject
]

{ #category : #accessing }
OblDefaultDefaultTheme >> primaryBorderColor [
	^ primaryBorderColor
]

{ #category : #accessing }
OblDefaultDefaultTheme >> primaryBorderColor: anObject [
	primaryBorderColor := anObject
]

{ #category : #accessing }
OblDefaultDefaultTheme >> shadowColor [
	^ shadowColor
]

{ #category : #accessing }
OblDefaultDefaultTheme >> shadowColor: anObject [
	shadowColor := anObject
]
