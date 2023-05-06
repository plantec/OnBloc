"
Sent when the `=itemCount`= items previously located at `=position`= have been removed from the data set.
The items previously located at and after `=position + itemCount + 1`= may now be found `=oldPosition - itemCount`=.
This is a structural change event. Representations of other existing items in the data set are still considered up to date and will not be rebound, though their positions may be altered.

Sent by:
	- OBlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: OBlInfiniteDataSourceItemRangeRemoved
	do: [ :event | self inform: event itemCount asString, ' items were removed starting from: ', event position asString ]

"
Class {
	#name : #OBlInfiniteDataSourceItemRangeRemoved,
	#superclass : #OBlInfiniteDataSourceEvent,
	#instVars : [
		'position',
		'itemCount'
	],
	#category : #'OnBloc-Infinite-Events'
}

{ #category : #'instance creation' }
OBlInfiniteDataSourceItemRangeRemoved class >> position: aPosition itemCount: anItemCount [

	^ self new
		position: aPosition;
		itemCount: anItemCount;
		yourself
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeRemoved >> itemCount [
	^ itemCount
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeRemoved >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeRemoved >> position [
	^ position
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeRemoved >> position: anObject [
	position := anObject
]

{ #category : #sending }
OBlInfiniteDataSourceItemRangeRemoved >> sendTo: anObject [
	anObject onItemsRemoved: self
]
