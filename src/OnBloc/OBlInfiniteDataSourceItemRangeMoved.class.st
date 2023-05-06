"
Sent when an item reflected at `=from`= position has been moved to `=to`= position.
This is a structural change event. Representations of other existing items in the data set are still considered up to date and will not be rebound, though their positions may be altered.

Sent by:
	- OBlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: OBlInfiniteDataSourceItemRangeMoved
	do: [ :event | self inform: 'Item was moved from: ', event from asString, ' to: ', event to asString ]

"
Class {
	#name : #OBlInfiniteDataSourceItemRangeMoved,
	#superclass : #OBlInfiniteDataSourceEvent,
	#instVars : [
		'from',
		'to'
	],
	#category : #'OnBloc-Infinite-Events'
}

{ #category : #'instance creation' }
OBlInfiniteDataSourceItemRangeMoved class >> from: aFromPosition to: aToPosition [
	^ self new
		from: aFromPosition;
		to: aToPosition;
		yourself
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeMoved >> from [
	^ from
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeMoved >> from: anObject [
	from := anObject
]

{ #category : #sending }
OBlInfiniteDataSourceItemRangeMoved >> sendTo: anObject [
	anObject onItemsMoved: self
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeMoved >> to [
	^ to
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeMoved >> to: anObject [
	to := anObject
]
