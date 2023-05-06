Class {
	#name : #OBlOverScrollMode,
	#superclass : #Object,
	#classInstVars : [
		'always',
		'ifContentScrolls',
		'never'
	],
	#category : #'OnBloc-Scrollable-Helpers'
}

{ #category : #accessing }
OBlOverScrollMode class >> never [
	^ never ifNil: [ never := OBlOverScrollNeverMode new ]
]
