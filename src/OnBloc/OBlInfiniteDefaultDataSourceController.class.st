"
I am a default implementation of communication interface between data source manager and infinite element.
It is enough to use me in most cases.

"
Class {
	#name : #OBlInfiniteDefaultDataSourceController,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'infiniteElement'
	],
	#category : #'OnBloc-Infinite-DataSource-Support'
}

{ #category : #accessing }
OBlInfiniteDefaultDataSourceController >> dataSourceManager: aDataSourceManager [
	aDataSourceManager controller: self
]

{ #category : #private }
OBlInfiniteDefaultDataSourceController >> dispatchCommand: aCommand [
	"Dispatche data source update command to all interested objects,
	in this case to infinite element's layout.
	aCommand must not be nil"
	
	aCommand dispatchToLayout: infiniteElement layout
]

{ #category : #accessing }
OBlInfiniteDefaultDataSourceController >> element: anInfiniteElement [
	infiniteElement := anInfiniteElement
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultDataSourceController >> elementHolderAt: aPosition [
	<return: #BlElement or: nil>

	^ infiniteElement findElementHolderForPosition: aPosition checkNew: true
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
