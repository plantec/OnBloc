"
I am a data source observer registered by infinite element to support internal synchronisation of data and its representation.


"
Class {
	#name : #OBlInfiniteElementDataSourceObserver,
	#superclass : #OBlInfiniteDataSourceObserver,
	#instVars : [
		'infiniteElement'
	],
	#category : #'OnBloc-Infinite-DataSource'
}

{ #category : #'instance creation' }
OBlInfiniteElementDataSourceObserver class >> on: anInfiniteElement [
	^ self new
		initializeWith: anInfiniteElement;
		yourself
]

{ #category : #private }
OBlInfiniteElementDataSourceObserver >> assertNotInLayoutOrScroll [
	infiniteElement assertNotInLayoutOrScroll
]

{ #category : #initialization }
OBlInfiniteElementDataSourceObserver >> initializeWith: anInfiniteElement [
	
	self
		assert: [ infiniteElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	infiniteElement := anInfiniteElement
]

{ #category : #'event handling' }
OBlInfiniteElementDataSourceObserver >> onChanged: anEvent [


	self assertNotInLayoutOrScroll.
	
	infiniteElement state structureChanged: true.
	infiniteElement setDataSourceChangedAfterLayout.

	infiniteElement dataSourceManager hasPendingCommands
		ifFalse: [ infiniteElement requestLayout ]
]

{ #category : #'event handling' }
OBlInfiniteElementDataSourceObserver >> onItemsChanged: anEvent [
	| needsUpdate |
	

	self assertNotInLayoutOrScroll.

	needsUpdate := infiniteElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount
		payload: anEvent payload.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]
]

{ #category : #'event handling' }
OBlInfiniteElementDataSourceObserver >> onItemsEvent: anEvent [
	self assertNotInLayoutOrScroll.
	anEvent position to: anEvent position + anEvent itemCount - 1 do: [ :anIndex |
		| anElementHolder |
		anElementHolder := (infiniteElement findElementHolderForDataSourcePosition: anIndex).
		anElementHolder ifNotNil: [ anEvent event sendTo: anElementHolder ] ]
]

{ #category : #'event handling' }
OBlInfiniteElementDataSourceObserver >> onItemsInserted: anEvent [
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]
]

{ #category : #'event handling' }
OBlInfiniteElementDataSourceObserver >> onItemsMoved: anEvent [
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemRangeMoved: anEvent from
		to: anEvent to
		itemCount: 1.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]
]

{ #category : #'event handling' }
OBlInfiniteElementDataSourceObserver >> onItemsRemoved: anEvent [
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]
]

{ #category : #private }
OBlInfiniteElementDataSourceObserver >> triggerUpdateProcessor [
	(infiniteElement hasFixedSize and: [ infiniteElement isAttached ])
		ifTrue: [ infiniteElement postChildrenUpdater ]
		ifFalse: [
			infiniteElement markDataSourceChangeDuringMeasure.
			infiniteElement requestLayout ]
]
