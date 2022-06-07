Class {
	#name : #OBlLayoutVerticalResizerState,
	#superclass : #OBlLayoutResizerState,
	#classInstVars : [
		'any'
	],
	#category : #'OnBloc-Resizer'
}

{ #category : #accessing }
OBlLayoutVerticalResizerState class >> any [
	^ any ifNil: [ any := self exact or: (self fitContent or: (self fitContentLimited or: self matchParent)) ]
]

{ #category : #cleanup }
OBlLayoutVerticalResizerState class >> cleanUp [
	any := nil
]

{ #category : #'instance creation' }
OBlLayoutVerticalResizerState class >> exact [
	^ OBlLayoutVerticalExactResizerState uniqueInstance
]

{ #category : #'instance creation' }
OBlLayoutVerticalResizerState class >> fitContent [
	^ OBlLayoutVerticalFitContentResizerState uniqueInstance
]

{ #category : #'instance creation' }
OBlLayoutVerticalResizerState class >> fitContentLimited [
	^ OBlLayoutVerticalFitContentLimitedResizerState uniqueInstance
]

{ #category : #'instance creation' }
OBlLayoutVerticalResizerState class >> local [
	^ OBlLayoutVerticalLocalResizerState uniqueInstance
]

{ #category : #'instance creation' }
OBlLayoutVerticalResizerState class >> matchParent [
	^ OBlLayoutVerticalMatchParentResizerState uniqueInstance
]

{ #category : #accessing }
OBlLayoutVerticalResizerState >> type [
	"Return an object used to compare two states when adding to the collection of states in order to prevent
	elements from having duplicated states"
	<return: #Object>

	^ OBlLayoutVerticalResizerState
]
