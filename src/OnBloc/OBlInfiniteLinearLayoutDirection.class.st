Class {
	#name : #OBlInfiniteLinearLayoutDirection,
	#superclass : #Object,
	#classInstVars : [
		'start',
		'end'
	],
	#category : #'OnBloc-Infinite-Layouts-Linear-Utilities'
}

{ #category : #accessing }
OBlInfiniteLinearLayoutDirection class >> cleanUp [
	super cleanUp.
	
	start := nil.
	end := nil
]

{ #category : #accessing }
OBlInfiniteLinearLayoutDirection class >> end [
	^ end ifNil: [ end := OBlInfiniteLinearLayoutDirectionEnd new ]
]

{ #category : #accessing }
OBlInfiniteLinearLayoutDirection class >> start [
	^ start ifNil: [ start := OBlInfiniteLinearLayoutDirectionStart new ]
]

{ #category : #testing }
OBlInfiniteLinearLayoutDirection >> isEnd [
	^ self subclassResponsibility
]

{ #category : #testing }
OBlInfiniteLinearLayoutDirection >> isStart [
	^ self subclassResponsibility
]

{ #category : #converting }
OBlInfiniteLinearLayoutDirection >> multiplier [
	<return: #Number>
	^ self subclassResponsibility
]
