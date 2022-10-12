Class {
	#name : #OBlInfiniteDataSourceCommandTypeMove,
	#superclass : #OBlInfiniteDataSourceCommandType,
	#category : #'OnBloc-Infinite-DataSource-Support'
}

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeMove >> apply: aCommand in: anInfiniteElement [
	anInfiniteElement dataSourceManager postponeAndUpdateElementHolders: aCommand on: anInfiniteElement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeMove >> apply: aCommand onPosition: aPosition [
	| newPosition |
	
	aCommand positionStart = aPosition
		ifTrue: [ newPosition := aCommand itemCount ]
		ifFalse: [ 
			newPosition := aPosition.
			(aCommand positionStart < aPosition)
				ifTrue: [ newPosition := aPosition - 1 ].
			(aCommand itemCount <= aPosition)
				ifTrue: [ newPosition := aPosition + 1 ] ].
	
	^ newPosition
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeMove >> continuous: aPosition start: start [
	self shouldNotImplement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeMove >> dispatch: aCommand toLayout: aLayout [
	aLayout onItemsMovedFrom: aCommand positionStart to: aCommand itemCount itemCount: 1
]

{ #category : #testing }
OBlInfiniteDataSourceCommandTypeMove >> isMove [
	^ true
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeMove >> offsetPositions: aCommand in: anInfiniteElement [

	anInfiniteElement dataSourceManager
		offsetPositionsForMove: aCommand positionStart
		to: aCommand itemCount
		in: anInfiniteElement

]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeMove >> positionMultiplier [
	self shouldNotImplement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeMove >> updateElementHoldersIn: anInfiniteElement command: aCommand [

	anInfiniteElement dataSourceManager
		offsetPositionsForMove: aCommand startPosition
		to: aCommand itemCount
		in: anInfiniteElement 
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeMove >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [
	self shouldNotImplement
]

{ #category : #dispatch }
OBlInfiniteDataSourceCommandTypeMove >> updatePosition: aPosition with: aCommand from: myCommand [
	|start end pos|
	pos := aPosition.
	
	myCommand positionStart < myCommand itemCount
		ifTrue: [
			start := myCommand positionStart.
			end := myCommand itemCount ]
		ifFalse: [
			start := myCommand itemCount.
			end := myCommand positionStart ].
		
	(pos >= start and: [ pos <= end ])
		ifTrue: [
			start = myCommand positionStart
				ifTrue: [
					aCommand isAdd
						ifTrue: [ myCommand itemCount: myCommand itemCount + 1 ]
						ifFalse: [ aCommand isRemove
							ifTrue: [ myCommand itemCount: myCommand itemCount - 1 ] ].
					pos := pos + 1 ]
				ifFalse: [ 
					aCommand isAdd
						ifTrue: [ myCommand positionStart: myCommand positionStart + 1 ]
						ifFalse: [ aCommand isRemove
							ifTrue: [ myCommand positionStart: myCommand positionStart - 1 ] ].
					pos := pos - 1 ] ]
		ifFalse: [ 
			(pos < myCommand positionStart) ifTrue: [ 
				aCommand isAdd
					ifTrue: [
						myCommand positionStart: myCommand positionStart + 1.
						myCommand itemCount: myCommand itemCount + 1 ]
					ifFalse: [ aCommand isRemove
						ifTrue: [
							myCommand positionStart: myCommand positionStart - 1.
							myCommand itemCount: myCommand itemCount - 1 ] ] ] ].
	^ pos
]
