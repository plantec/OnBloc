Class {
	#name : #OBlSplineOverScrollerMode,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'OnBloc-Scrollable-Helpers'
}

{ #category : #updating }
OBlSplineOverScrollerMode >> continueOn: aSplineOverScroller [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #updating }
OBlSplineOverScrollerMode >> finishOn: aSplineOverScroller [
	"Finish animation and finalize scroller state"

	aSplineOverScroller currentPosition: aSplineOverScroller finalPosition.
	aSplineOverScroller currentVelocity: 0.0.
	aSplineOverScroller isFinished: true.
	aSplineOverScroller updateTime: nil.
]

{ #category : #initialization }
OBlSplineOverScrollerMode >> initializeOn: aSplineOverScroller [
	self subclassResponsibility
]

{ #category : #updating }
OBlSplineOverScrollerMode >> updateOn: aSplineOverScroller [
	<return: #Boolean>

	self subclassResponsibility
]
