Class {
	#name : #OBlScrollbarElement,
	#superclass : #BlElement,
	#instVars : [
		'scrollable',
		'thumb',
		'minimumSize',
		'dragPosition',
		'pullHandler',
		'pullStartHandler',
		'pullEndHandler',
		'pullDragHandler',
		'track',
		'scrollHandler'
	],
	#category : #'OnBloc-Scrollable-Core'
}

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> attachTo: aTOBlScrollable [
	"Attach me to a given scrollable element (any element that implements TOBlScrollable trait)"

	scrollable
		ifNotNil: [ self detachFrom: scrollable ].

	aTOBlScrollable addEventHandler: scrollHandler.
	scrollable := aTOBlScrollable
]

{ #category : #'private - scrolling' }
OBlScrollbarElement >> computeScrollDeltaFrom: anOldDragPosition to: aNewDragPosition offset: aScrollOffset range: aScrollRange length: aScrollbarLength [
	| aPercentage scrollingBy |

	aScrollbarLength isZero
		ifTrue: [ ^ 0 ].

	(aNewDragPosition closeTo: anOldDragPosition epsilon: 0.5)
		ifTrue: [ ^ 0 ].

	aPercentage := ((aNewDragPosition - anOldDragPosition) / aScrollbarLength) asFloat.
	scrollingBy := aPercentage * aScrollRange.
	
	(scrollingBy closeTo: 0 epsilon: 0.5)
		ifTrue: [ ^ 0 ].
	
	^ scrollingBy
]

{ #category : #initialization }
OBlScrollbarElement >> defaultPullHandler [
	^ self subclassResponsibility
]

{ #category : #initialization }
OBlScrollbarElement >> defaultThumb [
	<return: #BlElement>

	^ self subclassResponsibility
]

{ #category : #initialization }
OBlScrollbarElement >> defaultTrack [
	<return: #BlElement>
	
	^ self subclassResponsibility
]

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> detach [
	"Detach me from a scrollable element"

	scrollable
		ifNil: [ ^ self ].
		
	self detachFrom: scrollable
]

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> detachFrom: aTOBlScrollable [
	"Detach me from a given scrollable element (any element that implements TOBlScrollable trait)"

	aTOBlScrollable removeEventHandler: scrollHandler.
	scrollable := nil
]

{ #category : #initialization }
OBlScrollbarElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.

	minimumSize := 0.05.

	scrollHandler := BlEventHandler
		on: BlElementScrolledEvent
		do: [ :anEvent | self onScrolled: anEvent currentTarget ].
	pullHandler := self defaultPullHandler.
	pullStartHandler := BlEventHandler on: BlPullStartEvent do: [ dragPosition := nil ].
	pullDragHandler := BlEventHandler on: BlPullEvent do: [ :anEvent | self onDragged: anEvent ].
	pullEndHandler := BlEventHandler on: BlPullEndEvent do: [ dragPosition := nil ].

	self track: self defaultTrack.
	self thumb: self defaultThumb
]

{ #category : #'private - scrolling' }
OBlScrollbarElement >> isAttachedToScrollable [
	^ scrollable isNotNil
]

{ #category : #'hooks - scrolling' }
OBlScrollbarElement >> onDragged: anEvent [
	self isAttachedToScrollable
		ifFalse: [ ^ self ].

	dragPosition := dragPosition
		ifNil: [ anEvent currentTarget position ].

	self scrollTo: anEvent newPosition
]

{ #category : #'hooks - scrolling' }
OBlScrollbarElement >> onScrolled: aScrollable [
	self isAttachedToScrollable
		ifFalse: [ ^ self ].

	self updateScrollPosition
]

{ #category : #'private - thumb' }
OBlScrollbarElement >> registerThumb: anElement [
	anElement addEventHandler: pullHandler.
	anElement addEventHandler: pullStartHandler.
	anElement addEventHandler: pullDragHandler.
	anElement addEventHandler: pullEndHandler
]

{ #category : #'private - scrolling' }
OBlScrollbarElement >> scrollTo: aPoint [
	self subclassResponsibility
]

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> thumb [
	<return: #BlElement>

	^ thumb
]

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> thumb: anElement [
	<return: #BlElement>
	
	thumb
		ifNotNil: [ :aCurrentThumb |
			self unregisterThumb: aCurrentThumb.
			self replaceChild: aCurrentThumb with: anElement as: #thumb ]
		ifNil: [ self addChild: anElement as: #thumb ].
	
	thumb := anElement.
	self registerThumb: thumb
]

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> track [
	<return: #BlElement>

	^ track
]

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> track: anElement [
	<return: #BlElement>
	
	track
		ifNotNil: [ :aCurrentTrack | self replaceChild: aCurrentTrack with: anElement as: #track ]
		ifNil: [ self addChild: anElement as: #track ].

	track := anElement
]

{ #category : #'private - thumb' }
OBlScrollbarElement >> unregisterThumb: anElement [
	anElement removeEventHandler: pullHandler.
	anElement removeEventHandler: pullStartHandler.
	anElement removeEventHandler: pullDragHandler.
	anElement removeEventHandler: pullEndHandler
]

{ #category : #'private - scrolling' }
OBlScrollbarElement >> updateScrollPosition [
	self subclassResponsibility
]
