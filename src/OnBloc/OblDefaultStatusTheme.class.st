Class {
	#name : #OBlDefaultStatusTheme,
	#superclass : #OBlTheme,
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
OBlDefaultStatusTheme >> errorBackgroundColor [
	^ errorBackgroundColor
]

{ #category : #accessing }
OBlDefaultStatusTheme >> errorBackgroundColor: anObject [
	errorBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultStatusTheme >> errorBorderColor [
	^ errorBorderColor
]

{ #category : #accessing }
OBlDefaultStatusTheme >> errorBorderColor: anObject [
	errorBorderColor := anObject
]

{ #category : #accessing }
OBlDefaultStatusTheme >> failureBackgroundColor [
	^ failureBackgroundColor
]

{ #category : #accessing }
OBlDefaultStatusTheme >> failureBackgroundColor: anObject [
	failureBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultStatusTheme >> failureBorderColor [
	^ failureBorderColor
]

{ #category : #accessing }
OBlDefaultStatusTheme >> failureBorderColor: anObject [
	failureBorderColor := anObject
]

{ #category : #initialization }
OBlDefaultStatusTheme >> initialize [
	super initialize.
	successBackgroundColor := OBlDefaultColors successBackgroundColor.
	successBorderColor := OBlDefaultColors successBorderColor.
	neutralBackgroundColor := OBlDefaultColors neutralBackgroundColor.
	errorBorderColor := OBlDefaultColors errorBorderColor.
	errorBackgroundColor := OBlDefaultColors errorBackgroundColor.
	failureBorderColor := OBlDefaultColors failureBorderColor.
	paleErrorBackgroundColor := OBlDefaultColors
		paleErrorBackgroundColor.
	failureBackgroundColor := OBlDefaultColors failureBackgroundColor
]

{ #category : #accessing }
OBlDefaultStatusTheme >> neutralBackgroundColor [
	^ neutralBackgroundColor
]

{ #category : #accessing }
OBlDefaultStatusTheme >> neutralBackgroundColor: anObject [
	neutralBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultStatusTheme >> paleErrorBackgroundColor [
	^ paleErrorBackgroundColor
]

{ #category : #accessing }
OBlDefaultStatusTheme >> paleErrorBackgroundColor: anObject [
	paleErrorBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultStatusTheme >> successBackgroundColor [
	^ successBackgroundColor
]

{ #category : #accessing }
OBlDefaultStatusTheme >> successBackgroundColor: anObject [
	successBackgroundColor := anObject
]

{ #category : #accessing }
OBlDefaultStatusTheme >> successBorderColor [
	^ successBorderColor
]

{ #category : #accessing }
OBlDefaultStatusTheme >> successBorderColor: anObject [
	successBorderColor := anObject
]
