Class {
	#name : #OBlInfiniteDataSourceCommandTypeUpdate,
	#superclass : #OBlInfiniteDataSourceCommandType,
	#category : #'OnBloc-Infinite-DataSource-Support'
}

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeUpdate >> apply: aCommand in: anInfiniteElement [
	| command tmpStart tmpCount tmpEnd type position manager |
	command := aCommand.
	tmpStart := command positionStart.
	tmpCount := 0.
	tmpEnd := command positionStart + command itemCount.
	type := -1.
	manager := anInfiniteElement dataSourceManager.

	position := command positionStart.
	[ position < tmpEnd ]  whileTrue: [
		| holder |
		holder := holder := self elementHolderAt: position in: anInfiniteElement.
		
		(holder isNotNil or: [ anInfiniteElement dataSourceManager canFindInPreLayout: position  ])
			ifTrue: [ 
				type = command typeInvisible ifTrue: [ 
					self dispatchOn: anInfiniteElement start: tmpStart count: tmpCount payload: command payload.
					tmpCount := 0.
					tmpStart := position ].
				type := command typeNewOrLaidOut ]
			ifFalse: [ 
				type = command typeNewOrLaidOut ifTrue: [ 
					self postponeOn: anInfiniteElement start: tmpStart count: tmpCount payload: command payload.
					tmpCount := 0.
					tmpStart := position ].
				type := command typeInvisible ].

		tmpCount := tmpCount + 1.
		position := position + 1 ].
	
	(tmpCount ~= command itemCount) ifTrue: [ 
		|aPayload|
		aPayload := command payload.
		manager recycleCommand: command.
		command := manager createCommand: self
			positionStart: tmpStart
			itemCount: tmpCount
			payload: aPayload ].

	type = command typeInvisible
		ifTrue: [ manager dispatchAndUpdateElementHolders: command on: anInfiniteElement ]
		ifFalse: [ manager postponeAndUpdateElementHolders: command on: anInfiniteElement ]
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeUpdate >> apply: aCommand onPosition: aPosition [
	^ aPosition
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeUpdate >> continuous: aPosition start: start [
	^ aPosition = (start + 1)
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeUpdate >> dispatch: aCommand toLayout: aLayout [
	aLayout onItemsUpdatedAt: aCommand positionStart count: aCommand itemCount payload: aCommand payload
]

{ #category : #private }
OBlInfiniteDataSourceCommandTypeUpdate >> dispatchOn: anInfiniteElement start: aStartPosition count: anItemCount payload: anObject [
	| newCommand manager |
	manager := anInfiniteElement dataSourceManager.
	newCommand := manager createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount
		payload: anObject.
	manager dispatchAndUpdateElementHolders: newCommand on: anInfiniteElement.
]

{ #category : #testing }
OBlInfiniteDataSourceCommandTypeUpdate >> isUpdate [
	^ true
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeUpdate >> offsetPositions: aCommand in: anInfiniteElement [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: aCommand positionStart
		itemCount: aCommand itemCount
		payload: aCommand payload
		in: anInfiniteElement

]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeUpdate >> positionMultiplier [
	^ 1
]

{ #category : #private }
OBlInfiniteDataSourceCommandTypeUpdate >> postponeOn: aContext start: aStartPosition count: anItemCount payload: anObject [
	|newCommand|
	newCommand := aContext dataSourceManager createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount
		payload: anObject.
	aContext dataSourceManager postponeAndUpdateElementHolders: newCommand on: aContext
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeUpdate >> updateElementHoldersIn: anInfiniteElement command: aCommand [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: aCommand positionStart
		itemCount: aCommand itemCount
		payload: aCommand payload
		in: anInfiniteElement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeUpdate >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: offsetStart
		itemCount: aCommand itemCount
		payload: aCommand payload
		in: anInfiniteElement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeUpdate >> updatePosition: aPosition with: aCommand from: myCommand [
	^ aPosition
]
