Class {
	#name : #OBlScrollBarTest,
	#superclass : #OBlParameterizedTest,
	#instVars : [
		'space',
		'largeElement',
		'scrollableElement',
		'hBar',
		'vBar',
		'scrollPane'
	],
	#category : #'OnBloc-Tests'
}

{ #category : #running }
OBlScrollBarTest >> dragOn: anElement byAll: aSequenceOfDeltas [

	OBlSpace simulateDragOn: anElement byAll: aSequenceOfDeltas.
	self waitTestingSpaces
]

{ #category : #running }
OBlScrollBarTest >> setUp [

	| largeExtent gap |
	super setUp.

	space := self newTestingSpace.
	space title: testSelector asString.
	
	gap := 5.
	largeExtent := 200 @ 400.
	largeElement := OBlElement new
		size: largeExtent;
		background: (BlRadialGradientPaint new
			stops: { 0 -> Color blue. 1 -> Color red };
			center: largeExtent // 2;
			radius: largeExtent min;
			yourself);
		yourself.

	scrollableElement :=
		OBlScrollableElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			addChild: largeElement;
			yourself.

	hBar :=
		OBlHorizontalScrollbarElement new
			constraintsDo: [ :c |
				c ignoreByLayout.
				c ignored vertical alignBottom ];
			attachTo: scrollableElement;
			yourself.

	vBar :=
		OBlVerticalScrollbarElement new
			constraintsDo: [ :c |
				c ignoreByLayout.
				c ignored horizontal alignRight ];
			attachTo: scrollableElement;
			yourself.
	
	scrollPane :=
		BlElement new
			addChild: scrollableElement;
			addChild: vBar;
			addChild: hBar;
			margin: (BlInsets all: gap);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.

	space root
		layout: BlLinearLayout new;
		padding: (BlInsets all: gap);
		background: Color green;
		addChild: scrollPane.
	space extent: 100 asPoint.
	space show.
	self waitTestingSpaces
]

{ #category : #tests }
OBlScrollBarTest >> testHorizontalDragThumbBeyondBounds [

	"Increase offset by a small distance"
	self dragOn: hBar thumb byAll: { 10 asPoint }.
	self
		assert: scrollableElement computeHorizontalScrollOffset
		equals: 25.

	"Increase offset to max offset"
	self dragOn: hBar thumb byAll: { scrollableElement extent * 2 }.
	self
		assert: scrollableElement computeHorizontalScrollOffset
		equals: 120

]

{ #category : #tests }
OBlScrollBarTest >> testHorizontalDragThumbReturn [

	self
		dragOn: hBar thumb
		byAll: {
			scrollableElement extent * 2.
			-10 asPoint }.
	self
		assert: scrollableElement computeHorizontalScrollOffset
		equals: 120
]

{ #category : #tests }
OBlScrollBarTest >> testHorizontalScrollInitialValues [

	self assert: scrollableElement computeHorizontalScrollOffset isZero.
	self
		assert: scrollableElement computeHorizontalScrollRange
		equals: largeElement extent x.
	self
		assert: scrollableElement computeHorizontalScrollExtent
		equals: scrollableElement extent x
]

{ #category : #tests }
OBlScrollBarTest >> testVerticalDragThumbBeyondBounds [

	"Increase offset by a small distance"
	self dragOn: vBar thumb byAll: { 10 asPoint }.
	self
		assert: scrollableElement computeVerticalScrollOffset
		equals: 50.

	"Increase offset to max offset"
	self dragOn: vBar thumb byAll: { scrollableElement extent * 2 }.
	self
		assert: scrollableElement computeVerticalScrollOffset
		equals: 300
]

{ #category : #tests }
OBlScrollBarTest >> testVerticalDragThumbReturn [

	self
		dragOn: vBar thumb
		byAll: {
			scrollableElement extent * 2.
			-10 asPoint }.
	self
		assert: scrollableElement computeVerticalScrollOffset
		equals: 300
]

{ #category : #tests }
OBlScrollBarTest >> testVerticalScrollInitialValues [

	self assert: scrollableElement computeVerticalScrollOffset isZero.
	self
		assert: scrollableElement computeVerticalScrollRange
		equals: largeElement extent y.
	self
		assert: scrollableElement computeVerticalScrollExtent
		equals: scrollableElement extent y
]
