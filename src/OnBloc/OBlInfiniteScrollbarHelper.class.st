Class {
	#name : #OBlInfiniteScrollbarHelper,
	#superclass : #Object,
	#instVars : [
		'state',
		'layout',
		'orientation',
		'startElement',
		'endElement',
		'smoothScrollbarEnabled',
		'isReversedLayout'
	],
	#category : #'OnBloc-Infinite-Scroller'
}

{ #category : #scrollbar }
OBlInfiniteScrollbarHelper >> computeScrollExtent [

	| anExtent |
	self isEmpty ifTrue: [ ^ 0 ]. 

	smoothScrollbarEnabled ifFalse: [
		(layout childPositionOf: startElement)
		- (layout childPositionOf: endElement) abs + 1 ].

	anExtent :=
		(orientation decoratedEnd: endElement)
		- (orientation decoratedStart: startElement).

	^ orientation totalSpace min: anExtent
]

{ #category : #scrollbar }
OBlInfiniteScrollbarHelper >> computeScrollOffset [

	| startPosition endPosition minPosition maxPosition itemsBefore laidOutArea itemRange avgSizePerRow |
	self isEmpty ifTrue: [ ^ 0 ].
	
	startPosition := layout childPositionOf: startElement.
	endPosition := layout childPositionOf: endElement.

	minPosition := startPosition min: endPosition.
	maxPosition := startPosition max: endPosition.
	
	itemsBefore := isReversedLayout
		ifTrue: [ 0 max: (state itemCount - maxPosition - 1) ]
		ifFalse: [ 0 max: (minPosition - 1) ].
	
	smoothScrollbarEnabled ifFalse: [ ^ itemsBefore ].
	
	laidOutArea :=
		((orientation decoratedEnd: endElement)
		- (orientation decoratedStart: startElement)) abs.
	itemRange := (startPosition - endPosition) abs + 1.
	avgSizePerRow := (laidOutArea / itemRange) asFloat.
	
	^ (itemsBefore * avgSizePerRow) + (orientation startWithPadding - (orientation decoratedStart: startElement))
]

{ #category : #scrollbar }
OBlInfiniteScrollbarHelper >> computeScrollRange [

	| laidOutArea laidOutRange |
	self isEmpty ifTrue: [ ^ 0 ].

	smoothScrollbarEnabled ifFalse: [ ^ state itemCount ].

	laidOutArea :=
		(orientation decoratedEnd: endElement)
		- (orientation decoratedStart: startElement).
	
	laidOutRange :=
		((layout childPositionOf: startElement)
		- (layout childPositionOf: endElement)) abs + 1.

	^ (laidOutArea / laidOutRange * state itemCount) asFloat
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> endElement [

	^ endElement
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> endElement: aBlElement [

	endElement := aBlElement
]

{ #category : #scrollbar }
OBlInfiniteScrollbarHelper >> isEmpty [

	^ layout childrenCount isZero
		or: [ state itemCount isZero
			or: [ startElement isNil
				or: [ endElement isNil ] ] ]
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> isReversedLayout [

	^ isReversedLayout
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> isReversedLayout: aBoolean [

	isReversedLayout := aBoolean
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> layout [

	^ layout
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> layout: aBlInfiniteLayout [

	layout := aBlInfiniteLayout
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> orientation [

	^ orientation
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> orientation: anInfiniteLayoutOrientation [

	orientation := anInfiniteLayoutOrientation
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> smoothScrollbarEnabled [

	^ smoothScrollbarEnabled
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> smoothScrollbarEnabled: aBoolean [

	smoothScrollbarEnabled := aBoolean
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> startElement [

	^ startElement
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> startElement: aBlElement [

	startElement := aBlElement
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> state [

	^ state
]

{ #category : #accessing }
OBlInfiniteScrollbarHelper >> state: aBlInfiniteState [

	state := aBlInfiniteState
]
