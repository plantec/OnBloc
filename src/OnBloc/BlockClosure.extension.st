Extension { #name : #BlockClosure }

{ #category : #'*OnBloc' }
BlockClosure >> asStencil [
	<return: #BrStencil>

	^ OBlValuableStencil from: self
]

{ #category : #'*OnBloc' }
BlockClosure >> asStencil: aStencilClass [
	^ aStencilClass new executor: (OBlStencilValuableExecutor from: self)
]
