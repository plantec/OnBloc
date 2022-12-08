Class {
	#name : #BlBoxLayout,
	#superclass : #BlLayoutElement,
	#instVars : [
		'firstCell',
		'lastCell'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy-Box-Support'
}

{ #category : #layouting }
BlBoxLayout >> adaptContentsToExtent [
	self initializeCells.
	self computeCellExtents.
	self computeCellPositions.
	self placeAllTargets.
	self resizeAllTargets
]

{ #category : #layouting }
BlBoxLayout >> adaptExtentToContents [
	self initializeCells.
	self computeExtent.
	self computeCellPositions.
	self placeAllTargets.
	self resizeTarget.


]

{ #category : #accessing }
BlBoxLayout >> addCell: aLayoutCell [
	aLayoutCell next: nil.
	aLayoutCell previous: lastCell.
	lastCell
		ifNil: [ 
			firstCell := lastCell := aLayoutCell.
			^ self ].
	lastCell next: aLayoutCell.
	lastCell := aLayoutCell
]

{ #category : #converting }
BlBoxLayout >> asOrderedCollection [ 
	| result |
	result := OrderedCollection new.
	self cellsDo: [ :c | result add: c ].
	^ result
]

{ #category : #enumerating }
BlBoxLayout >> cellsDo: aBlock [
	firstCell ifNotNil: [ firstCell do: aBlock ]
]

{ #category : #enumerating }
BlBoxLayout >> cellsReverseDo: aBlock [
	lastCell ifNotNil: [ lastCell reverseDo: aBlock ]
]

{ #category : #layouting }
BlBoxLayout >> computeCellExtents [
	" compute actual width by cumulating all cell targets width + the padding "

	| actualHight nb delta |
	firstCell ifNil: [ ^ self ].
	actualHight := 0.
	nb := 0.
	self
		cellsDo: [ :c | 
			actualHight := actualHight + c firstAxisSize.
			c isFirstAxisFlexible
				ifTrue: [ nb := nb + 1 ] ].
	nb > 0
		ifTrue: [ 
			delta := actualHight - self firstAxisSize.
			delta := (delta / nb) truncated.
			self
				cellsDo: [ :c | 
					c isFirstAxisFlexible
						ifTrue: [ c firstAxisSize: c firstAxisSize - delta ] ] ].
	self
		cellsDo: [ :c | 
			c isSecondAxisFlexible
				ifTrue: [ c secondAxisSize: self secondAxisSize ] ]
]

{ #category : #layouting }
BlBoxLayout >> computeCellPositions [
	self cellsDo: [ :c | c computePosition ]
]

{ #category : #accessing }
BlBoxLayout >> firstCell [
	^ firstCell
]

{ #category : #accessing }
BlBoxLayout >> firstCell: aLayoutCell [
	firstCell := aLayoutCell
]

{ #category : #layouting }
BlBoxLayout >> initializeCells [
	| b |
	b := [ :c | self addCell: (self newCellFor: c) ].
	(strategy isRightToLeft or: [ strategy isBottomToTop ])
		ifTrue: [ self target layoutComponents do: b ]
		ifFalse: [ self target layoutComponents reverseDo: b ]
]

{ #category : #accessing }
BlBoxLayout >> lastCell [
	^ lastCell
]

{ #category : #accessing }
BlBoxLayout >> lastCell: aLayoutCell [
	^ lastCell := aLayoutCell
]

{ #category : #layouting }
BlBoxLayout >> placeAllTargets [
	self cellsDo: [:c | c placeTarget ]

]

{ #category : #layouting }
BlBoxLayout >> resizeAllTargets [
	self cellsDo: [:c | c resizeTarget ]
]

{ #category : #layouting }
BlBoxLayout >> resizeTarget [
	self target innerExtent: self extent asIntegerPoint
]
