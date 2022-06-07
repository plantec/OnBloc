Class {
	#name : #OBlLayoutHorizontalFitContentLimitedResizerState,
	#superclass : #OBlLayoutHorizontalResizerState,
	#category : #'OnBloc-Resizer'
}

{ #category : #comparing }
OBlLayoutHorizontalFitContentLimitedResizerState >> = anotherState [
	^ anotherState isKindOf: OBlLayoutHorizontalFitContentLimitedResizerState
]

{ #category : #comparing }
OBlLayoutHorizontalFitContentLimitedResizerState >> hash [
	^ OBlLayoutHorizontalFitContentLimitedResizerState hash
]
