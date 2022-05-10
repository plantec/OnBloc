Class {
	#name : #OblStencilExecutor,
	#superclass : #Object,
	#category : #'OnBloc-Stencil'
}

{ #category : #'api - running' }
OblStencilExecutor >> execute [
	<return: #BlElement>

	self subclassResponsibility
]

{ #category : #'api - arguments' }
OblStencilExecutor >> push: anArgumentObject [
	self subclassResponsibility
]

{ #category : #'api - arguments' }
OblStencilExecutor >> resetArguments [
	self subclassResponsibility
]
