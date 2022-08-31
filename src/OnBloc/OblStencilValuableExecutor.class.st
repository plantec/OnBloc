Class {
	#name : #OBlStencilValuableExecutor,
	#superclass : #OBlStencilExecutor,
	#instVars : [
		'valuable',
		'arguments'
	],
	#category : #'OnBloc-Stencil'
}

{ #category : #'instance creation' }
OBlStencilValuableExecutor class >> from: aValuable [
	<return: #OBlStencilValuableExecutor>

	^ self new valuable: aValuable
]

{ #category : #accessing }
OBlStencilValuableExecutor >> arguments [
	<return: #Collection of: #Object>

	^ arguments
]

{ #category : #'api - running' }
OBlStencilValuableExecutor >> execute [
	<return: #BlElement>

	^ self valuable valueWithPossibleArgs: self arguments
]

{ #category : #initialization }
OBlStencilValuableExecutor >> initialize [
	super initialize.
	
	arguments := LinkedList new
]

{ #category : #'api - arguments' }
OBlStencilValuableExecutor >> push: anArgumentObject [
	arguments add: anArgumentObject
]

{ #category : #'api - arguments' }
OBlStencilValuableExecutor >> resetArguments [
	arguments removeAll
]

{ #category : #printing }
OBlStencilValuableExecutor >> storeOn: aStream [
	valuable isBlock
		ifTrue: [ aStream nextPutAll: valuable asString ]
		ifFalse: [ aStream nextPutAll: '[  ]' ]
]

{ #category : #accessing }
OBlStencilValuableExecutor >> valuable [
	^ valuable
]

{ #category : #accessing }
OBlStencilValuableExecutor >> valuable: anObject [
	valuable := anObject
]
