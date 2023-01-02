Extension { #name : #OBlInfiniteElement }

{ #category : #'*OnBloc-Sparta' }
OBlInfiniteElement >> drawChildrenOnSpartaCanvas: aCanvas [
	" draw then decorate eventually (between the background and the childrens)"
	super drawChildrenOnSpartaCanvas: aCanvas.
	self itemDecorationsDo: [ :d | 
		d drawOverOnSpartaCanvas: aCanvas in: self ]
]

{ #category : #'*OnBloc-Sparta' }
OBlInfiniteElement >> drawOnSpartaCanvas: aCanvas [
	" draw then decorate eventually (between the background and the childrens)"
	super drawOnSpartaCanvas: aCanvas.
	self itemDecorationsDo: [ :d | 
		d drawBeneathOnSpartaCanvas: aCanvas in: self ].

]
