Class {
	#name : #BlRowLayout,
	#superclass : #BlBoxLayout,
	#category : #'OnBloc-Experimental-LayoutStrategy-Box-Support'
}

{ #category : #layouting }
BlRowLayout >> computeExtent [
	self extent: 0 @ 0.
	self
		cellsDo: [ :c | 
			c previous
				ifNil: [ self extent: c extent ]
				ifNotNil: [ self extent: (self width + c width) @ (self height max: c height) ] ]
]

{ #category : #accessing }
BlRowLayout >> firstAxisSize [
	^ self width
]

{ #category : #accessing }
BlRowLayout >> firstAxisSize: aNumber [
	self width: aNumber
]

{ #category : #layouting }
BlRowLayout >> initializeCells [
	super initializeCells.
	self cellsDo: [ :c | c width: c target width + self strategy padding ].
	self lastCell ifNotNil: [ :lc | lc width: lc width - strategy padding ]
]

{ #category : #accessing }
BlRowLayout >> newCellFor: aTarget [
	^ aTarget asRowLayoutCell layout: self; strategy: self strategy; yourself 
		
]

{ #category : #accessing }
BlRowLayout >> secondAxisSize [
	^ self height
]

{ #category : #accessing }
BlRowLayout >> secondAxisSize: aNumber [
	self height: aNumber
]
