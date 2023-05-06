Class {
	#name : #OBlInfiniteDataSourceEvent,
	#superclass : #BlEvent,
	#instVars : [
		'dataSource'
	],
	#category : #'OnBloc-Infinite-Events'
}

{ #category : #accessing }
OBlInfiniteDataSourceEvent >> dataSource [
	^ dataSource
]

{ #category : #accessing }
OBlInfiniteDataSourceEvent >> dataSource: anObject [
	dataSource := anObject
]
