Class {
	#name : #OBlInfiniteRecyclerChangedScrapFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #private }
OBlInfiniteRecyclerChangedScrapFetcher >> changedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController [
	(aRecyclerController hasChangedScrap)
		ifFalse: [ ^ nil ].
	
	^ (self positionedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController)
		ifNil: [ self idScrapFor: aPosition dryRun: dryRun controller: aRecyclerController ]
]

{ #category : #initialization }
OBlInfiniteRecyclerChangedScrapFetcher >> defaultNext [
	^ nil
]

{ #category : #'element fetching' }
OBlInfiniteRecyclerChangedScrapFetcher >> elementFor: aPosition dryRun: dryRun controller: aRecyclerController [

	| holder |
	^ (aRecyclerController isPreLayout and: [ 
		   (holder := self
			              changedScrapFor: aPosition
			              dryRun: dryRun
			              controller: aRecyclerController) isNotNil ])
		  ifTrue: [ holder -> true ]
		  ifFalse: [ 
			  self nextDo: [ :next | 
				  next
					  elementFor: aPosition
					  dryRun: dryRun
					  controller: aRecyclerController ] ]
]

{ #category : #private }
OBlInfiniteRecyclerChangedScrapFetcher >> idScrapFor: aPosition dryRun: dryRun controller: aRecyclerController [

	aRecyclerController hasStableIds ifTrue: [
		| offsetPosition |
		offsetPosition := aRecyclerController computePositionOffset: aPosition.
		(offsetPosition > 1 and: [ offsetPosition <= aRecyclerController dataSourceItemCount ]) ifTrue: [ 
			|id|
			id := aRecyclerController itemIdAt: offsetPosition.
			aRecyclerController changedScrap
				detect: [ :holder |
					holder wasReturnedFromScrap not and: [ holder itemId = id ] ]
				ifFound: [ :holder |
					holder flags addReturnedFromScrap.
					^ holder ] ] ].
	^ nil
]

{ #category : #private }
OBlInfiniteRecyclerChangedScrapFetcher >> positionedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController [

	^ aRecyclerController changedScrap
		detect: [ :holder |
			holder wasReturnedFromScrap not and: [ holder layoutPosition = aPosition ] ]
		ifFound: [ :holder |
			holder flags addReturnedFromScrap.
			holder ]
		ifNone: [ nil ]
]
