Class {
	#name : #OBlStencilExecutor,
	#superclass : #Object,
	#category : #'OnBloc-Stencil'
}

{ #category : #'api - running' }
OBlStencilExecutor >> execute [
	<return: #BlElement>

	self subclassResponsibility
]

{ #category : #'api - arguments' }
OBlStencilExecutor >> push: anArgumentObject [
	self subclassResponsibility
]

{ #category : #'api - arguments' }
OBlStencilExecutor >> resetArguments [
	self subclassResponsibility
]
