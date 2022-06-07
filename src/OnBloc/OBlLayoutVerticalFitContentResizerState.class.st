Class {
	#name : #OBlLayoutVerticalFitContentResizerState,
	#superclass : #OBlLayoutVerticalResizerState,
	#category : #'OnBloc-Resizer'
}

{ #category : #comparing }
OBlLayoutVerticalFitContentResizerState >> = anotherState [
	^ anotherState isKindOf: OBlLayoutVerticalFitContentResizerState
]

{ #category : #comparing }
OBlLayoutVerticalFitContentResizerState >> hash [
	^ OBlLayoutVerticalFitContentResizerState hash
]
