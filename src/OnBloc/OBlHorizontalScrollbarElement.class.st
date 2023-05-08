Class {
	#name : #OBlHorizontalScrollbarElement,
	#superclass : #OBlScrollbarElement,
	#category : #'OnBloc-Scrollable-Core'
}

{ #category : #initialization }
OBlHorizontalScrollbarElement >> defaultPullHandler [

	^ BlPullHandler new
		  disallowOutOfBounds;
		  beHorizontal;
		  yourself
]

{ #category : #initialization }
OBlHorizontalScrollbarElement >> defaultThumb [

	^ BlElement new
		  height: 8;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c frame horizontal weight: 0.25 ];
		  background: Color gray;
		  yourself
]

{ #category : #initialization }
OBlHorizontalScrollbarElement >> defaultTrack [

	^ BlElement new
		  background: (Color black alpha: 0.25);
		  constraintsDo: [ :c |
			  c vertical exact: 1.
			  c horizontal matchParent.
			  c frame vertical alignCenter ];
		  yourself
]

{ #category : #initialization }
OBlHorizontalScrollbarElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ]
]

{ #category : #'private - scrolling' }
OBlHorizontalScrollbarElement >> scrollTo: aPoint [
	| scrollingBy |
	
	scrollingBy := self
		computeScrollDeltaFrom: dragPosition x
		to: aPoint x
		offset: scrollable computeHorizontalScrollOffset
		range: scrollable computeHorizontalScrollRange
		length: self width.

	scrollingBy isZero
		ifTrue: [ ^ self ].

	scrollable scrollBy: scrollingBy @ 0.
	
	dragPosition := aPoint
]

{ #category : #'private - scrolling' }
OBlHorizontalScrollbarElement >> updateScrollPosition [

	| horizontalContentLength horizontalScrollOffset horizontalScrollExtent realThumbWeight thumbLeft |
	horizontalContentLength := scrollable computeHorizontalScrollRange.
	
	horizontalContentLength isZero
		ifTrue: [ ^ self ].
	
	horizontalScrollOffset := scrollable computeHorizontalScrollOffset.
	horizontalScrollExtent := scrollable computeHorizontalScrollExtent.
	
	horizontalContentLength <= horizontalScrollExtent 
		ifTrue: [ self visibility: BlVisibility hidden]
		ifFalse: [ self visibility: BlVisibility visible].
	
	realThumbWeight := (horizontalScrollExtent / horizontalContentLength) asFloat.
	thumbLeft := (horizontalScrollOffset / horizontalContentLength) asFloat.
	
	thumb constraintsDo: [ :c | 
		c horizontal matchParent.
		c frame horizontal
			alignLeftAt: thumbLeft;
			weight: realThumbWeight ]
]
