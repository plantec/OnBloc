Class {
	#name : #OBlRecyclerPositionScrapFetcher,
	#superclass : #OBlInfiniteRecyclerFetcher,
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #'element fetching' }
OBlRecyclerPositionScrapFetcher >> childRemoved: anElement in: anInfiniteElement [
]

{ #category : #initialization }
OBlRecyclerPositionScrapFetcher >> defaultNext [
	^ OBlRecyclerDataSourceFetcher new
]

{ #category : #'element fetching' }
OBlRecyclerPositionScrapFetcher >> elementFor: aPosition in: anInfiniteElement [

	| holder fromScrap |
	fromScrap := false.
	holder := self exactScrapFor: aPosition type: BlInfiniteItemType invalid in: anInfiniteElement.
	holder ifNotNil: [ 
		(self validateHolder: holder in: anInfiniteElement)
			ifFalse: [ 
				holder flags addInvalid.
				holder isScrap
					ifTrue: [ 
						self childRemoved: holder itemElement in: holder infiniteElement.
						holder itemElement dispatchRemovedFromParent: holder infiniteElement.
						anInfiniteElement recycler unscrapHolder: holder ]
					ifFalse: [ holder wasReturnedFromScrap ifTrue: [ holder clearReturnedFromScrap ] ].
				holder := nil ]
			ifTrue: [ fromScrap := true ] ].

	^ holder ifNotNil: [ holder -> fromScrap ] ifNil: [ self nextFetcher elementFor: aPosition in: anInfiniteElement ]
]

{ #category : #private }
OBlRecyclerPositionScrapFetcher >> exactScrapFor: aPosition type: itemType in: anInfiniteElement [

	^ anInfiniteElement recycler attachedScrap 
		detect: [ :holder | (holder wasReturnedFromScrap not
			and: [ holder layoutPosition = aPosition 
				and: [ holder isInvalid not
					and: [ anInfiniteElement state isPreLayout
						or: [ holder isRemoved not ] ] ] ]) ]
		ifFound: [ :holder | 
			(itemType = BlInfiniteItemType invalid
				or: [ holder itemType = itemType ])
					ifFalse: [ 
						Error signal: 'Scrap holder has wrong item type!' ].
			holder flags addReturnedFromScrap.
			holder ]
		ifNone: [ nil ]
]

{ #category : #private }
OBlRecyclerPositionScrapFetcher >> validateHolder: aHolder in: anInfiniteElement [

	aHolder isRemoved ifTrue: [ 
		anInfiniteElement state isPreLayout
			ifFalse: [ Error signal: 'Should not get a removed holder!' ].
		^ anInfiniteElement state isPreLayout ].

	(aHolder position <= 0 or: [ aHolder position > anInfiniteElement dataSource itemCount ])
		ifTrue: [ Error signal: ('Holder has completely wrong position! position = {1}, count = {2}'
			format: { aHolder position. anInfiniteElement dataSource itemCount. }) ].

	anInfiniteElement state isPreLayout ifFalse: [ 
		| type |
		type := anInfiniteElement dataSource itemTypeAt: aHolder position.
		type = aHolder itemType
			ifFalse: [ ^ false ] ].

	^ anInfiniteElement dataSource hasStableIds
		ifTrue: [ aHolder itemId = (anInfiniteElement dataSource itemIdAt: aHolder position) ]
		ifFalse: [ true ]
]
