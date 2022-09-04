Class {
	#name : #OBlInfiniteDefaultDataSourceController,
	#superclass : #OBlInfiniteAbstractDataSourceController,
	#instVars : [
		'dataSourceManager',
		'infiniteElement'
	],
	#category : #'OnBloc-Infinite-DataSource-Support'
}

{ #category : #'element -> manager' }
OBlInfiniteDefaultDataSourceController >> applyPendingCommandsOnPosition: aPosition [
	^ self dataSourceManager applyPendingCommandsOnPosition: aPosition
]

{ #category : #'element -> manager' }
OBlInfiniteDefaultDataSourceController >> computePositionOffset: aPosition [
	^ self dataSourceManager computePositionOffset: aPosition
]

{ #category : #'element -> manager' }
OBlInfiniteDefaultDataSourceController >> consumeCommandsInOnePass [
	^ self dataSourceManager consumeCommandsInOnePass
]

{ #category : #'element -> manager' }
OBlInfiniteDefaultDataSourceController >> consumePostponedCommands [
	self dataSourceManager consumePostponedCommands
]

{ #category : #private }
OBlInfiniteDefaultDataSourceController >> createAddCommand: startPosition itemCount: itemCount [

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeAdd instance
		positionStart: startPosition
		itemCount: itemCount
		payload: nil
]

{ #category : #private }
OBlInfiniteDefaultDataSourceController >> createMoveCommand: fromPosition itemCount: toPosition [

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeMove instance
		positionStart: fromPosition
		itemCount: toPosition
		payload: nil
]

{ #category : #private }
OBlInfiniteDefaultDataSourceController >> createRemoveCommand: startPosition itemCount: itemCount [

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeRemove instance
		positionStart: startPosition
		itemCount: itemCount
		payload: nil
]

{ #category : #private }
OBlInfiniteDefaultDataSourceController >> createUpdateCommand: startPosition itemCount: itemCount payload: anObject [

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeUpdate instance
		positionStart: startPosition
		itemCount: itemCount
		payload: anObject
]

{ #category : #accessing }
OBlInfiniteDefaultDataSourceController >> dataSourceManager [
	"Return data source manager used in communication with infinite element.
	dataSourceManager can not be nil"
	<return: #OBlInfiniteDataSourceManager>
	self assert: dataSourceManager isNotNil.
	
	^ dataSourceManager
]

{ #category : #accessing }
OBlInfiniteDefaultDataSourceController >> dataSourceManager: aDataSourceManager [
	dataSourceManager := aDataSourceManager.
	dataSourceManager controller: self
]

{ #category : #private }
OBlInfiniteDefaultDataSourceController >> dispatchCommand: aCommand [
	"Dispatche data source update command to all interested objects,
	in this case to infinite element's layout.
	aCommand must not be nil"
	
	aCommand dispatchToLayout: self element layout
]

{ #category : #accessing }
OBlInfiniteDefaultDataSourceController >> element [
	"Return infinite element used in communication with data source manager.
	element can not be nil"
	<return: #BlInfiniteElement>
	self assert: infiniteElement isNotNil.
	
	^ infiniteElement
]

{ #category : #accessing }
OBlInfiniteDefaultDataSourceController >> element: anInfiniteElement [
	infiniteElement := anInfiniteElement
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultDataSourceController >> elementHolderAt: aPosition [
	<return: #BlElement or: nil>

	^ (infiniteElement findElementHolderForPosition: aPosition checkNew: true)
		ifNotNil: [ :anElementHolder |
			"ensure it is not hidden because for datasource manager,
			the only thing matter is that layout thinks element is a child"
			(infiniteElement childrenManager isHidden: anElementHolder itemElement)
				ifTrue: [ nil ]
				ifFalse: [ anElementHolder ] ]
]

{ #category : #'element -> manager' }
OBlInfiniteDefaultDataSourceController >> hasCommands [
	^ self dataSourceManager hasCommands
]

{ #category : #'element -> manager' }
OBlInfiniteDefaultDataSourceController >> hasPendingCommands [
	^ self dataSourceManager hasPendingCommands
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultDataSourceController >> markElementHoldersUpdated: aPositionStart itemCount: anItemCount payload: aPayloadObject [

	infiniteElement
		elementRangeUpdate: aPositionStart
		itemCount: anItemCount
		payload: aPayloadObject.
		
	infiniteElement markItemsChanged
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultDataSourceController >> offsetPositions: aStartPosition forAdd: anItemCount [
	
	infiniteElement
		offsetPositionRecordsForInsert: aStartPosition
		itemCount: anItemCount.
		
	infiniteElement markItemsAddedOrRemoved
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultDataSourceController >> offsetPositions: aStartPosition forRemovingInvisible: anItemCount [
	| newDeletedCount |

	infiniteElement
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: true.
	
	infiniteElement markItemsAddedOrRemoved.

	newDeletedCount := infiniteElement state deletedInvisibleItemCountSincePreviousLayout + anItemCount.
	infiniteElement state deletedInvisibleItemCountSincePreviousLayout: newDeletedCount
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultDataSourceController >> offsetPositions: aStartPosition forRemovingLaidOutOrNewElement: anItemCount [

	infiniteElement
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: true.
	
	infiniteElement markItemsAddedOrRemoved
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultDataSourceController >> offsetPositionsForMove: aFromPosition to: aToPosition [

	infiniteElement
		offsetPositionRecordsForMove: aFromPosition
		to: aToPosition.

	infiniteElement markItemsAddedOrRemoved
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultDataSourceController >> onDispatchFirstPass: aCommand [
	self dispatchCommand: aCommand
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultDataSourceController >> onDispatchSecondPass: aCommand [
	self dispatchCommand: aCommand
]

{ #category : #'element -> manager' }
OBlInfiniteDefaultDataSourceController >> onItemRangeChanged: aStartPosition itemCount: anItemCount payload: aPayloadObject [
	^ self dataSourceManager onItemRangeChanged: aStartPosition itemCount: anItemCount payload: aPayloadObject
]

{ #category : #'element -> manager' }
OBlInfiniteDefaultDataSourceController >> onItemRangeInserted: startPosition itemCount: anItemCount [
	^ self dataSourceManager onItemRangeInserted: startPosition itemCount: anItemCount
]

{ #category : #'element -> manager' }
OBlInfiniteDefaultDataSourceController >> preProcessCommands [
	self dataSourceManager preProcessCommands
]

{ #category : #'element -> manager' }
OBlInfiniteDefaultDataSourceController >> resetCommands [
	self dataSourceManager resetCommands
]
