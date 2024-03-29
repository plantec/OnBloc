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
OBlVerticalScrollbarElement >> initialize [

	super initialize.

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical matchParent ]
]

{ #category : #initialization }
OBlVerticalScrollbarElement >> newDefaultThumb [

	^ BlElement new
		  background: self defaultThumbBackground;
		  constraintsDo: [ :c |
			  c minHeight: 20.0.
			  c vertical matchParent ];
		  width: 8;
		  yourself
]

{ #category : #initialization }
OBlVerticalScrollbarElement >> newDefaultTrack [

	^ BlElement new
		  background: self defaultTrackBackground;
		  constraintsDo: [ :c |
			  c horizontal exact: 1.
			  c vertical matchParent.
			  c frame horizontal alignCenter ];
		  yourself
]

{ #category : #'private - scrolling' }
OBlVerticalScrollbarElement >> onDraggedThumbBy: aPoint [

	| scrollableDelta |
	scrollableDelta := self
		scrollableDeltaFromThumbDelta: aPoint y - dragPosition y
		range: scrollable computeVerticalScrollRange
		length: self height.

	scrollableDelta isZero ifTrue: [ ^ self ].

	scrollable scrollBy: 0 @ scrollableDelta.
	
	dragPosition := aPoint
]

{ #category : #'private - scrolling' }
OBlVerticalScrollbarElement >> updateThumbPosition [

	| contentLength scrollOffset scrollExtent thumbWeight thumbTop |
	contentLength := scrollable computeVerticalScrollRange.
	contentLength isZero ifTrue: [ ^ self ].
	scrollOffset := scrollable computeVerticalScrollOffset.
	scrollExtent := scrollable computeVerticalScrollExtent.
	
	contentLength <= scrollExtent 
		ifTrue: [ self visibility: BlVisibility hidden ]
		ifFalse: [ self visibility: BlVisibility visible ].
	
	thumbWeight := (scrollExtent / contentLength) asFloat.
	thumbTop := (scrollOffset / contentLength) asFloat.
	
	thumb constraintsDo: [ :c | 
		c vertical matchParent.
		c frame vertical
			alignTopAt: thumbTop;
			weight: thumbWeight ]
]
