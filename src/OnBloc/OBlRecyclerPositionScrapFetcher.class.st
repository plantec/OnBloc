Class {
	#name : #OBlRecyclerPositionScrapFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #initialization }
OBlRecyclerPositionScrapFetcher >> defaultNext [
	^ OBlRecyclerDataSourceFetcher new
]

{ #category : #'element fetching' }
OBlRecyclerPositionScrapFetcher >> elementFor: aPosition controller: aRecyclerController [

	| holder fromScrap dryRun |
	fromScrap := false.
	holder := self exactScrapFor: aPosition type: BlInfiniteItemType invalid controller: aRecyclerController.
	holder ifNotNil: [ 
		(self validateHolder: holder controller: aRecyclerController)
			ifFalse: [ 
				
					holder flags addInvalid.
					holder isScrap
						ifTrue: [ 
							aRecyclerController childRemoved: holder itemElement.
							holder itemElement dispatchRemovedFromParent: holder infiniteElement.
							aRecyclerController unscrapHolder: holder ]
						ifFalse: [ 
							holder wasReturnedFromScrap ifTrue: [ holder clearReturnedFromScrap ] ].
				holder := nil ]
			ifTrue: [ fromScrap := true ] ].

	^ holder ifNotNil: [ holder -> fromScrap ] ifNil: [
		  self nextDo: [ :next | 
			  next
				  elementFor: aPosition
				  controller: aRecyclerController ] ]
]

{ #category : #private }
OBlRecyclerPositionScrapFetcher >> exactScrapFor: aPosition type: itemType controller: aRecyclerController [

	^ aRecyclerController attachedScrap 
		detect: [ :holder | (holder wasReturnedFromScrap not
			and: [ holder layoutPosition = aPosition 
				and: [ holder isInvalid not
					and: [ aRecyclerController isPreLayout
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
OBlRecyclerPositionScrapFetcher >> validateHolder: aHolder controller: aRecyclerController [

	aHolder isRemoved ifTrue: [ 
		aRecyclerController isPreLayout
			ifFalse: [ Error signal: 'Should not get a removed holder!' ].
		^ aRecyclerController isPreLayout ].

	(aHolder position <= 0 or: [ aHolder position > aRecyclerController dataSourceItemCount ])
		ifTrue: [ Error signal: ('Holder has completely wrong position! position = {1}, count = {2}'
			format: { aHolder position. aRecyclerController dataSourceItemCount. }) ].

	aRecyclerController isPreLayout ifFalse: [ 
		| type |
		type := aRecyclerController itemTypeAt: aHolder position.
		type = aHolder itemType
			ifFalse: [ ^ false ] ].

	^ aRecyclerController hasStableIds
		ifTrue: [ aHolder itemId = (aRecyclerController itemIdAt: aHolder position) ]
		ifFalse: [ true ]
]
