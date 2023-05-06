Class {
	#name : #OBlInfiniteLinearLayoutChunkResult,
	#superclass : #Object,
	#instVars : [
		'finished',
		'ignoreConsumed',
		'focusable',
		'consumedSpace'
	],
	#category : #'OnBloc-Infinite-Layouts-Linear-Utilities'
}

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkResult >> consumedSpace [
	<return: #Number>

	^ consumedSpace
]

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkResult >> consumedSpace: aNumber [
	consumedSpace := aNumber
]

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkResult >> finished [
	<return: #Boolean>

	^ finished
]

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkResult >> finished: aBoolean [
	finished := aBoolean
]

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkResult >> focusable [
	^ focusable
]

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkResult >> focusable: aBoolean [
	focusable := aBoolean
]

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkResult >> ignoreConsumed [
	^ ignoreConsumed
]

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkResult >> ignoreConsumed: aBoolean [
	ignoreConsumed := aBoolean
]

{ #category : #initialization }
OBlInfiniteLinearLayoutChunkResult >> initialize [
	super initialize.
	
	self reset
]

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkResult >> reset [
	consumedSpace := 0.
	finished := false.
	ignoreConsumed := false.
	focusable := false
]
