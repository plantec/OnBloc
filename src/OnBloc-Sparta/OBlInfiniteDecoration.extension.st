Extension { #name : #OBlInfiniteDecoration }

{ #category : #'*OnBloc-Sparta' }
OBlInfiniteDecoration >> draw: anItemElement beneathOnSpartaCanvas: aSpartaCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element for its child element anItemElement. Any content drawn by this method will be drawn before the item elements are drawn, and will thus appear underneath them"

	
]

{ #category : #'*OnBloc-Sparta' }
OBlInfiniteDecoration >> draw: anItemElement overOnSpartaCanvas: aSpartaCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element for its child element anItemElement. Any content drawn by this method will be drawn after the item elements are drawn, and will thus appear over them"

	
]

{ #category : #'*OnBloc-Sparta' }
OBlInfiniteDecoration >> drawBeneathOnSpartaCanvas: aSpartaCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element. Any content drawn by this method will be drawn before the item elements are drawn, and will thus appear underneath them"

	anInfiniteElement children sortedByElevation do: [ :child | 
		self draw: child beneathOnSpartaCanvas: aSpartaCanvas in: anInfiniteElement ].

]

{ #category : #'*OnBloc-Sparta' }
OBlInfiniteDecoration >> drawOverOnSpartaCanvas: aSpartaCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element. Any content drawn by this method will be drawn after the item elements are drawn, and will thus appear over them"
	anInfiniteElement children sortedByElevation do: [ :child | 
		self draw: child overOnSpartaCanvas: aSpartaCanvas in: anInfiniteElement ].

]
