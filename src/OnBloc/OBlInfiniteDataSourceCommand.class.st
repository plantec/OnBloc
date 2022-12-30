"
I represent a data source update command.

There are 4 times of commands: add, move, remove and update.

Add command describes insertion of one or multiple items in data source.
Move command describes a position change of existing item in data source.
Remove command describes deletion of one or multiple items from data source.
Update command describes content or value change of one or multiple items in data source.

"
Class {
	#name : #OBlInfiniteDataSourceCommand,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'positionStart',
		'itemCount',
		'type'
	],
	#category : #'OnBloc-Infinite-DataSource-Support'
}

{ #category : #commands }
OBlInfiniteDataSourceCommand >> applyIn: anInfiniteElement [
	type apply: self in: anInfiniteElement
]

{ #category : #commands }
OBlInfiniteDataSourceCommand >> applyOnPosition: aPosition [
	^ type apply: self onPosition: aPosition
]

{ #category : #factory }
OBlInfiniteDataSourceCommand >> beAdd [
	self type: OBlInfiniteDataSourceCommandTypeAdd instance
]

{ #category : #factory }
OBlInfiniteDataSourceCommand >> beMove [
	self type: OBlInfiniteDataSourceCommandTypeMove instance
]

{ #category : #factory }
OBlInfiniteDataSourceCommand >> beRemove [
	self type: OBlInfiniteDataSourceCommandTypeRemove instance
]

{ #category : #factory }
OBlInfiniteDataSourceCommand >> beUpdate [
	self type: OBlInfiniteDataSourceCommandTypeUpdate instance
]

{ #category : #commands }
OBlInfiniteDataSourceCommand >> continuous: aPosition start: start [
	^ type continuous: aPosition start: start
]

{ #category : #commands }
OBlInfiniteDataSourceCommand >> dispatchToLayout: aLayout [
	type dispatch: self toLayout: aLayout
]

{ #category : #initialization }
OBlInfiniteDataSourceCommand >> initialize [
	super initialize.
	
	type := OBlInfiniteDataSourceCommandTypeNull instance
]

{ #category : #testing }
OBlInfiniteDataSourceCommand >> isAdd [
	^ type isAdd
]

{ #category : #testing }
OBlInfiniteDataSourceCommand >> isMove [
	^ type isMove
]

{ #category : #testing }
OBlInfiniteDataSourceCommand >> isRemove [
	^ type isRemove
]

{ #category : #testing }
OBlInfiniteDataSourceCommand >> isUpdate [
	^ type isUpdate
]

{ #category : #accessing }
OBlInfiniteDataSourceCommand >> itemCount [
	^ itemCount
]

{ #category : #accessing }
OBlInfiniteDataSourceCommand >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #commands }
OBlInfiniteDataSourceCommand >> offsetPositionsIn: anInfiniteElement [
	type offsetPositions: self in: anInfiniteElement
]

{ #category : #commands }
OBlInfiniteDataSourceCommand >> positionMultiplier [
	^ type positionMultiplier
]

{ #category : #accessing }
OBlInfiniteDataSourceCommand >> positionStart [
	^ positionStart
]

{ #category : #accessing }
OBlInfiniteDataSourceCommand >> positionStart: anObject [
	positionStart := anObject
]

{ #category : #accessing }
OBlInfiniteDataSourceCommand >> type [
	<return: #BlInfiniteDataSourceCommandType>

	^ type
]

{ #category : #accessing }
OBlInfiniteDataSourceCommand >> type: aType [

	type := aType
]

{ #category : #enum }
OBlInfiniteDataSourceCommand >> typeInvisible [
	^ 0
]

{ #category : #enum }
OBlInfiniteDataSourceCommand >> typeNewOrLaidOut [
	^ 1
]

{ #category : #commands }
OBlInfiniteDataSourceCommand >> updateElementHoldersIn: anInfiniteElement [
	^ type updateElementHoldersIn: anInfiniteElement command: self
]

{ #category : #commands }
OBlInfiniteDataSourceCommand >> updateElementHoldersIn: anInfiniteElement offset: offsetStart [
	type updateElementHoldersIn: anInfiniteElement offset: offsetStart command: self
]

{ #category : #commands }
OBlInfiniteDataSourceCommand >> updatePosition: aPosition with: aCommand [
	^ type updatePosition: aPosition with: aCommand from: self
]
