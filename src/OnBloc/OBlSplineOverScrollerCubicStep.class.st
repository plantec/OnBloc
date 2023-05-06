Class {
	#name : #OBlSplineOverScrollerCubicStep,
	#superclass : #OBlSplineOverScrollerStep,
	#category : #'OnBloc-Scrollable-Helpers'
}

{ #category : #hooks }
OBlSplineOverScrollerCubicStep >> onFinished: aSplineOverScroller [
	"Cubic means no spring back, simply finish"
	<return: #Boolean>
	
	^ false
]
