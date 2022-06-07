Class {
	#name : #OBlLayoutVerticalFitContentLimitedResizerState,
	#superclass : #OBlLayoutVerticalResizerState,
	#category : #'OnBloc-Resizer'
}

{ #category : #comparing }
OBlLayoutVerticalFitContentLimitedResizerState >> = anotherState [
	^ anotherState isKindOf: OBlLayoutVerticalFitContentLimitedResizerState
]

{ #category : #comparing }
OBlLayoutVerticalFitContentLimitedResizerState >> hash [
	^ OBlLayoutVerticalFitContentLimitedResizerState hash
]
