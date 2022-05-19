Class {
	#name : #OBlInfiniteRecyclerController,
	#superclass : #Object,
	#instVars : [
		'infiniteElement'
	],
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #'scrap fetcher -> recycler' }
OBlInfiniteRecyclerController >> attachedScrap [
	^ self recycler attachedScrap
]

{ #category : #'recycler -> data source' }
OBlInfiniteRecyclerController >> bindHolder: aHolder at: aPosition [
	self dataSource bindHolder: aHolder at: aPosition
]

{ #category : #'scrap fetcher -> recycler' }
OBlInfiniteRecyclerController >> cachedScrap [
	^ self recycler cachedScrap
]

{ #category : #'recycler -> animator' }
OBlInfiniteRecyclerController >> canReuseUpdatedElementHolder: anElementHolder [
	"Return true if changed element holder can be reused"
	<return: #Boolean>
	
	^ infiniteElement itemAnimator supportsAnimations not or: [ 
			infiniteElement itemAnimator
				canReuseUpdatedElementHolder: anElementHolder
				payloads: anElementHolder payloads ]
]

{ #category : #'scrap fetcher -> recycler' }
OBlInfiniteRecyclerController >> changedScrap [
	^ self recycler changedScrap
]

{ #category : #'recycler -> element' }
OBlInfiniteRecyclerController >> childRemoved: anElement [
	self flag: 'todo'.
]

{ #category : #accessing }
OBlInfiniteRecyclerController >> childrenManager [
	^ infiniteElement childrenManager
]

{ #category : #'recycler -> data source' }
OBlInfiniteRecyclerController >> computePositionOffset: aPosition [
	^ self dataSourceManager computePositionOffset: aPosition
]

{ #category : #'recycler -> data source' }
OBlInfiniteRecyclerController >> createElementHolderOfType: anItemType [
	<return: #BlInfiniteHolder>

	^ self dataSource createHolder: infiniteElement type: anItemType
]

{ #category : #accessing }
OBlInfiniteRecyclerController >> dataSource [
	^ infiniteElement dataSource
]

{ #category : #'recycler -> data source' }
OBlInfiniteRecyclerController >> dataSourceItemCount [
	^ self dataSource itemCount
]

{ #category : #accessing }
OBlInfiniteRecyclerController >> dataSourceManager [
	^ infiniteElement dataSourceManager
]

{ #category : #'recycler -> element' }
OBlInfiniteRecyclerController >> elementHolderOf: anElement [
	^ infiniteElement elementHolderOf: anElement
]

{ #category : #'recycler -> animator' }
OBlInfiniteRecyclerController >> endAnimation: aChildHolder [
	^ self shouldBeImplemented
]

{ #category : #'recycler -> children' }
OBlInfiniteRecyclerController >> findHiddenNonRemovedChildAt: aPosition type: anItemType [
	^ self childrenManager findHiddenNonRemovedChildAt: aPosition type: anItemType
]

{ #category : #'scrap fetcher -> recycler' }
OBlInfiniteRecyclerController >> hasChangedScrap [
	^ self shouldBeImplemented
]

{ #category : #'recycler -> data source' }
OBlInfiniteRecyclerController >> hasStableIds [
	^ self dataSource hasStableIds
]

{ #category : #accessing }
OBlInfiniteRecyclerController >> infiniteElement [
	^ infiniteElement
]

{ #category : #accessing }
OBlInfiniteRecyclerController >> infiniteElement: anInfiniteElement [

	infiniteElement := anInfiniteElement.
	infiniteElement recycler controller: self.
]

{ #category : #accessing }
OBlInfiniteRecyclerController >> infoStore [
	^ infiniteElement infoStore
]

{ #category : #'recycler -> element' }
OBlInfiniteRecyclerController >> isItemPrefetchEnabled [
	^ infiniteElement layout isItemPrefetchEnabled
]

{ #category : #'recycler -> state' }
OBlInfiniteRecyclerController >> isPreLayout [
	^ self state isPreLayout
]

{ #category : #'recycler -> data source' }
OBlInfiniteRecyclerController >> itemIdAt: aPosition [
	^ self dataSource itemIdAt: aPosition
]

{ #category : #'recycler -> element' }
OBlInfiniteRecyclerController >> itemPrefetchCount [
	^ self shouldBeImplemented
]

{ #category : #'recycler -> data source' }
OBlInfiniteRecyclerController >> itemTypeAt: aPosition [
	^ self dataSource itemTypeAt: aPosition
]

{ #category : #'recycler -> element' }
OBlInfiniteRecyclerController >> lastPrefetchIncludedPosition: aPosition [
	^ self shouldBeImplemented
]

{ #category : #'recycler -> element' }
OBlInfiniteRecyclerController >> onElementHolderRecycled: anElementHolder [

	self dataSource onElementRecycled: anElementHolder.
	self infoStore removeHolder: anElementHolder
]

{ #category : #'scrap fetcher -> recycler' }
OBlInfiniteRecyclerController >> quickRecycleScrap: anElement [
	self recycler quickRecycleScrap: anElement
]

{ #category : #'scrap fetcher -> recycler' }
OBlInfiniteRecyclerController >> recycleCachedAt: anIndex [
	self recycler recycleCachedAt: anIndex
]

{ #category : #'scrap fetcher -> recycler' }
OBlInfiniteRecyclerController >> recycleElementHolder: anElementHolder [
	self flag: #todo
]

{ #category : #accessing }
OBlInfiniteRecyclerController >> recycler [
	^ infiniteElement recycler
]

{ #category : #'scrap fetcher -> recycler' }
OBlInfiniteRecyclerController >> recyclerPool [
	^ self recycler pool
]

{ #category : #'recycler -> element' }
OBlInfiniteRecyclerController >> removeDetachedChild: anElement [
	^ self shouldBeImplemented
]

{ #category : #'recycler -> state' }
OBlInfiniteRecyclerController >> removeHolderFromInfoStore: anElementHolder [
	self infoStore removeHolder: anElementHolder
]

{ #category : #accessing }
OBlInfiniteRecyclerController >> state [
	^ infiniteElement state
]

{ #category : #'recycler -> state' }
OBlInfiniteRecyclerController >> stateItemCount [
	^ self shouldBeImplemented
]

{ #category : #'scrap fetcher -> recycler' }
OBlInfiniteRecyclerController >> userCache [
	^ self recycler userCache
]
