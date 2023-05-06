Class {
	#name : #OBlInfiniteDataSourceItemRangeEvent,
	#superclass : #OBlInfiniteDataSourceEvent,
	#instVars : [
		'position',
		'itemCount',
		'event'
	],
	#category : #'OnBloc-Infinite-Events'
}

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeEvent >> event [
	^ event
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeEvent >> event: anObject [
	event := anObject
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeEvent >> itemCount [
	^ itemCount
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeEvent >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeEvent >> position [
	^ position
]

{ #category : #accessing }
OBlInfiniteDataSourceItemRangeEvent >> position: anObject [
	position := anObject
]

{ #category : #sending }
OBlInfiniteDataSourceItemRangeEvent >> sendTo: anObject [
	anObject onItemsEvent: self
]
