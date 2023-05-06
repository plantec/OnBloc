Class {
	#name : #OBlInfiniteScrollChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'scrollState'
	],
	#category : #'OnBloc-Infinite-Events'
}

{ #category : #'instance creation' }
OBlInfiniteScrollChangedEvent class >> scrollState: aScrollState [
	^ self new
		scrollState: aScrollState;
		yourself
]

{ #category : #accessing }
OBlInfiniteScrollChangedEvent >> scrollState [
	^ scrollState
]

{ #category : #accessing }
OBlInfiniteScrollChangedEvent >> scrollState: anObject [
	scrollState := anObject
]
