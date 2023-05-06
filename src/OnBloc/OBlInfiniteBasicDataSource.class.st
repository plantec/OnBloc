Class {
	#name : #OBlInfiniteBasicDataSource,
	#superclass : #OBlInfiniteDataSource,
	#instVars : [
		'layoutPositionsRange'
	],
	#category : #'OnBloc-Infinite-DataSource'
}

{ #category : #accessing }
OBlInfiniteBasicDataSource >> itemCount [
	"There are no items in empty datasource"
	<return: #Number>

	^ 0
]

{ #category : #accessing }
OBlInfiniteBasicDataSource >> layoutPositionsRange: anInterval [
	layoutPositionsRange := anInterval
]
