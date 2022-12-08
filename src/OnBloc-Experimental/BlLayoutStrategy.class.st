Class {
	#name : #BlLayoutStrategy,
	#superclass : #Object,
	#instVars : [
		'layouting',
		'plugged'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy'
}

{ #category : #layout }
BlLayoutStrategy >> doLayout: aView in: newBounds [
	"Compute the layout for the given aView based on the new bounds"

	plugged
		ifFalse: [ ^ self ].
	self
		privateForbidLayoutingWhile: [ 
			aView aboutToDoLayoutIn: newBounds.
			self layout: aView in: newBounds.
			aView layoutDoneIn: newBounds ]
]

{ #category : #initialization }
BlLayoutStrategy >> initialize [ 
	super initialize.
	layouting := false.
	plugged := true
]

{ #category : #layout }
BlLayoutStrategy >> layout: aMorph in: newBounds [
	"Compute the layout for the given morph based on the new bounds"

]

{ #category : #layout }
BlLayoutStrategy >> layoutOf: aView changedFrom: aSubView [
	plugged ifFalse: [ ^self ].
	aView invalidateBoundsCache.
	aView canBeAnywhere
		ifFalse: [ aView ownerDo: [ :o | o layoutChangedFrom: aSubView ] ]
]

{ #category : #private }
BlLayoutStrategy >> privateForbidLayoutingWhile: aBlock [
	layouting
		ifTrue: [ ^ self ].
	layouting := true.
	aBlock
		ensure: [ layouting := false ]
]

{ #category : #layout }
BlLayoutStrategy >> replug [
	plugged := true
]

{ #category : #layout }
BlLayoutStrategy >> unplug [
	plugged := false
]

{ #category : #layout }
BlLayoutStrategy >> unplugDuring: aBlock [
	| wasPlugged |
	wasPlugged := plugged.
	aBlock ensure: [ plugged := wasPlugged ]
	
]
