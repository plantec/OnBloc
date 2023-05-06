Class {
	#name : #OBlSplineOverScrollerScrollMode,
	#superclass : #OBlSplineOverScrollerMode,
	#instVars : [
		'interpolator',
		'startPosition',
		'distance',
		'duration'
	],
	#category : #'OnBloc-Scrollable-Helpers'
}

{ #category : #updating }
OBlSplineOverScrollerScrollMode >> continueOn: aSplineOverScroller [
	"Simple scroll mode does not need to continue, animation can be finished"
	<return: #Boolean>

	^ false
]

{ #category : #accessing }
OBlSplineOverScrollerScrollMode >> distance [
	^ distance
]

{ #category : #accessing }
OBlSplineOverScrollerScrollMode >> distance: anObject [
	distance := anObject
]

{ #category : #accessing }
OBlSplineOverScrollerScrollMode >> duration [
	<return: #Duration>

	^ duration
]

{ #category : #accessing }
OBlSplineOverScrollerScrollMode >> duration: aDuration [

	self
		assert: [ aDuration isNumber not ]
		description: [ 'Duration must not be a typeless number' ].

	duration := aDuration
]

{ #category : #initialization }
OBlSplineOverScrollerScrollMode >> initializeOn: aSplineOverScroller [
	aSplineOverScroller isFinished: false.
	
	aSplineOverScroller startPosition: self startPosition.
	aSplineOverScroller currentPosition: self startPosition.
	aSplineOverScroller finalPosition: self startPosition + self distance.
	
	aSplineOverScroller updateTime
		ifNil: [ aSplineOverScroller startTime: aSplineOverScroller time now ]
		ifNotNil: [ aSplineOverScroller startTime: aSplineOverScroller updateTime ].

	aSplineOverScroller duration: self duration.
	
	aSplineOverScroller deceleration: 0.0.
	aSplineOverScroller startVelocity: 0
]

{ #category : #accessing }
OBlSplineOverScrollerScrollMode >> interpolator [
	^ interpolator
]

{ #category : #accessing }
OBlSplineOverScrollerScrollMode >> interpolator: anObject [
	interpolator := anObject
]

{ #category : #accessing }
OBlSplineOverScrollerScrollMode >> startPosition [
	^ startPosition
]

{ #category : #accessing }
OBlSplineOverScrollerScrollMode >> startPosition: anObject [
	startPosition := anObject
]

{ #category : #updating }
OBlSplineOverScrollerScrollMode >> updateOn: aSplineOverScroller [
	<return: #Boolean>
	| aCurrentTime anElapsedTime aDuration |

	aCurrentTime := aSplineOverScroller time now.

	anElapsedTime := aCurrentTime - aSplineOverScroller startTime.
	aDuration := aSplineOverScroller duration.

	anElapsedTime < aDuration
		ifTrue: [ 
			| anInterpolatedTime anInterpolatedTranslation aNewPosition |
			
			anInterpolatedTime := self interpolator interpolate: (anElapsedTime / aDuration) asFloat.			
			anInterpolatedTranslation := anInterpolatedTime * (aSplineOverScroller finalPosition - aSplineOverScroller startPosition).
			aNewPosition := aSplineOverScroller startPosition + anInterpolatedTranslation.
			
			aSplineOverScroller currentPosition: aNewPosition ].
		
	^ anElapsedTime < aDuration
]
