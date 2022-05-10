Class {
	#name : #OblStencilValuableExecutor,
	#superclass : #OblStencilExecutor,
	#instVars : [
		'valuable',
		'arguments'
	],
	#category : #'OnBloc-Stencil'
}

{ #category : #'instance creation' }
OblStencilValuableExecutor class >> from: aValuable [
	<return: #OblStencilValuableExecutor>

	^ self new valuable: aValuable
]

{ #category : #accessing }
OblStencilValuableExecutor >> arguments [
	<return: #Collection of: #Object>

	^ arguments
]

{ #category : #'api - running' }
OblStencilValuableExecutor >> execute [
	<return: #BlElement>

	^ self valuable glamourValueWithArgs: self arguments
]

{ #category : #initialization }
OblStencilValuableExecutor >> initialize [
	super initialize.
	
	arguments := LinkedList new
]

{ #category : #'api - arguments' }
OblStencilValuableExecutor >> push: anArgumentObject [
	arguments add: anArgumentObject
]

{ #category : #'api - arguments' }
OblStencilValuableExecutor >> resetArguments [
	arguments removeAll
]

{ #category : #printing }
OblStencilValuableExecutor >> storeOn: aStream [
	valuable isBlock
		ifTrue: [ aStream nextPutAll: valuable asString ]
		ifFalse: [ aStream nextPutAll: '[  ]' ]
]

{ #category : #accessing }
OblStencilValuableExecutor >> valuable [
	^ valuable
]

{ #category : #accessing }
OblStencilValuableExecutor >> valuable: anObject [
	valuable := anObject
]
