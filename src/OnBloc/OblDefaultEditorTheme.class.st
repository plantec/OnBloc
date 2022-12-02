Class {
	#name : #OBlDefaultEditorTheme,
	#superclass : #OBlTheme,
	#instVars : [
		'borderColor',
		'focusedBorderColor'
	],
	#category : #'OnBloc-Theme'
}

{ #category : #accessing }
OBlDefaultEditorTheme >> borderColor [
	^ borderColor
]

{ #category : #accessing }
OBlDefaultEditorTheme >> borderColor: anObject [
	borderColor := anObject
]

{ #category : #accessing }
OBlDefaultEditorTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
OBlDefaultEditorTheme >> focusedBorderColor: anObject [
	focusedBorderColor := anObject
]

{ #category : #initialization }
OBlDefaultEditorTheme >> initialize [
	super initialize.
	borderColor := OBlDefaultColors editorBorderColor.
	focusedBorderColor := OBlDefaultColors focusedEditorBorderColor
]
