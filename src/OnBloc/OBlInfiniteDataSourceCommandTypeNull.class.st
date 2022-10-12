Class {
	#name : #OBlInfiniteDataSourceCommandTypeNull,
	#superclass : #OBlInfiniteDataSourceCommandType,
	#category : #'OnBloc-Infinite-DataSource-Support'
}

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeNull >> apply: aCommand in: anInfiniteElement [
	
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeNull >> apply: aCommand onPosition: aPosition [
	^ aPosition
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeNull >> continuous: aPosition start: start [
	^ aPosition = (start + 1)
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeNull >> dispatch: aCommand toLayout: aLayout [
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeNull >> offsetPositions: aCommand in: anInfiniteElement [

]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeNull >> positionMultiplier [
	^ 1
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeNull >> updateElementHoldersIn: aContext command: aCommand [
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeNull >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeNull >> updatePosition: aPosition with: aCommand from: myCommand [
	^ aPosition
]
