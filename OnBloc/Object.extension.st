Extension { #name : #Object }

{ #category : #'*OnBloc' }
Object >> asStencilBuilder: aStencilBuilderClass [
	^ aStencilBuilderClass new executor: (OblStencilValuableExecutor from: self)
]
