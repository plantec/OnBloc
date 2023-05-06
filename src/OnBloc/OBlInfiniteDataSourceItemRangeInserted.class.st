"
Sent when currently reflected `=itemCount`= items starting at `=position`= have been newly inserted.
The items previously located at `=position`= and beyond can now be found starting at position `=position + itemCount`=.
This is a structural change event. Representations of other existing items in the data set are still considered up to date and will not be rebound, though their positions may be altered.

Sent by:
	- OBlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: OBlInfiniteDataSourceItemRangeInserted
	do: [ :event | self inform: event itemCount asString, ' items were inserted at: ', event position asString ]

"
Class {
	#name : #OBlInfiniteDataSourceItemRangeInserted,
	#superclass : #OBlInfiniteDataSourceEvent,
	#instVars : [
		'position',
		'itemCount'
	],
	#category : #'OnBloc-Infinite-Events'
}

{ #category : #'instance creation' }
OBlInfiniteDataSourceItemRangeInserted class >> position: aPosition itemCount: anItemCount [

	^ self new
		position: aPosition;
		itemCount: anItemCount;
		yourself
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeInserted >> itemCount [
	^ itemCount
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeInserted >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeInserted >> position [
	^ position
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeInserted >> position: anObject [
	position := anObject
]

{ #category : #sending }
OBlInfiniteDataSourceItemRangeInserted >> sendTo: anObject [
	anObject onItemsInserted: self
]
