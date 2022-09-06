"
I am a type of data source update command.
I suppose to be stateless and therefore immutable.
For performance and memory reasons I provide a unique instance of me to be shared among my users

"
Class {
	#name : #OBlInfiniteDataSourceCommandType,
	#superclass : #Object,
	#pools : [
		'BlInfiniteConstants'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'OnBloc-Infinite-DataSource-Support'
}

{ #category : #accessing }
OBlInfiniteDataSourceCommandType class >> cleanUp [
	super cleanUp.
	
	instance := nil
]

{ #category : #accessing }
OBlInfiniteDataSourceCommandType class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandType >> apply: aCommand in: anInfiniteElement [
	^ self subclassResponsibility
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandType >> apply: aCommand onPosition: aPosition [
	^ self subclassResponsibility
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandType >> continuous: aPosition start: start [
	^ self subclassResponsibility
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandType >> dispatch: aCommand toLayout: aLayout [
	^ self subclassResponsibility
]

{ #category : #accessing }
OBlInfiniteDataSourceCommandType >> elementHolderAt: aPosition in: anInfiniteElement [
	<return: #BlElement or: nil>

	^ anInfiniteElement findElementHolderForPosition: aPosition checkNew: true
]

{ #category : #testing }
OBlInfiniteDataSourceCommandType >> isAdd [
	^ false
]

{ #category : #testing }
OBlInfiniteDataSourceCommandType >> isMove [
	^ false
]

{ #category : #testing }
OBlInfiniteDataSourceCommandType >> isRemove [
	^ false
]

{ #category : #testing }
OBlInfiniteDataSourceCommandType >> isUpdate [
	^ false
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandType >> offsetPositions: aCommand in: anInfiniteElement [
	^ self subclassResponsibility
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandType >> positionMultiplier [
	^ self subclassResponsibility
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandType >> swapMoveOn: aContext in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex [
	^ self subclassResponsibility
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandType >> updateElementHoldersIn: anInfiniteElement command: aCommand [
	^ self subclassResponsibility
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandType >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [
	^ self subclassResponsibility
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandType >> updatePosition: aPosition with: aCommand from: myCommand [
	^ self subclassResponsibility
]
