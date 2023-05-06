Class {
	#name : #OBlSplineOverScrollerStep,
	#superclass : #Object,
	#classInstVars : [
		'spline',
		'cubic',
		'ballistic'
	],
	#category : #'OnBloc-Scrollable-Helpers'
}

{ #category : #accessing }
OBlSplineOverScrollerStep class >> ballistic [
	^ ballistic ifNil: [ ballistic := OBlSplineOverScrollerBallisticStep new ]
]

{ #category : #cleanup }
OBlSplineOverScrollerStep class >> cleanUp [
	super cleanUp.
	
	ballistic := nil.
	cubic := nil.
	spline := nil
]

{ #category : #accessing }
OBlSplineOverScrollerStep class >> cubic [
	^ cubic ifNil: [ cubic := OBlSplineOverScrollerCubicStep new ]
]

{ #category : #accessing }
OBlSplineOverScrollerStep class >> spline [
	^ spline ifNil: [ spline := OBlSplineOverScrollerSplineStep new ]
]

{ #category : #comparing }
OBlSplineOverScrollerStep >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
OBlSplineOverScrollerStep >> hash [
	^ self class hash
]

{ #category : #hooks }
OBlSplineOverScrollerStep >> onFinished: aSplineOverScroller [
	"Is sent after animation duration is reached. It does not necessarily mean that scrolling should stop,
	for example if we overshoot the target we should to bounce back.
	Return true if animation should continue, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]
