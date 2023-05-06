Class {
	#name : #OBlInfiniteLinearLayoutItemDirection,
	#superclass : #Object,
	#classInstVars : [
		'head',
		'tail'
	],
	#category : #'OnBloc-Infinite-Layouts-Linear-Utilities'
}

{ #category : #cleanup }
OBlInfiniteLinearLayoutItemDirection class >> cleanUp [
	super cleanUp.
	
	tail := nil.
	head := nil
]

{ #category : #accessing }
OBlInfiniteLinearLayoutItemDirection class >> head [
	^ head ifNil: [ head := OBlInfiniteLinearLayoutItemDirectionHead new ]
]

{ #category : #accessing }
OBlInfiniteLinearLayoutItemDirection class >> tail [
	^ tail ifNil: [ tail := OBlInfiniteLinearLayoutItemDirectionTail new ]
]

{ #category : #converting }
OBlInfiniteLinearLayoutItemDirection >> multiplier [
	<return: #Number>
	^ self subclassResponsibility
]
