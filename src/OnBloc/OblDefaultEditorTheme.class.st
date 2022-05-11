Class {
	#name : #OblDefaultEditorTheme,
	#superclass : #OblTheme,
	#instVars : [
		'borderColor',
		'focusedBorderColor'
	],
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OblDefaultEditorTheme >> borderColor [
	^ borderColor
]

{ #category : #accessing }
OblDefaultEditorTheme >> borderColor: anObject [
	borderColor := anObject
]

{ #category : #accessing }
OblDefaultEditorTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
OblDefaultEditorTheme >> focusedBorderColor: anObject [
	focusedBorderColor := anObject
]

{ #category : #initialization }
OblDefaultEditorTheme >> initialize [
	super initialize.
	borderColor := OblDefaultColors editorBorderColor.
	focusedBorderColor := OblDefaultColors focusedEditorBorderColor
]
