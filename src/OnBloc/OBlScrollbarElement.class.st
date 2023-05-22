Class {
	#name : #OBlScrollbarElement,
	#superclass : #BlElement,
	#instVars : [
		'scrollable',
		'thumb',
		'dragPosition',
		'pullHandler',
		'track',
		'scrollHandler',
		'thumbDragHandler',
		'thumbDragStartHandler'
	],
	#category : #'OnBloc-Scrollable-Core'
}

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> attachTo: aTOBlScrollable [
	"Attach me to a given scrollable element (any element that implements TOBlScrollable trait)"

	scrollable ifNotNil: [ self detachFrom: scrollable ].

	aTOBlScrollable addEventHandler: scrollHandler.
	scrollable := aTOBlScrollable
]

{ #category : #initialization }
OBlScrollbarElement >> defaultPullHandler [

	^ self subclassResponsibility
]

{ #category : #initialization }
OBlScrollbarElement >> defaultThumbBackground [

	^ Color gray
]

{ #category : #initialization }
OBlScrollbarElement >> defaultTrackBackground [

	^ Color black alpha: 0.25
]

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> detach [
	"Detach me from a scrollable element"

	scrollable ifNil: [ ^ self ].

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

	scrollHandler :=
		BlEventHandler
			on: BlElementScrolledEvent
			do: [ :anEvent |
				self isAttachedToScrollable
					ifTrue: [ self updateThumbPosition ] ].
	pullHandler := self defaultPullHandler.
	thumbDragStartHandler :=
		BlEventHandler
			on: BlPullStartEvent
			do: [ :anEvent | dragPosition := anEvent currentTarget position ].
	thumbDragHandler :=
		BlEventHandler
			on: BlPullEvent
			do: [ :anEvent |
				self isAttachedToScrollable ifTrue: [
					 self onDraggedThumbBy: anEvent currentPosition ] ].

	self track: self newDefaultTrack.
	self thumb: self newDefaultThumb
]

{ #category : #'private - scrolling' }
OBlScrollbarElement >> isAttachedToScrollable [

	^ scrollable isNotNil
]

{ #category : #initialization }
OBlScrollbarElement >> newDefaultThumb [
	"Answer a `BlElement` that represents the default thumb."

	^ self subclassResponsibility
]

{ #category : #initialization }
OBlScrollbarElement >> newDefaultTrack [
	"Answer a `BlElement` that represents the default track."
	
	^ self subclassResponsibility
]

{ #category : #'private - scrolling' }
OBlScrollbarElement >> onDraggedThumbBy: aPoint [

	self subclassResponsibility
]

{ #category : #'private - thumb' }
OBlScrollbarElement >> registerThumb: anElement [

	anElement
		addEventHandler: pullHandler;
		addEventHandler: thumbDragStartHandler;
		addEventHandler: thumbDragHandler
]

{ #category : #'private - scrolling' }
OBlScrollbarElement >> scrollableDeltaFromThumbDelta: thumbDelta range: scrollRange length: scrollbarLength [

	| result |
	scrollbarLength isZero ifTrue: [ ^ 0 ].

	(thumbDelta closeTo: 0.0 epsilon: 0.5) ifTrue: [ ^ 0 ].

	result := (thumbDelta * scrollRange / scrollbarLength) asFloat.
	
	(result closeTo: 0.0 epsilon: 0.5) ifTrue: [ ^ 0 ].
	
	^ result
]

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> thumb [

	^ thumb
]

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> thumb: anElement [
	
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

	^ track
]

{ #category : #'api - scrollbar' }
OBlScrollbarElement >> track: anElement [
	
	track
		ifNotNil: [ :aCurrentTrack | self replaceChild: aCurrentTrack with: anElement as: #track ]
		ifNil: [ self addChild: anElement as: #track ].

	track := anElement
]

{ #category : #'private - thumb' }
OBlScrollbarElement >> unregisterThumb: anElement [

	anElement
		removeEventHandler: pullHandler;
		removeEventHandler: thumbDragStartHandler;
		removeEventHandler: thumbDragHandler
]

{ #category : #'private - scrolling' }
OBlScrollbarElement >> updateThumbPosition [

	self subclassResponsibility
]
