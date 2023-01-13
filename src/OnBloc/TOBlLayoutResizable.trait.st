Trait {
	#name : #TOBlLayoutResizable,
	#category : #'OnBloc-Resizer'
}

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> exact: aPoint [
	| aSize |
	
	aSize := aPoint asPoint.
	self hExact: aSize x.
	self vExact: aSize y
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> fitContent [
	self hFitContent.
	self vFitContent
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> fitContentLimited [
	self hFitContentLimited.
	self vFitContentLimited
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> hExact: aNumber [

	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"
	(self constraints horizontal resizer isExact
		and: [ self constraints horizontal resizer size = aNumber ])
			ifFalse: [ self constraintsDo: [ :c | c horizontal exact: aNumber ] ].

	self states addState: OBlLayoutHorizontalResizerState exact
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> hFitContent [
	(self constraints horizontal resizer isFitContent)
		ifFalse: [ self constraintsDo: [ :c | c horizontal fitContent ] ].

	self states addState: OBlLayoutHorizontalResizerState fitContent
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> hFitContentLimited [
	(self constraints horizontal resizer isFitContentLimited)
		ifFalse: [ self constraintsDo: [ :c | c horizontal fitContentLimited ] ].

	self states addState: OBlLayoutHorizontalResizerState fitContentLimited
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> hLocal [
	self states addState: OBlLayoutHorizontalResizerState local
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> hMatchParent [
	(self constraints horizontal resizer isMatchParent)
		ifFalse: [ self constraintsDo: [ :c | c horizontal matchParent ] ].

	self states addState: OBlLayoutHorizontalResizerState matchParent
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> matchParent [
	self hMatchParent.
	self vMatchParent
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> vExact: aNumber [
	
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"
	(self constraints vertical resizer isExact
		and: [ self constraints vertical resizer size = aNumber ])
			ifFalse: [
				self constraintsDo: [ :c | c vertical exact: aNumber ] ].

	self states addState: OBlLayoutVerticalResizerState exact
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> vFitContent [
	(self constraints vertical resizer isFitContent)
		ifFalse: [ self constraintsDo: [ :c | c vertical fitContent ] ].

	self states addState: OBlLayoutVerticalResizerState fitContent
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> vFitContentLimited [
	(self constraints vertical resizer isFitContentLimited)
		ifFalse: [ self constraintsDo: [ :c | c vertical fitContentLimited ] ].

	self states addState: OBlLayoutVerticalResizerState fitContentLimited
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> vLocal [
	self states addState: OBlLayoutVerticalResizerState local
]

{ #category : #'t  - layout resizeable' }
TOBlLayoutResizable >> vMatchParent [
	(self constraints vertical resizer isMatchParent)
		ifFalse: [ self constraintsDo: [ :c | c vertical matchParent ] ].

	self states addState: OBlLayoutVerticalResizerState matchParent
]
