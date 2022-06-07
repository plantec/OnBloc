Class {
	#name : #OBlLayoutVerticalMatchParentResizerState,
	#superclass : #OBlLayoutVerticalResizerState,
	#category : #'OnBloc-Resizer'
}

{ #category : #comparing }
OBlLayoutVerticalMatchParentResizerState >> = anotherState [
	^ anotherState isKindOf: OBlLayoutVerticalMatchParentResizerState
]

{ #category : #comparing }
OBlLayoutVerticalMatchParentResizerState >> hash [
	^ OBlLayoutVerticalMatchParentResizerState hash
]
