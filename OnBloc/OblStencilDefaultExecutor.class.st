Class {
	#name : #OblStencilDefaultExecutor,
	#superclass : #OblStencilExecutor,
	#instVars : [
		'stencil'
	],
	#category : #'OnBloc-Stencil'
}

{ #category : #'api - running' }
OblStencilDefaultExecutor >> execute [
	<return: #BlElement>

	^ self stencil buildDefault
]

{ #category : #'api - arguments' }
OblStencilDefaultExecutor >> push: anArgumentObject [
]

{ #category : #'api - arguments' }
OblStencilDefaultExecutor >> resetArguments [
]

{ #category : #accessing }
OblStencilDefaultExecutor >> stencil [
	^ stencil
]

{ #category : #accessing }
OblStencilDefaultExecutor >> stencil: anObject [
	stencil := anObject
]
