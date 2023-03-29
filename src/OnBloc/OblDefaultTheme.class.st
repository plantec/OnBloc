Class {
	#name : #OBlDefaultTheme,
	#superclass : #OBlTheme,
	#instVars : [
		'link',
		'status',
		'editor',
		'button',
		'item',
		'header',
		'divider',
		'notebook'
	],
	#category : #'OnBloc-Theme'
}

{ #category : #accessing }
OBlDefaultTheme >> button [
	^ button
]

{ #category : #accessing }
OBlDefaultTheme >> button: anObject [
	button := anObject
]

{ #category : #accessing }
OBlDefaultTheme >> divider [

	^ divider
]

{ #category : #accessing }
OBlDefaultTheme >> divider: aDividerTheme [

	divider := aDividerTheme
]

{ #category : #accessing }
OBlDefaultTheme >> editor [
	^ editor
]

{ #category : #accessing }
OBlDefaultTheme >> editor: anObject [
	editor := anObject
]

{ #category : #accessing }
OBlDefaultTheme >> header [
	^ header
]

{ #category : #accessing }
OBlDefaultTheme >> header: anObject [
	header := anObject
]

{ #category : #initialization }
OBlDefaultTheme >> initialize [
	super initialize.
	link := OBlDefaultLinkTheme new.
	status := OBlDefaultStatusTheme new.
	editor := OBlDefaultEditorTheme new.
	button := OBlDefaultButtonTheme new.
	item := OBlDefaultItemTheme new.
	header := OBlDefaultHeaderTheme new.
	divider := OBlDefaultDividerTheme new.
	notebook := OBlDefaultNotebookTheme new.
]

{ #category : #accessing }
OBlDefaultTheme >> item [
	^ item
]

{ #category : #accessing }
OBlDefaultTheme >> item: anObject [
	item := anObject
]

{ #category : #accessing }
OBlDefaultTheme >> link [
	^ link
]

{ #category : #accessing }
OBlDefaultTheme >> link: anObject [
	link := anObject
]

{ #category : #accessing }
OBlDefaultTheme >> notebook [

	^ notebook
]

{ #category : #accessing }
OBlDefaultTheme >> notebook: anObject [

	notebook := anObject
]

{ #category : #accessing }
OBlDefaultTheme >> status [
	^ status
]

{ #category : #accessing }
OBlDefaultTheme >> status: anObject [
	status := anObject
]
