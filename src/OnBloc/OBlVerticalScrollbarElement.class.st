Class {
	#name : #OBlVerticalScrollbarElement,
	#superclass : #OBlScrollbarElement,
	#category : #'OnBloc-Scrollable-Core'
}

{ #category : #initialization }
OBlVerticalScrollbarElement >> defaultPullHandler [

	^ BlPullHandler new
		  disallowOutOfBounds;
		  beVertical;
		  yourself
]

{ #category : #initialization }
OBlVerticalScrollbarElement >> defaultThumb [

	^ BlElement new
		  width: 8;
		  constraintsDo: [ :c |
			  c minHeight: 20.0.
			  c vertical matchParent ];
		  background: Color gray;
		yourself
]

{ #category : #initialization }
OBlVerticalScrollbarElement >> defaultTrack [

	^ BlElement new
		  background: (Color black alpha: 0.25);
		  constraintsDo: [ :c |
			  c horizontal exact: 1.
			  c vertical matchParent.
			  c frame horizontal alignCenter ];
		  yourself
]

{ #category : #initialization }
OBlVerticalScrollbarElement >> initialize [

	super initialize.

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical matchParent ]
]

{ #category : #'private - scrolling' }
OBlVerticalScrollbarElement >> scrollTo: aPoint [

	| scrollingBy |
	scrollingBy := self
		computeScrollDeltaFrom: dragPosition y
		to: aPoint y
		offset: scrollable computeVerticalScrollOffset
		range: scrollable computeVerticalScrollRange
		length: self height.

	scrollingBy isZero
		ifTrue: [ ^ self ].

	scrollable scrollBy: 0.0 @ scrollingBy.
	
	dragPosition := aPoint
]

{ #category : #'private - scrolling' }
OBlVerticalScrollbarElement >> updateScrollPosition [

	| verticalContentLength verticalScrollOffset verticalScrollExtent realThumbWeight thumbTop |
	verticalContentLength := scrollable computeVerticalScrollRange.
	
	verticalContentLength isZero
		ifTrue: [ ^ self ].
	
	verticalScrollOffset := scrollable computeVerticalScrollOffset.
	verticalScrollExtent := scrollable computeVerticalScrollExtent.
	
	verticalContentLength <= verticalScrollExtent 
		ifTrue: [ self visibility: BlVisibility hidden]
		ifFalse: [ self visibility: BlVisibility visible].
	
	realThumbWeight := (verticalScrollExtent / verticalContentLength) asFloat.
	thumbTop := (verticalScrollOffset / verticalContentLength) asFloat.
	
	thumb constraintsDo: [ :c | 
		c vertical matchParent.
		c frame vertical
			alignTopAt: thumbTop;
			weight: realThumbWeight ]
]
