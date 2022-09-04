Class {
	#name : #OBlInfiniteDataSourceManager,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'pendingCommands',
		'postponedCommands',
		'controller',
		'shouldRecycle',
		'commandsPool',
		'commandsReorderer',
		'existingCommandTypes'
	],
	#category : #'OnBloc-Infinite-DataSource-Support'
}

{ #category : #'element -> manager' }
OBlInfiniteDataSourceManager >> applyPendingCommandsOnPosition: aPosition [
	"Virually perform every pending command to determine how provided
	position will change.
	Return new position if all commands would be actually performed"
	<return: #Number>
	| position |

	position := aPosition.
	
	pendingCommands do: [ :command |
		position := command applyOnPosition: position ].
	
	^ position
]

{ #category : #helper }
OBlInfiniteDataSourceManager >> canFindInPreLayout: aPosition [

	postponedCommands withIndexDo: [ :command :index | 
		command isMove
			ifTrue: [ 
				(self computePositionOffset: command itemCount firstPostponedItem: index + 1) = aPosition
					ifTrue: [ ^ true ] ]
			ifFalse: [ command isAdd
				ifTrue: [ 
					| end |
					end := command positionStart + command itemCount.
					command positionStart to: end - 1 do: [ :pos |
						(self computePositionOffset: pos firstPostponedItem: index + 1) = aPosition
							ifTrue: [ ^ true ] ] ] ] ].
	^ false
]

{ #category : #helper }
OBlInfiniteDataSourceManager >> computePositionOffset: aPosition [

	^ self computePositionOffset: aPosition firstPostponedItem: 1
]

{ #category : #helper }
OBlInfiniteDataSourceManager >> computePositionOffset: aPosition firstPostponedItem: firstPostponedItem [
	|position|
	position := aPosition.
	
	firstPostponedItem to: postponedCommands size - 1 do: [ :index |
		| command |
		command := postponedCommands at: index.
		command isMove
			ifTrue: [ command positionStart = position
				ifTrue: [ position := command itemCount ]
				ifFalse: [ 
					command positionStart < position
						ifTrue: [ position := position - 1 ].
					command itemCount <= position
						ifTrue: [ position := position + 1 ] ] ]
			ifFalse: [
				command positionStart <= position ifTrue: [
					command isRemove
						ifTrue: [ 
							position < (command positionStart + command itemCount)
								ifTrue: [ ^ 0 ].
							position := position - command itemCount ]
						ifFalse: [
							command isAdd
								ifTrue: [ position := position + command itemCount ] ] ] ] ].
	^ position
]

{ #category : #'element -> manager' }
OBlInfiniteDataSourceManager >> consumeCommandsInOnePass [
	"Skip pre-processing and perform all pending commands in one pass."

	"we still consume postponed updates (if there is) in case there was a pre-process call
	w/o a matching consumePostponedUpdates."
		
	self consumePostponedCommands.

	pendingCommands do: [ :command |
		self controller onDispatchSecondPass: command.
		command offsetPositionsOn: self controller.
		self onCommandProcessed: command ].

	self recycleCommandsAndClearList: pendingCommands.
	existingCommandTypes clear
]

{ #category : #'commands processing' }
OBlInfiniteDataSourceManager >> consumePostponedCommands [
	
	postponedCommands do: [ :command |
		self controller onDispatchSecondPass: command ].

	self recycleCommandsAndClearList: postponedCommands.
	existingCommandTypes clear
]

{ #category : #accessing }
OBlInfiniteDataSourceManager >> controller [
	<return: #BlInfiniteAbstractDataSourceController>
	self assert: controller isNotNil.

	^ controller
]

{ #category : #accessing }
OBlInfiniteDataSourceManager >> controller: aController [
	controller := aController
]

{ #category : #'commands recycling' }
OBlInfiniteDataSourceManager >> createCommand: type positionStart: positionStart itemCount: itemCount payload: payload [
	"Return a data source command with specified parameters.
	As performance optimisation I use commands pool to reduce amount
	of created objects and reduce garbage collector's work.
	I am also used by BlInfiniteDataSourceCommandsReorderer when it merges multiple commands in one"
	<return: #BlInfiniteDataSourceCommand>
	| command |
	
	command := commandsPool acquire.
	command
		ifNil: [ command := BlInfiniteDataSourceCommand new
			type: type;
			positionStart: positionStart;
			itemCount: itemCount;
			payload: payload ]
		ifNotNil: [ 
			command
				type: type;
				positionStart: positionStart;
				itemCount: itemCount;
				payload: payload ].
	^ command
]

{ #category : #initialization }
OBlInfiniteDataSourceManager >> defaultCommandsPool [
	^ BlInfiniteSimplePool new: self defaultPoolSize.
]

{ #category : #initialization }
OBlInfiniteDataSourceManager >> defaultCommandsReorderer [
	^ BlInfiniteDataSourceCommandsReorderer new
]

{ #category : #initialization }
OBlInfiniteDataSourceManager >> defaultPoolSize [
	^ 30
]

{ #category : #initialization }
OBlInfiniteDataSourceManager >> defaultShouldRecycle [
	^ true
]

{ #category : #private }
OBlInfiniteDataSourceManager >> dispatchAndUpdateElementHolders: aCommand [
	| tmpStart tmpCnt offsetPositionForPartial positionMultiplier payload|
	tmpStart := self updatePosition: aCommand positionStart withPostponed: aCommand.
	tmpCnt := 1.
	offsetPositionForPartial := aCommand positionStart.
	positionMultiplier := aCommand positionMultiplier.
	
	1 to: aCommand itemCount - 1 do: [ :p |
		| pos updatedPos |
		pos := aCommand positionStart + (positionMultiplier * p).
		updatedPos := self updatePosition: pos withPostponed: aCommand.
		(aCommand continuous: updatedPos start: tmpStart)
			ifTrue: [ tmpCnt := tmpCnt + 1 ]
			ifFalse: [ 
				| tmpCommand |
				tmpCommand := aCommand class new
					positionStart: tmpStart;
					itemCount: tmpCnt;
					payload: aCommand payload.
				
				self dispatchFirstPassAndUpdateElementHolders: tmpCommand offset: offsetPositionForPartial.
				self recycleCommand: tmpCommand.
				
				aCommand isUpdate ifTrue: [ 
					offsetPositionForPartial := offsetPositionForPartial + tmpCnt ].
				tmpStart := updatedPos.
				tmpCnt := 1 ] ].

	payload := aCommand payload.
	self recycleCommand: aCommand.
	
	tmpCnt > 0 ifTrue: [ 
		|tmpCommand|
		tmpCommand := aCommand class new
			positionStart: tmpStart;
			itemCount: tmpCnt;
			payload: payload.
		self dispatchFirstPassAndUpdateElementHolders: tmpCommand offset: offsetPositionForPartial.
		self recycleCommand: tmpCommand ].
]

{ #category : #helper }
OBlInfiniteDataSourceManager >> dispatchFirstPassAndUpdateElementHolders: aCommand offset: offsetStart [

	self controller onDispatchFirstPass: aCommand.
	aCommand updateElementHoldersOn: self offset: offsetStart
]

{ #category : #'testing - commands' }
OBlInfiniteDataSourceManager >> hasAddCommand [
	"Return true if there are any add commands in the queue, false otherwise"
	<return: #Boolean>

	^ existingCommandTypes hasAdd
]

{ #category : #'testing - commands' }
OBlInfiniteDataSourceManager >> hasCommands [
	"Return true if there are both pending and postponed commands,
	otherwise false"
	<return: #Boolean>

	^ self hasPendingCommands and: [ self hasPostponedCommands ]
]

{ #category : #'testing - commands' }
OBlInfiniteDataSourceManager >> hasMoveCommand [
	"Return true if there are any move commands in the queue, false otherwise"
	<return: #Boolean>

	^ existingCommandTypes hasMove
]

{ #category : #'testing - commands' }
OBlInfiniteDataSourceManager >> hasOnlyUpdateCommand [
	"Return true if there are only update commands in the queue, false otherwise"
	<return: #Boolean>

	^ self hasUpdateCommand and: [
		(self hasAddCommand or: [
			self hasRemoveCommand or: [ 
				self hasMoveCommand ] ]) not ]
]

{ #category : #'testing - commands' }
OBlInfiniteDataSourceManager >> hasPendingCommands [
	"Return true if there are pending commands,
	false otherwise"
	<return: #Boolean>

	^ pendingCommands isNotEmpty
]

{ #category : #'testing - commands' }
OBlInfiniteDataSourceManager >> hasPostponedCommands [
	"Return true if there are postponed commands,
	false otherwise"
	<return: #Boolean>

	^ postponedCommands isNotEmpty
]

{ #category : #'testing - commands' }
OBlInfiniteDataSourceManager >> hasRemoveCommand [
	"Return true if there are any remove commands in the queue, false otherwise"
	<return: #Boolean>

	^ existingCommandTypes hasRemove
]

{ #category : #'testing - commands' }
OBlInfiniteDataSourceManager >> hasUpdateCommand [
	"Return true if there are any update commands in the queue, false otherwise"
	<return: #Boolean>

	^ existingCommandTypes hasUpdate
]

{ #category : #initialization }
OBlInfiniteDataSourceManager >> initialize [
	super initialize.
	
	postponedCommands := OrderedCollection new.
	pendingCommands := OrderedCollection new.
	commandsPool := self defaultCommandsPool.
	shouldRecycle := self defaultShouldRecycle.
	commandsReorderer := self defaultCommandsReorderer dataSourceManager: self.
	existingCommandTypes := BlInfiniteDataSourceCommandTypeFlags new
]

{ #category : #'commands processing' }
OBlInfiniteDataSourceManager >> onCommandProcessed: aCommand [
]

{ #category : #'data source updates' }
OBlInfiniteDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount payload: anObjectPayload [
	"Enques a new update pending command.
	I am a part of public API and should be triggered by data source (directly or indirectly)
	when items are changed/updated (item's value, content, or value was replaced in-place).
	Return true if pending commands need to be processed, otherwise false.
	object payload is optional and may be nil"
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register update command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeUpdate instance
		positionStart: aPositionStart
		itemCount: anItemCount
		payload: anObjectPayload).
	existingCommandTypes addUpdate.

	^ pendingCommands size = 1
]

{ #category : #'data source updates' }
OBlInfiniteDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register add command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeAdd instance
		positionStart: aPositionStart
		itemCount: anItemCount
		payload: nil).
	existingCommandTypes addAdd.

	^ pendingCommands size = 1
]

{ #category : #'data source updates' }
OBlInfiniteDataSourceManager >> onItemRangeMoved: aPositionStart to: aPositionEnd itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If start and end position are the same, nothing needs to be done"
	aPositionStart = aPositionEnd
		ifTrue: [ ^ false ].
		
	anItemCount > 1
		ifTrue: [ self error: 'Moving multiple items is not supported yet' ].

	"Register move command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeMove instance
		positionStart: aPositionStart
		itemCount: aPositionEnd
		payload: nil).
	existingCommandTypes addMove.

	^ pendingCommands size = 1
]

{ #category : #'data source updates' }
OBlInfiniteDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register remove command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeRemove instance
		positionStart: aPositionStart
		itemCount: anItemCount
		payload: nil).
	existingCommandTypes addRemove.

	^ pendingCommands size = 1
]

{ #category : #private }
OBlInfiniteDataSourceManager >> postponeAndUpdateElementHolders: aCommand [
	
	postponedCommands add: aCommand.
	aCommand updateElementHoldersOn: self
]

{ #category : #'commands processing' }
OBlInfiniteDataSourceManager >> preProcessCommands [

	commandsReorderer reorderCommands: pendingCommands.
	pendingCommands do: [ :command |
		command applyOn: self.
		self onCommandProcessed: command ].
	pendingCommands removeAll
]

{ #category : #'commands recycling' }
OBlInfiniteDataSourceManager >> recycleCommand: aCommand [
	"Recycle aCommand removing any payload and if recycling enabled
	put in commands pool to allow manager to reuse objects for 
	performance reasons.
	I am also used by BlInfiniteDataSourceCommandsReorderer when it merges multiple commands in one
	aCommand must not be nil"
	self assert: aCommand isNotNil.

	shouldRecycle
		ifFalse: [ ^ self ].

	aCommand payload: nil.
	commandsPool release: aCommand
]

{ #category : #'commands recycling' }
OBlInfiniteDataSourceManager >> recycleCommandsAndClearList: aCollectionOfCommands [
	"Recycle and remove all commands from aCollectionOfCommands.
	aCollectionOfCommands must not be nil"
	self assert: aCollectionOfCommands isNotNil.
	
	aCollectionOfCommands do: [ :command |
		self recycleCommand: command ].

	aCollectionOfCommands removeAll
]

{ #category : #invalidate }
OBlInfiniteDataSourceManager >> resetCommands [
	
	self recycleCommandsAndClearList: pendingCommands.
	self recycleCommandsAndClearList: postponedCommands.
	existingCommandTypes clear
]

{ #category : #private }
OBlInfiniteDataSourceManager >> updatePosition: aPosition withPostponed: aCommand [
	|pos|
	pos := aPosition.
	
	postponedCommands do: [ :postponed |
		pos := postponed updatePosition: pos with: aCommand ].
	
	postponedCommands copy reverseWithIndexDo: [ :postponed :i | 
		postponed isMove
			ifTrue: [ 
				(postponed itemCount = postponed positionStart
					or: [ postponed itemCount < 0 ])
						ifTrue: [ 
							postponedCommands removeAt: i.
							self recycleCommand: postponed ] ]
			ifFalse: [ 
				postponed itemCount <= 0
					ifTrue: [ 
						postponedCommands removeAt: i.
						self recycleCommand: postponed ] ] ].
	^ pos
]
