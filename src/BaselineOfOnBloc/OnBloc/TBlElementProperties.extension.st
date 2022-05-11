Extension { #name : #TBlElementProperties }

{ #category : #'*OnBloc' }
TBlElementProperties >> hExact: aWidth [
	self addProperty: (BlElementLayoutHorizontalResizerProperty new exact: aWidth)
]

{ #category : #'*OnBloc' }
TBlElementProperties >> hFitContent [
	self addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent)
]

{ #category : #'*OnBloc' }
TBlElementProperties >> hFitContentLimited [
	self addProperty: (BlElementLayoutHorizontalResizerProperty new fitContentLimited)
]

{ #category : #'*OnBloc' }
TBlElementProperties >> hMatchParent [
	self addProperty: (BlElementLayoutHorizontalResizerProperty new matchParent)
]

{ #category : #'*OnBloc' }
TBlElementProperties >> vExact: aHeight [
	self addProperty: (BlElementLayoutVerticalResizerProperty new exact: aHeight)
]

{ #category : #'*OnBloc' }
TBlElementProperties >> vFitContent [
	self addProperty: (BlElementLayoutVerticalResizerProperty new fitContent)
]

{ #category : #'*OnBloc' }
TBlElementProperties >> vFitContentLimited [
	self addProperty: (BlElementLayoutVerticalResizerProperty new fitContentLimited)
]

{ #category : #'*OnBloc' }
TBlElementProperties >> vMatchParent [
	self addProperty: (BlElementLayoutVerticalResizerProperty new matchParent)
]
