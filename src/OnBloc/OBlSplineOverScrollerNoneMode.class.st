Class {
	#name : #OBlSplineOverScrollerNoneMode,
	#superclass : #OBlSplineOverScrollerMode,
	#category : #'OnBloc-Scrollable-Helpers'
}

{ #category : #updating }
OBlSplineOverScrollerNoneMode >> continueOn: aSplineOverScroller [
	<return: #Boolean>
	
	^ false
]

{ #category : #updating }
OBlSplineOverScrollerNoneMode >> finishOn: aSplineOverScroller [
]

{ #category : #initialization }
OBlSplineOverScrollerNoneMode >> initializeOn: aSplineOverScroller [
]

{ #category : #updating }
OBlSplineOverScrollerNoneMode >> updateOn: aSplineOverScroller [
	<return: #Boolean>

	^ false
]
