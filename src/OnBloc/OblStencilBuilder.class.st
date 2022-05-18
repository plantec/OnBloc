Class {
	#name : #OBlStencilBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'executor'
	],
	#category : #'OnBloc-Stencil'
}

{ #category : #'api - converting' }
OBlStencilBuilder >> asElement [
	"Build a corresponding stencil and ask it to create and return a new element"
	<return: #BlElement>
	
	^ self build asElement
]

{ #category : #'api - converting' }
OBlStencilBuilder >> asStencilBuilder [
	<return: #OBlStencilBuilder>

	^ self
]

{ #category : #'api - converting' }
OBlStencilBuilder >> asStencilBuilder: aStencilBuilderClass [
	<return: #OBlStencilBuilder>

	^ self
]

{ #category : #building }
OBlStencilBuilder >> build [
	<return: #OBlStencil>
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
OBlStencilBuilder >> buildDefault [
	<return: #OBlStencil or: #BlElement>

	^ self subclassResponsibility
]

{ #category : #accessing }
OBlStencilBuilder >> executor: aBrStencilExecutor [
	self
		assert: [ aBrStencilExecutor isNotNil ]
		description: [ 'Executor must not be nil' ].
	
	executor := aBrStencilExecutor
]

{ #category : #initialization }
OBlStencilBuilder >> initialize [
	super initialize.
	
	executor := OBlStencilDefaultExecutor new stencil: self
]

{ #category : #'api - instantiation' }
OBlStencilBuilder >> paramsOn: aStencilExecutor [
]

{ #category : #initialization }
OBlStencilBuilder >> reset [
	"Is called after the #build to de-reference dynamic parameters passed
	by the called of the build"
]

{ #category : #printing }
OBlStencilBuilder >> storeOn: aStream [
	aStream store: executor.
	aStream space.
	aStream nextPutAll: #asStencilBuilder: asString.
	aStream space.
	aStream nextPutAll: self class name.
]
