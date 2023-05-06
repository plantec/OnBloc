Class {
	#name : #OBlScrollFlinger,
	#superclass : #BlTask,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'interpolator',
		'scroller',
		'lastFlingX',
		'lastFlingY',
		'step',
		'eatRunOnAnimationRequest',
		'scrollable',
		'shouldRequeueTask'
	],
	#category : #'OnBloc-Scrollable-Core'
}

{ #category : #'instance creation' }
OBlScrollFlinger class >> on: aTOBlScrollable [

	^ self basicNew
		initializeWith: aTOBlScrollable;
		initialize;
		yourself
]

{ #category : #'private - state' }
OBlScrollFlinger >> beIdle [
	self scrollable scrollState: #idle
]

{ #category : #'private - state' }
OBlScrollFlinger >> beSettling [
	self scrollable scrollState: #settling
]

{ #category : #'private - physics' }
OBlScrollFlinger >> computeScrollDurationFor: aVelocityPoint distance: aDeltaPoint [
	<return: #Duration>

	| anAbsDx anAbsDy isHorizontal aVelocity aDelta aContainerSize aHalfContainerSize aDistanceRatio aDistance aDuration |
 
	anAbsDx := aDeltaPoint x abs.
	anAbsDy := aDeltaPoint y abs.
	isHorizontal := anAbsDx > anAbsDy.
	aVelocity := aVelocityPoint r. "sqrt(x*x + y*y)"
	aDelta := aDeltaPoint r. "sqrt(x*x + y*y)"
	aContainerSize := isHorizontal
		ifTrue: [ self scrollable width ]
		ifFalse: [ self scrollable height ].
	aHalfContainerSize := aContainerSize / 2.0.
	aDistanceRatio := (aDelta / aContainerSize) min: 1.0.
	aDistance := aHalfContainerSize + (aHalfContainerSize * (self distanceInfluenceForSnapDuration: aDistanceRatio)).
	
	aDuration := (aVelocity > 0)
		ifTrue: [ 4 * (1000.0 * (aDistance / aVelocity) abs) rounded ]
		ifFalse: [ 
			| anAbsDelta |
			anAbsDelta := isHorizontal
				ifTrue: [ anAbsDx ]
				ifFalse: [ anAbsDy ].
			(((anAbsDelta / aContainerSize) + 1) * 300) asInteger ].
	
	^ aDuration milliSeconds min: self maxScrollDuration
]

{ #category : #initialization }
OBlScrollFlinger >> createScrollerFor: anInterpolator [
	^ OBlOvershootingScroller interpolator: interpolator
]

{ #category : #initialization }
OBlScrollFlinger >> createState [
	^ OBlScrollFlingerState new
]

{ #category : #initialization }
OBlScrollFlinger >> defaultInterpolator [
	^ BlQuinticInterpolator default
]

{ #category : #'private - scheduling' }
OBlScrollFlinger >> disableRunOnAnimationRequests [
	shouldRequeueTask := false.
	eatRunOnAnimationRequest := true
]

{ #category : #'private - physics' }
OBlScrollFlinger >> distanceInfluenceForSnapDuration: aFactorNumber [
	<return: #Number>
	| f |

	f := aFactorNumber - 0.5. "center the values about 0"
	f := f * 0.3 * Float pi / 2.0.
	^ f sin
]

{ #category : #'private - scheduling' }
OBlScrollFlinger >> enableRunOnAnimationRequests [
	eatRunOnAnimationRequest := false.
	shouldRequeueTask
		ifTrue: [ self postOnAnimation ]
]

{ #category : #'api - scrolling' }
OBlScrollFlinger >> flingBy: aVelocityPoint [
	"Positive velocity means that the finger/cursor is moving down the screen, which means we want to scroll towards the top.
	Initial velocity is given in points/second"

	self beSettling.

	lastFlingX := self scrollable scrollPosition x.
	lastFlingY := self scrollable scrollPosition y.
	scroller
		fling: self scrollable scrollPosition
		velocity: aVelocityPoint
		min: self scrollable scrollMinimum
		max: self scrollable scrollMaximum
		overshot: self scrollable scrollOvershot.

	self postOnAnimation
]

{ #category : #initialization }
OBlScrollFlinger >> initialize [
	super initialize.
	
	lastFlingX := 0.
	lastFlingY := 0.
	interpolator := self defaultInterpolator.
	scroller := self createScrollerFor: interpolator.
	eatRunOnAnimationRequest := false.
	shouldRequeueTask := false.
]

{ #category : #initialization }
OBlScrollFlinger >> initializeWith: aTOBlScrollable [

	self
		assert: [ scrollable isNil ]
		description: [ 'I can be initialized only once!' ].

	scrollable := aTOBlScrollable
]

{ #category : #accessing }
OBlScrollFlinger >> interpolator [
	<return: #BlInterpolator>
	
	^ interpolator
]

{ #category : #'api - testing' }
OBlScrollFlinger >> isIdle [
	<return: #Boolean>

	^ self scrollable scrollState = #idle
]

{ #category : #accessing }
OBlScrollFlinger >> lastFlingPosition [
	<return: #Point>
	
	^ lastFlingX @ lastFlingY
]

{ #category : #initialization }
OBlScrollFlinger >> maxScrollDuration [
	<return: #Duration>

	^ 2 seconds
]

{ #category : #hooks }
OBlScrollFlinger >> onEnqueued: aBlSpace [
	super onEnqueued: aBlSpace.
	
	self scroller time: aBlSpace time
]

{ #category : #hooks }
OBlScrollFlinger >> onFinished [
]

{ #category : #hooks }
OBlScrollFlinger >> onInitialized [
]

{ #category : #hooks }
OBlScrollFlinger >> onLayoutScrolled [
]

{ #category : #hooks }
OBlScrollFlinger >> onNotFinished [
]

{ #category : #hooks }
OBlScrollFlinger >> onPrepareToRun [
]

{ #category : #hooks }
OBlScrollFlinger >> onSmoothScrolled [
]

{ #category : #scheduling }
OBlScrollFlinger >> postOnAnimation [
	self
		assert: [ scrollable isNotNil ]
		description: [ 'Can not post on animation if I am not attached to a scrollable' ].

	eatRunOnAnimationRequest 
		ifTrue: [ 
			shouldRequeueTask := true ]
		ifFalse:[ 
			self isNew 
				ifTrue: [ self scrollable enqueueTask: self ]
				ifFalse: [ 
					self isExecuting 
						ifTrue: [ shouldRequeueTask := true ]
						ifFalse: [ 
							self isComplete 
								ifTrue: [ 
									self setNew.
									shouldRequeueTask := false.
									self scrollable enqueueTask: self ] ] ] ].
]

{ #category : #running }
OBlScrollFlinger >> pulse [
	"To work with animation manager"

	self run
]

{ #category : #'private - testing' }
OBlScrollFlinger >> requeueTaskAfterExecution [
	"Answer a boolean indicating whether the receiver should be requeued after execution."

	^ shouldRequeueTask
]

{ #category : #running }
OBlScrollFlinger >> run [
	| aScroller aSmoothScroller |
		
	self disableRunOnAnimationRequests.
	
	self onPrepareToRun.

	"keep a local reference so that if it is changed during onScrollBy: method,
	it won't cause unexpected behaviors"
	aScroller := scroller.
	aSmoothScroller := self scrollable smoothScroller.

	aScroller run
		ifTrue: [ 
			| aState |
			aState := self runInitOn: aScroller.
			self onInitialized.

			self runLayoutScrollWith: aState.
			self onLayoutScrolled.
			
			self runSmoothOn: aSmoothScroller with: aState.
			self onSmoothScrolled.

			self runOverscrollOn: aScroller with: aState.
			
			aState didScroll
				ifTrue: [ scrollable dispatchOnScrolled: aState hResult @ aState vResult ].
				
			self runFinalizeOn: aScroller with: aState ].
	
	aSmoothScroller ifNotNil: [ 
		aSmoothScroller isPendingInitialRun
			ifTrue: [ aSmoothScroller onScrollBy: 0@0 ].
		"stop if it does not trigger any scroll"
		shouldRequeueTask
			ifFalse: [ aSmoothScroller stop ] ].
		
	self enableRunOnAnimationRequests
]

{ #category : #private }
OBlScrollFlinger >> runFinalizeOn: anOverScroller with: aState [
	| fullyConsumedHorizontal fullyConsumedVertical fullyConsumedAny |
	
	fullyConsumedHorizontal := aState dX isZero not and: [
		self scrollable canScrollHorizontally
			and: [ aState hResult = aState dX ] ].
		
	fullyConsumedVertical := aState dY isZero not and: [
		self scrollable canScrollVertically
			and: [ aState vResult = aState dY ] ].
		
	fullyConsumedAny := aState dX isZero and: [
		aState dY isZero and: [
			fullyConsumedHorizontal or: [ fullyConsumedVertical ] ] ].
	
	(anOverScroller isFinished or: [ fullyConsumedHorizontal and: [ fullyConsumedVertical ] ])
		ifTrue: [
			self beIdle.
			self onFinished ]
		ifFalse: [
			self postOnAnimation.
			self onNotFinished ]
]

{ #category : #private }
OBlScrollFlinger >> runInitOn: anOverScroller [
	<return: #OBlScrollFlingerState>
	| aState |

	aState := self createState.
	aState
		x: anOverScroller currentX;
		y: anOverScroller currentY;
		dX: aState x - lastFlingX;
		dY: aState y - lastFlingY;
		hResult: 0;
		vResult: 0;
		overscrollX: 0;
		overscrollY: 0.
	
	lastFlingX := aState x.
	lastFlingY := aState y.
	
	^ aState
]

{ #category : #private }
OBlScrollFlinger >> runLayoutScrollWith: aState [
	"A state is an instance of OBlScrollFlingerState"

	aState dX isZero
		ifFalse: [ 
			aState hResult: (scrollable scrollHorizontallyBy: aState dX).
			aState overscrollX: aState dX - aState hResult ].
	
	aState dY isZero
		ifFalse: [ 
			aState vResult: (scrollable scrollVerticallyBy: aState dY).
			aState overscrollY: aState dY - aState vResult ]
]

{ #category : #private }
OBlScrollFlinger >> runOverscrollOn: anOverScroller with: aState [
	| aVelocity aVelocityX aVelocityY |
	
	self scrollable overScrollMode ~= OBlOverScrollMode never
		ifTrue: [ self scrollable considerReleasingGlowsOnScroll: aState dX @ aState dY ].
	
	"Should not overscroll if distances in both directions are zero"
	(aState overscrollX isZero and: [
		aState overscrollY isZero ])
			ifTrue: [ ^ self ].
			
	aVelocity := anOverScroller velocity.
	
	aVelocityX := 0.
	(aState overscrollX ~= aState x)
		ifTrue: [
			aVelocityX := (aState overscrollX < 0)
				ifTrue: [ aVelocity x negated ]
				ifFalse: [ (aState overscrollX > 0)
					ifTrue: [ aVelocity x ]
					ifFalse: [ 0 ] ] ].
		
	aVelocityY := 0.
	(aState overscrollY ~= aState y)
		ifTrue: [
			aVelocityY := (aState overscrollY < 0)
				ifTrue: [ aVelocity y negated ]
				ifFalse: [ (aState overscrollY > 0)
					ifTrue: [ aVelocity y ]
					ifFalse: [ 0 ] ] ].
	
	"Overscroll happened, make sure glows are notified"
	(self scrollable overScrollMode ~= OBlOverScrollMode never)
		ifTrue: [ self scrollable absorbGlows: aVelocityX @ aVelocityY ].
	
	"Check if we need to finish scrolling"
	((aVelocityX isZero not or: [
		aState overscrollX = aState x or: [ 
			anOverScroller finalX isZero ] ])
		and: [ aVelocityY isZero not or: [
					aState overscrollY = aState y or: [ 
						anOverScroller finalY isZero ] ] ])
			ifTrue: [ anOverScroller finish ]
]

{ #category : #private }
OBlScrollFlinger >> runSmoothOn: aSmoothScroller with: aState [
	| aDeltaPoint |

	"Can not scroll smoothly using nil scroller
	(which means that smooth scroll was not requested)"
	aSmoothScroller
		ifNil: [ ^ self ].
	
	"Can not scroll if smooth scroller is not yet initialized or not running"
	(aSmoothScroller isPendingInitialRun or: [
		aSmoothScroller isRunning not ])
			ifTrue: [ ^ self ].

	aDeltaPoint := (aState dX - aState overscrollX) @ (aState dY - aState overscrollY).	

	aSmoothScroller scrollBy: aDeltaPoint
]

{ #category : #accessing }
OBlScrollFlinger >> scrollable [
	<return: #TOBlScrollable>

	^ scrollable
]

{ #category : #accessing }
OBlScrollFlinger >> scroller [
	<return: #OBlOvershootingScroller>
	
	^ scroller
]

{ #category : #'api - scrolling' }
OBlScrollFlinger >> smoothScrollBy: aDeltaPoint [

	self
		smoothScrollBy: aDeltaPoint
		velocity: 0@0
]

{ #category : #'api - scrolling' }
OBlScrollFlinger >> smoothScrollBy: aDeltaPoint during: aDuration [

	self
		smoothScrollBy: aDeltaPoint
		during: aDuration
		with: self defaultInterpolator
]

{ #category : #'api - scrolling' }
OBlScrollFlinger >> smoothScrollBy: aDeltaPoint during: aDuration with: anInterpolator [

	interpolator ~~ anInterpolator
		"Interpolator changes, need to re-create a scroller"
		ifTrue: [ 
			interpolator := anInterpolator.
			scroller := self createScrollerFor: interpolator ].
	
	self beSettling.
	lastFlingX := 0.
	lastFlingY := 0.
	scroller startScrollAt: 0@0 by: aDeltaPoint during: aDuration.
	self postOnAnimation
]

{ #category : #'api - scrolling' }
OBlScrollFlinger >> smoothScrollBy: aDeltaPoint velocity: aVelocityPoint [

	self
		smoothScrollBy: aDeltaPoint
		during: (self computeScrollDurationFor: aVelocityPoint distance: aDeltaPoint)
]

{ #category : #'api - scrolling' }
OBlScrollFlinger >> stop [
	scroller finish
]

{ #category : #running }
OBlScrollFlinger >> value [
	"To support defer:"
	self run
]
