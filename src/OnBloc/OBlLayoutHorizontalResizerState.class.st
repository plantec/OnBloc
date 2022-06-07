Class {
	#name : #OBlLayoutHorizontalResizerState,
	#superclass : #OBlLayoutResizerState,
	#classInstVars : [
		'any'
	],
	#category : #'OnBloc-Resizer'
}

{ #category : #'instance creation' }
OBlLayoutHorizontalResizerState class >> any [
	^ any ifNil: [ any := self exact or: (self fitContent or: (self fitContentLimited or: self matchParent)) ]
]

{ #category : #cleanup }
OBlLayoutHorizontalResizerState class >> cleanUp [
	any := nil
]

{ #category : #'instance creation' }
OBlLayoutHorizontalResizerState class >> exact [
	^ OBlLayoutHorizontalExactResizerState uniqueInstance
]

{ #category : #'instance creation' }
OBlLayoutHorizontalResizerState class >> fitContent [
	^ OBlLayoutHorizontalFitContentResizerState uniqueInstance
]

{ #category : #'instance creation' }
OBlLayoutHorizontalResizerState class >> fitContentLimited [
	^ OBlLayoutHorizontalFitContentLimitedResizerState uniqueInstance
]

{ #category : #'instance creation' }
OBlLayoutHorizontalResizerState class >> local [
	^ OBlLayoutHorizontalLocalResizerState uniqueInstance
]

{ #category : #'instance creation' }
OBlLayoutHorizontalResizerState class >> matchParent [
	^ OBlLayoutHorizontalMatchParentResizerState uniqueInstance
]
