Class {
	#name : #OblDefaultStatusTheme,
	#superclass : #OblTheme,
	#instVars : [
		'successBackgroundColor',
		'successBorderColor',
		'neutralBackgroundColor',
		'errorBorderColor',
		'errorBackgroundColor',
		'failureBorderColor',
		'paleErrorBackgroundColor',
		'failureBackgroundColor'
	],
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OblDefaultStatusTheme >> errorBackgroundColor [
	^ errorBackgroundColor
]

{ #category : #accessing }
OblDefaultStatusTheme >> errorBackgroundColor: anObject [
	errorBackgroundColor := anObject
]

{ #category : #accessing }
OblDefaultStatusTheme >> errorBorderColor [
	^ errorBorderColor
]

{ #category : #accessing }
OblDefaultStatusTheme >> errorBorderColor: anObject [
	errorBorderColor := anObject
]

{ #category : #accessing }
OblDefaultStatusTheme >> failureBackgroundColor [
	^ failureBackgroundColor
]

{ #category : #accessing }
OblDefaultStatusTheme >> failureBackgroundColor: anObject [
	failureBackgroundColor := anObject
]

{ #category : #accessing }
OblDefaultStatusTheme >> failureBorderColor [
	^ failureBorderColor
]

{ #category : #accessing }
OblDefaultStatusTheme >> failureBorderColor: anObject [
	failureBorderColor := anObject
]

{ #category : #initialization }
OblDefaultStatusTheme >> initialize [
	super initialize.
	successBackgroundColor := OblDefaultColors successBackgroundColor.
	successBorderColor := OblDefaultColors successBorderColor.
	neutralBackgroundColor := OblDefaultColors neutralBackgroundColor.
	errorBorderColor := OblDefaultColors errorBorderColor.
	errorBackgroundColor := OblDefaultColors errorBackgroundColor.
	failureBorderColor := OblDefaultColors failureBorderColor.
	paleErrorBackgroundColor := OblDefaultColors
		paleErrorBackgroundColor.
	failureBackgroundColor := OblDefaultColors failureBackgroundColor
]

{ #category : #accessing }
OblDefaultStatusTheme >> neutralBackgroundColor [
	^ neutralBackgroundColor
]

{ #category : #accessing }
OblDefaultStatusTheme >> neutralBackgroundColor: anObject [
	neutralBackgroundColor := anObject
]

{ #category : #accessing }
OblDefaultStatusTheme >> paleErrorBackgroundColor [
	^ paleErrorBackgroundColor
]

{ #category : #accessing }
OblDefaultStatusTheme >> paleErrorBackgroundColor: anObject [
	paleErrorBackgroundColor := anObject
]

{ #category : #accessing }
OblDefaultStatusTheme >> successBackgroundColor [
	^ successBackgroundColor
]

{ #category : #accessing }
OblDefaultStatusTheme >> successBackgroundColor: anObject [
	successBackgroundColor := anObject
]

{ #category : #accessing }
OblDefaultStatusTheme >> successBorderColor [
	^ successBorderColor
]

{ #category : #accessing }
OblDefaultStatusTheme >> successBorderColor: anObject [
	successBorderColor := anObject
]
