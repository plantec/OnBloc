"
I encapsulate animated smooth scrolling in both X and Y directions with the ability to overshoot the bounds of a scrolling operation.
For each axis I contain a separate spline based overshooting scroller (OBlOvershootingSplineBasedScroller).

# Scrolling modes

There are two types of smooth scroll modes: fling and smooth scroll. 

## Fling

The goal of Fling is to simulate physics and gravity so that it could be used for finger-based scrolling. Fling s behaviour is implemented based on spline approximation and supports overshooting distance. 

## Smooth scroll

Is a simple smooth animated scroll without support of the overshooting and that relies on an interpolator to compute scroll delta

"
Class {
	#name : #OBlOvershootingScroller,
	#superclass : #Object,
	#traits : 'TBlDebug + TBlEventTarget',
	#classTraits : 'TBlDebug classTrait + TBlEventTarget classTrait',
	#instVars : [
		'interpolator',
		'scrollerX',
		'scrollerY',
		'isFlywheel',
		'time',
		'eventDispatcher'
	],
	#category : #'OnBloc-Scrollable-Core'
}

{ #category : #'instance creation' }
OBlOvershootingScroller class >> interpolator: anInterpolator [

	^ self new
		interpolator: anInterpolator;
		yourself
]

{ #category : #'api - accessing' }
OBlOvershootingScroller >> currentPosition [
	^ self currentX @ self currentY
]

{ #category : #accessing }
OBlOvershootingScroller >> currentVelocity [
	"sqrt(x^2 + y^2)"
	
	^ ((scrollerX currentVelocity * scrollerX currentVelocity) + (scrollerY currentVelocity * scrollerY currentVelocity)) sqrt
]

{ #category : #accessing }
OBlOvershootingScroller >> currentX [
	^ scrollerX currentPosition
]

{ #category : #accessing }
OBlOvershootingScroller >> currentY [
	^ scrollerY currentPosition
]

{ #category : #initialization }
OBlOvershootingScroller >> defaultDuration [
	^ 200 milliSeconds
]

{ #category : #initialization }
OBlOvershootingScroller >> defaultEventDispatcher [
	"Return class of event dispatcher.
	Instantiation happens in initialize"
	^ BlDirectEventDispatcher
]

{ #category : #initialization }
OBlOvershootingScroller >> defaultFlyweel [
	^ true
]

{ #category : #initialization }
OBlOvershootingScroller >> defaultInterpolator [
	^ BlViscousFluidInterpolator default
]

{ #category : #initialization }
OBlOvershootingScroller >> defaultSplineScroller [
	^ OBlOvershootingSplineBasedScroller new
]

{ #category : #'event management accessing' }
OBlOvershootingScroller >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #accessing }
OBlOvershootingScroller >> finalX [
	^ scrollerX finalPosition
]

{ #category : #accessing }
OBlOvershootingScroller >> finalY [
	^ scrollerY finalPosition
]

{ #category : #'api - scrolling' }
OBlOvershootingScroller >> finish [
	"Stops the animation.
	Contrary to ==#forceFinished:== aborting the animating causes the scroller to move to the final x and y positions"

	scrollerX finish.
	scrollerY finish
]

{ #category : #'api - scrolling' }
OBlOvershootingScroller >> fling: aStartPosition velocity: aVelocityPoint [

	self
		fling: aStartPosition
		velocity: aVelocityPoint
		min: Float negativeInfinity @ Float negativeInfinity
		max: Float infinity @ Float infinity
		overshot: 0@0
]

{ #category : #'api - scrolling' }
OBlOvershootingScroller >> fling: aStartPosition velocity: aVelocityPoint min: aMinPosition max: aMaxPosition [

	self
		fling: aStartPosition
		velocity: aVelocityPoint
		min: aMinPosition
		max: aMaxPosition
		overshot: 0@0
]

{ #category : #'api - scrolling' }
OBlOvershootingScroller >> fling: aStartPosition velocity: aVelocityPoint min: aMinPosition max: aMaxPosition overshot: anOvershotDistance [
	| aVelocityX aVelocityY |
	
	aVelocityX := aVelocityPoint x.
	aVelocityY := aVelocityPoint y.
	
	"Continue a scroll or fling in progress"
	(isFlywheel and: [ self isFinished not ])
		ifTrue: [
			| anOldVelocityX anOldVelocityY |
			anOldVelocityX := scrollerX currentVelocity.
			anOldVelocityY := scrollerY currentVelocity.
			
			(aVelocityX sign = anOldVelocityX sign and: [ 
				aVelocityY sign = anOldVelocityY sign ])
				ifTrue: [ 
					aVelocityX := scrollerX truncated: (aVelocityX + anOldVelocityX).
					aVelocityY := scrollerY truncated: (aVelocityY + anOldVelocityY) ] ].
	
	scrollerX
		fling: aVelocityX
		start: aStartPosition x
		min: aMinPosition x
		max: aMaxPosition x
		over: anOvershotDistance x.

	scrollerY
		fling: aVelocityY
		start: aStartPosition y
		min: aMinPosition y
		max: aMaxPosition y
		over: anOvershotDistance y
]

{ #category : #accessing }
OBlOvershootingScroller >> flywheel: aBoolean [
	"successive fling motions will keep on increasing scroll speed"
	isFlywheel := aBoolean
]

{ #category : #scrolling }
OBlOvershootingScroller >> forceFinished: aBoolean [
	scrollerX isFinished: aBoolean.
	scrollerY isFinished: aBoolean
]

{ #category : #accessing }
OBlOvershootingScroller >> friction: aNumber [
	scrollerX friction: aNumber.
	scrollerY friction: aNumber
]

{ #category : #initialization }
OBlOvershootingScroller >> initialize [
	super initialize.
	
	time := BlTime real.
	interpolator := self defaultInterpolator.
	scrollerX := self defaultSplineScroller time: time.
	scrollerY := self defaultSplineScroller time: time.
	isFlywheel := self defaultFlyweel.
	eventDispatcher := self defaultEventDispatcher on: self
]

{ #category : #accessing }
OBlOvershootingScroller >> interpolator [
	^ interpolator
]

{ #category : #accessing }
OBlOvershootingScroller >> interpolator: anObject [
	interpolator := anObject
]

{ #category : #testing }
OBlOvershootingScroller >> isFinished [
	^ scrollerX isFinished and: [ scrollerY isFinished ]
]

{ #category : #'api - testing' }
OBlOvershootingScroller >> isFlywheel [
	<return: #Boolean>
	
	^ isFlywheel
]

{ #category : #'api - testing' }
OBlOvershootingScroller >> isOverScrolled [
	"Returns whether the current Scroller is currently returning to a valid position.
	Valid bounds were provided by the ==#fling:==method.

	One should check this value before calling ==#startScroll== as the interpolation currently in progress
	to restore a valid position will then be stopped. The caller has to take into account the fact that the started scroll will start from an overscrolled position.
	
	I return true when the current position is overscrolled and in the process of interpolating back to a valid value"
	<return: #Boolean>

	^ (scrollerX isFinished not and: [ scrollerX isSpline not ])
		or: [ scrollerY isFinished not and: [ scrollerY isSpline not ] ]
]

{ #category : #testing }
OBlOvershootingScroller >> isScrollingInDirection: aVectorPoint [
	| aDeltaX aDeltaY |
	
	aDeltaX := scrollerX finalPosition - scrollerX startPosition.
	aDeltaY := scrollerY finalPosition - scrollerY startPosition.
	
	^ self isFinished not and: [
		aVectorPoint x sign = aDeltaX sign and: [ 
			aVectorPoint y sign = aDeltaY sign ] ]
]

{ #category : #'private - notifying' }
OBlOvershootingScroller >> notifyHorizontalEdgeReached: aStartPosition final: aFinalPosition overshot: anOvershotDistance [
	"Notify the scroller that we've reached a horizontal boundary.
	Normally the information to handle this will already be known when the animation is started, such as in a call to one of the fling functions.
	However there are cases where this cannot be known in advance. This function will transition the current motion and animate from aStartPosition to aFinalPosition as appropriate.
	
	aStartPosition - Starting/current X position
	aFinalPosition - Desired final X position
	anOvershotDistance - Magnitude of overscroll allowed. This should be the maximum desired distance from aFinalPosition. Absolute value - must be positive."

	self
		assert: [ anOvershotDistance >= 0 ]
		description: [ 'Overshot distance must not be negative' ].

	scrollerX
		notifyEdgeReached: anOvershotDistance
		start: aStartPosition
		end: aFinalPosition
]

{ #category : #'private - notifying' }
OBlOvershootingScroller >> notifyRun: isFinished [
	self dispatchEvent: (OBlOvershootingScrollerRunEvent new isFinished: isFinished)
]

{ #category : #'private - notifying' }
OBlOvershootingScroller >> notifyVerticalEdgeReached: aStartPosition final: aFinalPosition overshot: anOvershotDistance [
	"Notify the scroller that we've reached a vertical boundary.
	Normally the information to handle this will already be known when the animation is started, such as in a call to one of the fling functions.
	However there are cases where this cannot be known in advance. This function will transition the current motion and animate from aStartPosition to aFinalPosition as appropriate.
	
	aStartPosition - Starting/current Y position
	aFinalPosition - Desired final Y position
	anOvershotDistance - Magnitude of overscroll allowed. This should be the maximum desired distance from aFinalPosition. Absolute value - must be positive."

	self
		assert: [ anOvershotDistance >= 0 ]
		description: [ 'Overshot distance must not be negative' ].
	
	scrollerY
		notifyEdgeReached: anOvershotDistance
		start: aStartPosition
		end: aFinalPosition
]

{ #category : #'api - running' }
OBlOvershootingScroller >> run [
	"Call this when you want to know the new location.
	If it returns true, the animation is not yet finished."
	<return: #Boolean>

	self isFinished
		ifTrue: [
			self notifyRun: false.
			^ false ].

	self time synchronized: [
		scrollerX run.
		scrollerY run ].

	self notifyRun: true.
	^ true
]

{ #category : #accessing }
OBlOvershootingScroller >> scrollerX [
	<return: #OBlOvershootingSplineBasedScroller>

	^ scrollerX
]

{ #category : #accessing }
OBlOvershootingScroller >> scrollerY [
	<return: #OBlOvershootingSplineBasedScroller>

	^ scrollerY
]

{ #category : #scrolling }
OBlOvershootingScroller >> springBack: aStartPoint min: aMinPoint max: aMaxPoint [
	| didSpringX didSpringY |

	didSpringX := scrollerX springback: aStartPoint x min: aMinPoint x max: aMaxPoint x.
	didSpringY := scrollerY springback: aStartPoint y min: aMinPoint y max: aMaxPoint y.
	
	^ didSpringX or: [ didSpringY ]
]

{ #category : #'api - scrolling' }
OBlOvershootingScroller >> startScrollAt: aStartPoint by: aDeltaPoint [

	self startScrollAt: aStartPoint by: aDeltaPoint during: self defaultDuration
]

{ #category : #'api - scrolling' }
OBlOvershootingScroller >> startScrollAt: aStartPoint by: aDeltaPoint during: aDuration [

	scrollerX
		startScrollBy: aDeltaPoint x
		from: aStartPoint x
		during: aDuration
		interpolator: interpolator.

	scrollerY
		startScrollBy: aDeltaPoint y
		from: aStartPoint y
		during: aDuration
		interpolator: interpolator
]

{ #category : #accessing }
OBlOvershootingScroller >> startX [
	^ scrollerX startPosition
]

{ #category : #accessing }
OBlOvershootingScroller >> startY [
	^ scrollerY startPosition
]

{ #category : #accessing }
OBlOvershootingScroller >> time [
	<return: #BlTime>
	
	^ time
]

{ #category : #accessing }
OBlOvershootingScroller >> time: aTime [
	time := aTime.
	scrollerX time: aTime.
	scrollerY time: aTime
]

{ #category : #accessing }
OBlOvershootingScroller >> timePassed [
	"Returns the time elapsed since the beginning of the scrolling."
	<return: #Duration>
	| aTime aStartTime |
	
	aTime := DateAndTime millisecondClockValue.
	aStartTime := scrollerX startTime min: scrollerY startTime.

	^ aTime - aStartTime
]

{ #category : #'api - accessing' }
OBlOvershootingScroller >> velocity [
	"Return a velocity vector where each component represents a velocity along each axis"
	<return: #BlVector>
	
	^ BlVector x: scrollerX currentVelocity y: scrollerY currentVelocity
]
