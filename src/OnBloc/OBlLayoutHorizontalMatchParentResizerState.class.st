Class {
	#name : #OBlLayoutHorizontalMatchParentResizerState,
	#superclass : #OBlLayoutHorizontalResizerState,
	#category : #'OnBloc-Resizer'
}

{ #category : #comparing }
OBlLayoutHorizontalMatchParentResizerState >> = anotherState [
	^ anotherState isKindOf: OBlLayoutHorizontalMatchParentResizerState
]

{ #category : #comparing }
OBlLayoutHorizontalMatchParentResizerState >> hash [
	^ OBlLayoutHorizontalMatchParentResizerState hash
]
