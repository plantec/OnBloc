Class {
	#name : #OBlScrollableElement,
	#superclass : #BlElement,
	#traits : 'TOBlScrollable + TBlAlignable',
	#classTraits : 'TOBlScrollable classTrait + TBlAlignable classTrait',
	#instVars : [
		'scrollState',
		'scrollFlinger',
		'scrollPosition',
		'scrollAlignment',
		'horizontalAlignment',
		'verticalAlignment'
	],
	#category : #'OnBloc-Scrollable-Core'
}

{ #category : #conversion }
OBlScrollableElement >> asScrollableElement [
	^ self
]

{ #category : #'api - scrolling thumb' }
OBlScrollableElement >> computeHorizontalScrollExtent [
	"Compute the horizontal extent of the horizontal scrollbar's thumb within the horizontal range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollRange and #computeHorizontalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	
	^ self width
]

{ #category : #'api - scrolling thumb' }
OBlScrollableElement >> computeHorizontalScrollOffset [
	"Compute the horizontal offset of the horizontal scrollbar's thumb within the horizontal range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollRange.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	
	^ scrollPosition x negated
]

{ #category : #'api - scrolling thumb' }
OBlScrollableElement >> computeHorizontalScrollRange [
	"Compute the horizontal range that the horizontal scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	
	^ self scrolledElement width + self scrolledElement margin width + self padding width
]

{ #category : #'api - scrolling thumb' }
OBlScrollableElement >> computeVerticalScrollExtent [
	"Compute the vertical extent of the vertical scrollbar's thumb within the vertical range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollRange and #computeVerticalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	
	^ self height
]

{ #category : #'api - scrolling thumb' }
OBlScrollableElement >> computeVerticalScrollOffset [
	"Compute the vertical offset of the vertical scrollbar's thumb within the vertical range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollExtent and #computeVerticalScrollRange.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"

	^ scrollPosition y negated
]

{ #category : #'api - scrolling thumb' }
OBlScrollableElement >> computeVerticalScrollRange [
	"Compute the vertical range that the vertical scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollExtent and #computeVerticalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"

	^ self scrolledElement height + self scrolledElement margin height + self padding height
]

{ #category : #initialization }
OBlScrollableElement >> defaultHorizontalAlignment [
	"By default alignment should not influence on layout process,
	so to not deal with nils use null object"
	<return: #BlNullAlignment>
	
	^ BlElementAlignment null horizontal
]

{ #category : #initialization }
OBlScrollableElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
OBlScrollableElement >> defaultVerticalAlignment [
	"By default alignment should not influence on layout process,
	so to not deal with nils use null object"
	<return: #BlNullAlignment>
	
	^ BlElementAlignment null vertical
]

{ #category : #scrolling }
OBlScrollableElement >> flingBy: aVelocityPoint [
	self scrollFlinger flingBy: aVelocityPoint
]

{ #category : #testing }
OBlScrollableElement >> hasScrolledElement [
	^ self children isNotEmpty
]

{ #category : #accessing }
OBlScrollableElement >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ horizontalAlignment
]

{ #category : #accessing }
OBlScrollableElement >> horizontalAlignment: aBlElementAlignment [
	horizontalAlignment := aBlElementAlignment.
	self requestLayout
]

{ #category : #initialization }
OBlScrollableElement >> initialize [
	super initialize.

	scrollFlinger := OBlScrollFlinger on: self.
	scrollPosition := 0.0@0.0.
	scrollState := #idle.
	horizontalAlignment := self defaultHorizontalAlignment.
	verticalAlignment := self defaultVerticalAlignment.

	self addEventHandler: OBlScrollableElementEventHandler new
]

{ #category : #layout }
OBlScrollableElement >> layoutApplyAlignment: aLayoutNode [
	| aContentNode |
	
	aContentNode := aLayoutNode children first.
	
	(aContentNode width < self width)
		ifTrue: [
			| aHorizontalTranslation |
			aHorizontalTranslation := (self horizontalAlignment translationOf: aContentNode bounds in: self bounds inLocal bounds) x.
			scrollPosition := scrollPosition + (aHorizontalTranslation @ 0.0) ].
		
	(aContentNode height < self height)
		ifTrue: [
			| aVerticalTranslation |
			aVerticalTranslation := (self verticalAlignment translationOf: aContentNode bounds in: self bounds inLocal bounds) y.
			scrollPosition := scrollPosition + (0.0 @ aVerticalTranslation) ].
	
	aContentNode position: scrollPosition
]

{ #category : #layout }
OBlScrollableElement >> layoutClampPosition: aLayoutNode [
	| aCurrentPositionX aContentNode aMinPositionX aMaxPositionX aNewClampedPositionX aCurrentPositionY aMinPositionY aMaxPositionY aNewClampedPositionY |
	
	aContentNode := aLayoutNode children first.
	
	aCurrentPositionX := scrollPosition x.
	aMinPositionX := (self width - aContentNode width) min: 0.0.
	aMaxPositionX := 0.0.
	aNewClampedPositionX := (aCurrentPositionX max: aMinPositionX) min: aMaxPositionX.
	
	aCurrentPositionY := scrollPosition y.
	aMinPositionY := (self height - aContentNode height) min: 0.0.
	aMaxPositionY := 0.0.
	aNewClampedPositionY := (aCurrentPositionY max: aMinPositionY) min: aMaxPositionY.
	scrollPosition := aNewClampedPositionX @ aNewClampedPositionY.
	
	aContentNode position: scrollPosition
]

{ #category : #layout }
OBlScrollableElement >> layoutFixGap: aLayoutNode [
	| aContentNode aGapX aGapY |
	
	aContentNode := aLayoutNode children first.
	
	aGapX := (self width - aContentNode right) max: 0.0.
	scrollPosition x < 0
		ifTrue: [
			| aNewX |
			aNewX := (scrollPosition x + aGapX) min: 0.0.
			scrollPosition := aNewX @ scrollPosition y ].
	
	aGapY := (self height - aContentNode bottom) max: 0.0.	
	scrollPosition y < 0
		ifTrue: [
			| aNewY |
			aNewY := (scrollPosition y + aGapY) min: 0.0.
			scrollPosition := scrollPosition x @ aNewY ].

	aContentNode position: scrollPosition
]

{ #category : #'hooks - children' }
OBlScrollableElement >> onChildAdded: anElement [
	super onChildAdded: anElement.
	
	anElement
		constraintsDo: [ :c |
			c frame horizontal alignNone.
			c frame vertical alignNone ]
]

{ #category : #layout }
OBlScrollableElement >> onLayout: aBounds context: aBlElementBoundsUpdater [
	| aPreviousScrollPosition aLayoutNode |
	self scrollFlinger isIdle
		ifFalse: [ ^ super onLayout: aBounds context: aBlElementBoundsUpdater ].
		
	self hasScrolledElement
		ifFalse: [ ^ self ].
		
	aLayoutNode := self userData
		at: #layoutNode
		ifAbsent: [ ^ self ].
	
	aPreviousScrollPosition := scrollPosition.
	
	"first we fix a gap"	
	self layoutFixGap: aLayoutNode.

	"now clamp position"
	self layoutClampPosition: aLayoutNode.

	"then we allign content if it is smaller than the scrollpane"
	self layoutApplyAlignment: aLayoutNode.

	super onLayout: aBounds context: aBlElementBoundsUpdater.
	
	self dispatchOnScrolled: scrollPosition - aPreviousScrollPosition
]

{ #category : #scrolling }
OBlScrollableElement >> scrollBy: aPoint [
	"Instant scroll by the given amount of pixels along either axis.
	Return true if a scroll happens."
	<return: #Boolean>
	| aContent dX dY |

	self hasScrolledElement
		ifFalse: [ ^ false ].

	aContent := self scrolledElement.

	dX := aPoint x.
	dY := aPoint y negated.
	
	self canScrollHorizontally
		ifTrue: [
			| aNewPosition aMinPosition aMaxPosition aNewClampedPosition |
			
			aNewPosition := self scrollPosition x + dX.
			aMinPosition := (self width - aContent width) min: 0.0.
			aMaxPosition := 0.0.
			aNewClampedPosition := (aNewPosition max: aMinPosition) min: aMaxPosition.
			
			dX := aNewClampedPosition - self scrollPosition x ]
		ifFalse: [ dX := 0.0 ].
	
	self canScrollVertically
		ifTrue: [
			| aNewPosition aMinPosition aMaxPosition aNewClampedPosition |
			
			aNewPosition := self scrollPosition y + dY.
			aMinPosition := (self height - aContent height) min: 0.0.
			aMaxPosition := 0.0.
			aNewClampedPosition := (aNewPosition max: aMinPosition) min: aMaxPosition.
			
			dY := aNewClampedPosition - self scrollPosition y ]
		ifFalse: [ dY := 0.0 ].
	
	dX isZero
		ifFalse: [self scrollHorizontallyBy: dX  ].

	dY isZero
		ifFalse: [ self scrollVerticallyBy: dY ].
		
	^ ((dX isZero not) or: [ dY isZero not ])
]

{ #category : #'api - scrolling accessing' }
OBlScrollableElement >> scrollFlinger [
	<return: #OBlScrollFlinger>

	^ scrollFlinger
]

{ #category : #'api - scrolling' }
OBlScrollableElement >> scrollHorizontallyBy: aNumber [
	"Scroll horizontally by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."

	<return: #Number>
	| aContent |
	aContent := self children first.
	scrollPosition := scrollPosition + (aNumber asFloat @ 0.0).
	aContent position: scrollPosition.

	self dispatchOnScrolled: aNumber @ 0.

	^ aNumber
]

{ #category : #'api - scrolling geometry' }
OBlScrollableElement >> scrollMaximum [
	<return: #Point>
	
	^ 0.0@0.0
]

{ #category : #'api - scrolling geometry' }
OBlScrollableElement >> scrollMinimum [
	<return: #Point>
	
	^ (self extent - self scrolledElement extent) min: 0.0@0.0
]

{ #category : #'api - scrolling geometry' }
OBlScrollableElement >> scrollOvershot [
	<return: #Point>
	
	^ self extent / 2.0
]

{ #category : #'api - scrolling geometry' }
OBlScrollableElement >> scrollPosition [
	<return: #Point>
	
	^ scrollPosition
]

{ #category : #'private - scrolling accessing' }
OBlScrollableElement >> scrollState [
	"Return the current scrolling state"
	<return: #Symbol>
	
	^ scrollState
]

{ #category : #'private - scrolling accessing' }
OBlScrollableElement >> scrollState: aScrollState [
	"Internal! Never set me directly"
	
	scrollState := aScrollState
]

{ #category : #'api - scrolling' }
OBlScrollableElement >> scrollVerticallyBy: aNumber [
	"Scroll vertically by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."

	<return: #Number>
	| aContent |
	aContent := self children first.
	scrollPosition := scrollPosition + (0.0 @ aNumber asFloat).
	aContent position: scrollPosition.

	self dispatchOnScrolled: 0 @ aNumber.

	^ aNumber
]

{ #category : #accessing }
OBlScrollableElement >> scrolledElement [
	<return: #BlElement>

	^ self children first
]

{ #category : #accessing }
OBlScrollableElement >> scrolledElementDo: aBlock [
	"Evaluate a given block with the scrolled element if any"

	self children ifNotEmpty: [ :theChildren | aBlock value: theChildren first ]
]

{ #category : #scrolling }
OBlScrollableElement >> smoothScrollBy: aPoint [
	"Animate a scroll by the given amount of pixels along either axis"
	| dX dY |
	
	dX := aPoint x.
	dY := aPoint y.
	
	self canScrollHorizontally
		ifFalse: [ dX := 0.0 ].
	
	self canScrollVertically
		ifFalse: [ dY := 0.0 ].
	
	(dX isZero and: [ dY isZero ])
		ifFalse: [ scrollFlinger smoothScrollBy: dX @ dY ]
]

{ #category : #accessing }
OBlScrollableElement >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ verticalAlignment
]

{ #category : #accessing }
OBlScrollableElement >> verticalAlignment: aBlElementAlignment [
	verticalAlignment := aBlElementAlignment.
	self requestLayout
]
