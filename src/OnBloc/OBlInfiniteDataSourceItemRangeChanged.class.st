"
Sent when the `=itemCount`= items starting at `=position`= have changed.
This is an item change event, not a structural change event. It indicates that any reflection of the data in the given position range is out of date and should be updated. The items in the given range retain the same identity.

Sent by:
	- OBlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: OBlInfiniteDataSourceItemRangeChanged
	do: [ :event | self inform: event itemCount asString, ' items were changed starting from: ', event position asString ]

"
Class {
	#name : #OBlInfiniteDataSourceItemRangeChanged,
	#superclass : #OBlInfiniteDataSourceEvent,
	#instVars : [
		'position',
		'itemCount',
		'payload'
	],
	#category : #'OnBloc-Infinite-Events'
}

{ #category : #'instance creation' }
OBlInfiniteDataSourceItemRangeChanged class >> position: aPosition itemCount: anItemCount [

	^ self new
		position: aPosition;
		itemCount: anItemCount;
		yourself
]

{ #category : #'instance creation' }
OBlInfiniteDataSourceItemRangeChanged class >> position: aPosition itemCount: anItemCount payload: anObject [

	^ self new
		position: aPosition;
		itemCount: anItemCount;
		payload: anObject;
		yourself
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeChanged >> itemCount [
	^ itemCount
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeChanged >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeChanged >> payload [
	<return: #Object>
	^ payload
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeChanged >> payload: anObject [
	payload := anObject
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeChanged >> position [
	^ position
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeChanged >> position: anObject [
	position := anObject
]

{ #category : #sending }
OBlInfiniteDataSourceItemRangeChanged >> sendTo: anObject [
	anObject onItemsChanged: self
]
