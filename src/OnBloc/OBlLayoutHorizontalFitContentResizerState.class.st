Class {
	#name : #OBlLayoutHorizontalFitContentResizerState,
	#superclass : #OBlLayoutHorizontalResizerState,
	#category : #'OnBloc-Resizer'
}

{ #category : #comparing }
OBlLayoutHorizontalFitContentResizerState >> = anotherState [
	^ anotherState isKindOf: OBlLayoutHorizontalFitContentResizerState
]

{ #category : #comparing }
OBlLayoutHorizontalFitContentResizerState >> hash [
	^ OBlLayoutHorizontalFitContentResizerState hash
]
