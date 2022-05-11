Class {
	#name : #OblStencilBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'executor'
	],
	#category : #'OnBloc-Stencil'
}

{ #category : #'api - converting' }
OblStencilBuilder >> asElement [
	"Build a corresponding stencil and ask it to create and return a new element"
	<return: #BlElement>
	
	^ self build asElement
]

{ #category : #'api - converting' }
OblStencilBuilder >> asStencilBuilder [
	<return: #OblStencilBuilder>

	^ self
]

{ #category : #'api - converting' }
OblStencilBuilder >> asStencilBuilder: aStencilBuilderClass [
	<return: #OblStencilBuilder>

	^ self
]

{ #category : #building }
OblStencilBuilder >> build [
	<return: #OblStencil>
	| anExecutor aResult |
	
	anExecutor := executor.
	anExecutor resetArguments.
	self paramsOn: anExecutor.
	aResult := anExecutor execute.
	
	anExecutor resetArguments.
	self reset.
	^ aResult
]

{ #category : #'api - instantiation' }
OblStencilBuilder >> buildDefault [
	<return: #OblStencil or: #BlElement>

	^ self subclassResponsibility
]

{ #category : #accessing }
OblStencilBuilder >> executor: aBrStencilExecutor [
	self
		assert: [ aBrStencilExecutor isNotNil ]
		description: [ 'Executor must not be nil' ].
	
	executor := aBrStencilExecutor
]

{ #category : #initialization }
OblStencilBuilder >> initialize [
	super initialize.
	
	executor := OblStencilDefaultExecutor new stencil: self
]

{ #category : #'api - instantiation' }
OblStencilBuilder >> paramsOn: aStencilExecutor [
]

{ #category : #initialization }
OblStencilBuilder >> reset [
	"Is called after the #build to de-reference dynamic parameters passed
	by the called of the build"
]

{ #category : #printing }
OblStencilBuilder >> storeOn: aStream [
	aStream store: executor.
	aStream space.
	aStream nextPutAll: #asStencilBuilder: asString.
	aStream space.
	aStream nextPutAll: self class name.
]
