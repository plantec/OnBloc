Class {
	#name : #BlColumnLayout,
	#superclass : #BlBoxLayout,
	#category : #'OnBloc-Experimental-LayoutStrategy-Box-Support'
}

{ #category : #layouting }
BlColumnLayout >> computeExtent [
	self extent: 0 @ 0.
	self
		cellsDo: [ :c | 
			c previous
				ifNil: [ self extent: c extent ]
				ifNotNil: [ self extent: (self width max: c width) @ (self height + c height) ] ]
]

{ #category : #accessing }
BlColumnLayout >> firstAxisSize [
	^ self height
]

{ #category : #accessing }
BlColumnLayout >> firstAxisSize: aNumber [
	self height: aNumber
]

{ #category : #layouting }
BlColumnLayout >> initializeCells [
	super initializeCells.
	self cellsDo: [ :c | c height: c target height + self strategy padding ].
	self lastCell ifNotNil: [ :lc | lc height: lc height - strategy padding ]
]

{ #category : #accessing }
BlColumnLayout >> newCellFor: aTarget [
	^ aTarget asColumnLayoutCell layout: self; strategy: self strategy; yourself 
		
]

{ #category : #accessing }
BlColumnLayout >> secondAxisSize [
	^ self width
]

{ #category : #accessing }
BlColumnLayout >> secondAxisSize: aNumber [
	self width: aNumber
]
