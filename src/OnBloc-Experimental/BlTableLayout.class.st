Class {
	#name : #BlTableLayout,
	#superclass : #BlLayoutElement,
	#instVars : [
		'firstCell',
		'lastCell'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy-Box-Support'
}

{ #category : #layouting }
BlTableLayout >> adaptContentsToExtent [
	self initializeCells.
	self computeCellExtents.
	self computeCellPositions.
	self placeAllTargets.
	self resizeAllTargets
]

{ #category : #accessing }
BlTableLayout >> addCell: aLayoutCell [
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
BlTableLayout >> asOrderedCollection [ 
	| result |
	result := OrderedCollection new.
	self cellsDo: [ :c | result add: c ].
	^ result
]

{ #category : #enumerating }
BlTableLayout >> cellsDo: aBlock [
	firstCell ifNotNil: [ firstCell do: aBlock ]
]

{ #category : #enumerating }
BlTableLayout >> cellsReverseDo: aBlock [
	lastCell ifNotNil: [ lastCell reverseDo: aBlock ]
]

{ #category : #layouting }
BlTableLayout >> computeCellExtents [
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
BlTableLayout >> computeCellPositions [
	self cellsDo: [ :c | c computePosition ]
]

{ #category : #accessing }
BlTableLayout >> firstCell [
	^ firstCell
]

{ #category : #accessing }
BlTableLayout >> firstCell: aLayoutCell [
	firstCell := aLayoutCell
]

{ #category : #layouting }
BlTableLayout >> initializeCells [
	| b |
	b := [ :c | self addCell: (self newCellFor: c) ].
	(strategy isRightToLeft or: [ strategy isBottomToTop ])
		ifTrue: [ self target layoutComponents do: b ]
		ifFalse: [ self target layoutComponents reverseDo: b ]
]

{ #category : #accessing }
BlTableLayout >> lastCell [
	^ lastCell
]

{ #category : #accessing }
BlTableLayout >> lastCell: aLayoutCell [
	^ lastCell := aLayoutCell
]

{ #category : #layouting }
BlTableLayout >> placeAllTargets [
	self cellsDo: [:c | c placeTarget ]

]

{ #category : #layouting }
BlTableLayout >> resizeAllTargets [
	self cellsDo: [:c | c resizeTarget ]
]

{ #category : #layouting }
BlTableLayout >> resizeTarget [
	self target innerExtent: self extent asIntegerPoint
]
