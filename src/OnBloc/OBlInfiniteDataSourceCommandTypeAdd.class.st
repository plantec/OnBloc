"
I represent a concrete ""add"" command type

"
Class {
	#name : #OBlInfiniteDataSourceCommandTypeAdd,
	#superclass : #OBlInfiniteDataSourceCommandType,
	#category : #'OnBloc-Infinite-DataSource-Support'
}

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeAdd >> apply: aCommand in: anInfiniteElement [
	anInfiniteElement dataSourceManager postponeAndUpdateElementHolders: aCommand on: anInfiniteElement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeAdd >> apply: aCommand onPosition: aPosition [
	|newPosition|
	
	newPosition := aCommand positionStart <= aPosition
		ifTrue: [ aPosition + aCommand itemCount ]
		ifFalse: [ aPosition ].

	^ newPosition
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeAdd >> continuous: aPosition start: start [
	self shouldNotImplement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeAdd >> dispatch: aCommand toLayout: aLayout [
	aLayout onItemsAddedAt: aCommand positionStart count: aCommand itemCount
]

{ #category : #testing }
OBlInfiniteDataSourceCommandTypeAdd >> isAdd [
	^ true
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeAdd >> offsetPositions: aCommand in: anInfiniteElement [

	anInfiniteElement dataSourceManager
		offsetPositions: aCommand positionStart
		forAdd: aCommand itemCount
		in: anInfiniteElement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeAdd >> positionMultiplier [
	self shouldNotImplement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeAdd >> swapMoveOn: aContext in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex [
	aContext swapMoveAddIn: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeAdd >> updateElementHoldersIn: anInfiniteElement command: aCommand [

	anInfiniteElement dataSourceManager
		offsetPositions: aCommand positionStart
		forAdd: aCommand itemCount
		in: anInfiniteElement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeAdd >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [
	self shouldNotImplement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeAdd >> updatePosition: aPosition with: aCommand from: myCommand [
	| pos |
	pos := aPosition.
	
	myCommand positionStart <= pos
		ifTrue: [ pos := pos - myCommand itemCount ]
		ifFalse: [ myCommand positionStart: myCommand positionStart + 1 ].

	^ pos
]
