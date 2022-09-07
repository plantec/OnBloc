"
I am an element recycler.

I keep track of items outside of current viewport. I use object pool in order to reuse already created objects.
I am used by infinite element.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	attachedScrap:		<Object>
	cachedScrap:		<Object>
	changedScrap:		<Object>
	context:		<Object>
	customCache:		<Object>
	fetcher:		<Object>
	recyclerPool:		<Object>


    Implementation Points

"
Class {
	#name : #OBlInfiniteRecycler,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'attachedScrap'
	],
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #'accessing - cache' }
OBlInfiniteRecycler >> attachedScrap [
	"Return a collection of attached scrapped elements"
	<return: #SequenceableCollection>
	
	^ attachedScrap
]

{ #category : #recycling }
OBlInfiniteRecycler >> canReuseUpdatedElementHolder: anElementHolder in: anInfiniteElement [
	"Return true if changed element holder can be reused"
	<return: #Boolean>
	
	^ anInfiniteElement itemAnimator supportsAnimations not or: [ 
			anInfiniteElement itemAnimator
				canReuseUpdatedElementHolder: anElementHolder
				payloads: anElementHolder payloads ]
]

{ #category : #initialization }
OBlInfiniteRecycler >> clear [
	self removeScrap
]

{ #category : #recycling }
OBlInfiniteRecycler >> clearOldPositions [

	self attachedScrap do: [ :anElementHolder |
		anElementHolder clearOldPosition ]
]

{ #category : #'accessing - cache' }
OBlInfiniteRecycler >> clearScrap [
	"Removes all scrapped elements from corresponding pools"
	
	attachedScrap removeAll
]

{ #category : #initialization }
OBlInfiniteRecycler >> defaultFetcher [
	^ OBlRecyclerPositionScrapFetcher uniqueInstance 

]

{ #category : #private }
OBlInfiniteRecycler >> elementFor: aPosition in: anInfiniteElement [
	"I do a hard work obtaining element for the data at a position in data source.
	@see elementFor: for more information"
	<return: #BlElement>
	| holder fromScrap fetchedResult bound itemElement anInfiniteConstraints |

	(aPosition < 1 or: [ aPosition > anInfiniteElement  dataSource itemCount ])
		ifTrue: [ Error signal: 'Position is out of bounds!' ].

	fetchedResult := self fetcher elementFor: aPosition in: anInfiniteElement.
	
	holder := fetchedResult key.
	fromScrap := fetchedResult value.

	self assert: holder isNotNil.
	self assert: fromScrap isNotNil.

	bound := false.
	(anInfiniteElement state isPreLayout and: [ holder isBound ])
		ifTrue: [ holder preLayoutPosition: aPosition ]
		ifFalse: [
			(holder isBound not or: [ holder needsUpdate or: [ holder isInvalid ] ]) ifTrue: [
				| offsetPosition |
				holder isRemoved ifTrue: [ Error signal: 'Removed holder should come here only in pre-layout!' ].
				offsetPosition := anInfiniteElement dataSourceManager computePositionOffset: aPosition.
				holder infiniteElement: anInfiniteElement.
				
				anInfiniteElement dataSource bindHolder: holder at: offsetPosition.
				
				bound := true.
				anInfiniteElement state isPreLayout
					ifTrue: [ holder preLayoutPosition: aPosition ] ] ].
	
	itemElement := holder itemElement.
	anInfiniteConstraints := itemElement constraints infinite.
	anInfiniteConstraints holder: holder.
	anInfiniteConstraints pendingInvalidate: (fromScrap and: [ bound ]).
	^ itemElement
]

{ #category : #private }
OBlInfiniteRecycler >> fetcher [
	^self defaultFetcher 
]

{ #category : #initialization }
OBlInfiniteRecycler >> initialize [
	super initialize.
	attachedScrap := OrderedCollection new
]

{ #category : #recycling }
OBlInfiniteRecycler >> quickRecycleScrap: anElement [
	"Used as a fast path for unscrapping and recycling a an element during a bulk operation.
	The sender must send #clearScrap when it's done to update the recycler's internal bookkeeping.
	anElement must not be nil"
]

{ #category : #recycling }
OBlInfiniteRecycler >> recycleElement: anElement in: anInfiniteElement [
	"Recycle a detached element.
	The specified element will be added to a pool of elements for later rebinding and reuse.
	An element must be fully detached (removed from parent) before it may be recycled.
	If the element is scrapped, it will be removed from scrap list

	Notice: I try to make element recycle-able since layout intended to recycle this element (e.g. even if it is in scrap or change cache)"
	| anElementHolder |
	anElementHolder := anInfiniteElement elementHolderOf: anElement.	
	anElementHolder isScrap
		ifTrue: [ self unscrapHolder: anElementHolder ]
		ifFalse: [ anElementHolder wasReturnedFromScrap
			ifTrue: [ anElementHolder clearReturnedFromScrap ] ].
]

{ #category : #recycling }
OBlInfiniteRecycler >> removeScrap [
	"Remove all scrap elements out of this recycler.
	Detached elements contained within a recycler pool will remain"
	attachedScrap removeAll
]

{ #category : #'accessing - cache' }
OBlInfiniteRecycler >> reverseScrapDo: aBlock [
	| aScrapCount |
	
	aScrapCount := self scrapCount.
	aScrapCount isZero
		ifTrue: [ ^ self ].

	aScrapCount to: 1 by: -1 do: [ :anIndex |
		| anElement |
		anElement := self scrappedElementAt: anIndex.
		anElement ifNotNil: [ aBlock cull: anElement cull: anIndex ] ]
]

{ #category : #'accessing - cache' }
OBlInfiniteRecycler >> scrapCount [
	"Return amount of scrapped elements"
	<return: #Number>

	^ attachedScrap size
]

{ #category : #recycling }
OBlInfiniteRecycler >> scrapElement: anElement in: anInfiniteElement [

	| anElementHolder |
	anElementHolder := anInfiniteElement elementHolderOf: anElement.

	(anElementHolder isRemoved or: [ 
		 anElementHolder isInvalid or: [ 
			 anElementHolder isUpdated not or: [ 
				 self canReuseUpdatedElementHolder: anElementHolder in: anInfiniteElement ] ] ]) 
		ifFalse: [ ^ self ].

	(anElementHolder isInvalid and: [ 
		 anElementHolder isRemoved not and: [ 
			 anInfiniteElement dataSource hasStableIds not ] ]) ifTrue: [ 
		self error:
			'Can not scrap invalid elements, because they can not be reused from scrap and should be rebound from recycler pool instead' ].
	anElementHolder detachRecycler.
	attachedScrap add: anElementHolder
]

{ #category : #'accessing - cache' }
OBlInfiniteRecycler >> scrappedElementAt: anIndex [
	"Return scrapped element at anIndex"
	<return: #BlElement>

	^ (attachedScrap at: anIndex) itemElement
]

{ #category : #recycling }
OBlInfiniteRecycler >> unscrapHolder: anElementHolder [
	"Remove a previously scrapped element holder from the pool of eligible scrap.
	An element will no longer be eligible for reuse until re-scrapped or until
	it is explicitly removed and recycled"

	attachedScrap remove: anElementHolder.
	anElementHolder detachRecycler
]
