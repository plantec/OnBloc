Class {
	#name : #OBlInfiniteScrollFlinger,
	#superclass : #OBlScrollFlinger,
	#pools : [
		'OBlInfiniteConstants'
	],
	#category : #'OnBloc-Infinite-Scroller'
}

{ #category : #'instance creation' }
OBlInfiniteScrollFlinger class >> on: anInfiniteElement [
	^ self new
		initializeWith: anInfiniteElement;
		yourself
]

{ #category : #hooks }
OBlInfiniteScrollFlinger >> onFinished [
	self scrollable prefetchingAllowed
		ifTrue: [ self shouldBeImplemented ]
]

{ #category : #hooks }
OBlInfiniteScrollFlinger >> onInitialized [
	self scrollable eatRequestLayout.
	self scrollable onEnterLayoutOrScroll
]

{ #category : #hooks }
OBlInfiniteScrollFlinger >> onLayoutScrolled [
	self scrollable repositionShadowingElements.
	self scrollable onExitLayoutOrScroll.
	self scrollable resumeRequestLayout: false
]

{ #category : #hooks }
OBlInfiniteScrollFlinger >> onNotFinished [
	self scrollable prefetchingAllowed
		ifTrue: [ self shouldBeImplemented ]
]

{ #category : #hooks }
OBlInfiniteScrollFlinger >> onPrepareToRun [
	self scrollable consumePendingDataSourceCommands
]

{ #category : #hooks }
OBlInfiniteScrollFlinger >> onSmoothScrolled [
]
