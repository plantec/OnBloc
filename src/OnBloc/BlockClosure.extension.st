Extension { #name : #BlockClosure }

{ #category : #'*OnBloc' }
BlockClosure >> asStencil [
	<return: #BrStencil>

	^ OblValuableStencil from: self
]

{ #category : #'*OnBloc' }
BlockClosure >> asStencil: aStencilClass [
	^ aStencilClass new executor: (OblStencilValuableExecutor from: self)
]
