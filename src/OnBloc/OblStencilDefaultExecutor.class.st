Class {
	#name : #OBlStencilDefaultExecutor,
	#superclass : #OBlStencilExecutor,
	#instVars : [
		'stencil'
	],
	#category : #'OnBloc-Stencil'
}

{ #category : #'api - running' }
OBlStencilDefaultExecutor >> execute [
	<return: #BlElement>

	^ self stencil buildDefault
]

{ #category : #'api - arguments' }
OBlStencilDefaultExecutor >> push: anArgumentObject [
]

{ #category : #'api - arguments' }
OBlStencilDefaultExecutor >> resetArguments [
]

{ #category : #accessing }
OBlStencilDefaultExecutor >> stencil [
	^ stencil
]

{ #category : #accessing }
OBlStencilDefaultExecutor >> stencil: anObject [
	stencil := anObject
]
