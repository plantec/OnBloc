Class {
	#name : #OBlInfiniteRecyclerPool,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'scrap',
		'maxScrap',
		'attachCount'
	],
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #recycling }
OBlInfiniteRecyclerPool >> at: anIntemType [

	<return: #BlInfiniteHolder or: nil>
	^ scrap
		  at: anIntemType
		  ifPresent: [ :aScrapHeap | 
			  aScrapHeap ifEmpty: [ nil ] ifNotEmpty: [ aScrapHeap removeLast ] ]
		  ifAbsent: [ nil ]
]

{ #category : #'attach - detach' }
OBlInfiniteRecyclerPool >> attach [
	attachCount := attachCount + 1
]

{ #category : #invalidate }
OBlInfiniteRecyclerPool >> clear [
	scrap removeAll
]

{ #category : #hooks }
OBlInfiniteRecyclerPool >> dataSourceChangedFrom: anOldDataSource to: aNewDataSource isCompatible: aBoolean [
	self shouldBeImplemented
]

{ #category : #initialization }
OBlInfiniteRecyclerPool >> defaultMaxScrap [
	^ 10
]

{ #category : #'attach - detach' }
OBlInfiniteRecyclerPool >> detach [
	attachCount := attachCount - 1
]

{ #category : #accessing }
OBlInfiniteRecyclerPool >> heapAt: anItemType [
	<return: #OrderedCollection of: #BlInfiniteElementHolder>

	^ scrap
		at: anItemType
		ifAbsentPut: [ 
			| aHeap |
			aHeap := OrderedCollection new.
			maxScrap at: anItemType ifAbsentPut: [ self defaultMaxScrap ].
			aHeap ]
]

{ #category : #initialization }
OBlInfiniteRecyclerPool >> initialize [
	super initialize.
	
	scrap := Dictionary new.
	maxScrap := Dictionary new.
	attachCount := 0.
]

{ #category : #recycling }
OBlInfiniteRecyclerPool >> max: aNumber type: anItemType [
	| aScrapHeap |
	
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Max amount of scrap must be non-negative' ].
	
	maxScrap at: anItemType put: aNumber.
	aScrapHeap := self heapAt: anItemType.
	
	[ aScrapHeap size > aNumber ] whileTrue: [
		aScrapHeap removeLast ]
]

{ #category : #recycling }
OBlInfiniteRecyclerPool >> put: anElementHolder [
	| anItemType aScrapHeap |

	anItemType := anElementHolder itemType.
	aScrapHeap := self heapAt: anItemType.
	
	(maxScrap at: anItemType) <= aScrapHeap size
		ifTrue: [ ^ self ].
	
	self
		assert: [ (aScrapHeap includes: anElementHolder) not ]
		description: [ 'Scrap element already exists!' ].
	
	anElementHolder reset.
	aScrapHeap add: anElementHolder.
]

{ #category : #accessing }
OBlInfiniteRecyclerPool >> size [
	<return: #Number>

	^ scrap
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :aDictionary | aDictionary sum: [ :each | each size ] ]
]
