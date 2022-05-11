Class {
	#name : #OblDefaultTheme,
	#superclass : #OblTheme,
	#instVars : [
		'link',
		'status',
		'default',
		'editor',
		'button',
		'item',
		'header'
	],
	#category : #'OnBloc-theme'
}

{ #category : #accessing }
OblDefaultTheme >> button [
	^ button
]

{ #category : #accessing }
OblDefaultTheme >> button: anObject [
	button := anObject
]

{ #category : #accessing }
OblDefaultTheme >> default [
	^ default
]

{ #category : #accessing }
OblDefaultTheme >> default: anObject [
	default := anObject
]

{ #category : #accessing }
OblDefaultTheme >> editor [
	^ editor
]

{ #category : #accessing }
OblDefaultTheme >> editor: anObject [
	editor := anObject
]

{ #category : #accessing }
OblDefaultTheme >> header [
	^ header
]

{ #category : #accessing }
OblDefaultTheme >> header: anObject [
	header := anObject
]

{ #category : #initialization }
OblDefaultTheme >> initialize [
	super initialize.
	link := OblDefaultLinkTheme new.
	status := OblDefaultStatusTheme new.
	default := OblDefaultDefaultTheme new.
	editor := OblDefaultEditorTheme new.
	button := OblDefaultButtonTheme new.
	item := OblDefaultItemTheme new.
	header := OblDefaultHeaderTheme new
]

{ #category : #accessing }
OblDefaultTheme >> item [
	^ item
]

{ #category : #accessing }
OblDefaultTheme >> item: anObject [
	item := anObject
]

{ #category : #accessing }
OblDefaultTheme >> link [
	^ link
]

{ #category : #accessing }
OblDefaultTheme >> link: anObject [
	link := anObject
]

{ #category : #accessing }
OblDefaultTheme >> status [
	^ status
]

{ #category : #accessing }
OblDefaultTheme >> status: anObject [
	status := anObject
]
