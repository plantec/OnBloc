Class {
	#name : #OBlRecyclerController,
	#superclass : #Object,
	#instVars : [
		'infiniteElement'
	],
	#category : #'OnBloc-NotUsed-Infinite-Recycler'
}

{ #category : #'scrap fetcher -> recycler' }
OBlRecyclerController >> attachedScrap [
	^ self recycler attachedScrap
]

{ #category : #'recycler -> data source' }
OBlRecyclerController >> bindHolder: aHolder at: aPosition [

	self dataSource bindHolder: aHolder at: aPosition
]

{ #category : #'recycler -> animator' }
OBlRecyclerController >> canReuseUpdatedElementHolder: anElementHolder [
	"Return true if changed element holder can be reused"
	<return: #Boolean>
	
	^ infiniteElement itemAnimator supportsAnimations not or: [ 
			infiniteElement itemAnimator
				canReuseUpdatedElementHolder: anElementHolder
				payloads: anElementHolder payloads ]
]

{ #category : #'recycler -> element' }
OBlRecyclerController >> childRemoved: anElement [

]

{ #category : #accessing }
OBlRecyclerController >> childrenManager [
	^ infiniteElement childrenManager
]

{ #category : #'recycler -> data source' }
OBlRecyclerController >> computePositionOffset: aPosition [
	^ self dataSourceManager computePositionOffset: aPosition
]

{ #category : #'recycler -> data source' }
OBlRecyclerController >> createElementHolderOfType: anItemType [
	<return: #BlInfiniteHolder>

	^ self dataSource createHolder: infiniteElement type: anItemType
]

{ #category : #accessing }
OBlRecyclerController >> dataSource [
	^ infiniteElement dataSource
]

{ #category : #'recycler -> data source' }
OBlRecyclerController >> dataSourceItemCount [
	^ self dataSource itemCount
]

{ #category : #accessing }
OBlRecyclerController >> dataSourceManager [
	^ infiniteElement dataSourceManager
]

{ #category : #'recycler -> element' }
OBlRecyclerController >> elementHolderOf: anElement [
	^ infiniteElement elementHolderOf: anElement
]

{ #category : #'recycler -> animator' }
OBlRecyclerController >> endAnimation: aChildHolder [

]

{ #category : #'recycler -> data source' }
OBlRecyclerController >> hasStableIds [
	^ self dataSource hasStableIds
]

{ #category : #accessing }
OBlRecyclerController >> infiniteElement [
	^ infiniteElement
]

{ #category : #accessing }
OBlRecyclerController >> infiniteElement: anInfiniteElement [

	infiniteElement := anInfiniteElement.
	infiniteElement recycler controller: self.
]

{ #category : #accessing }
OBlRecyclerController >> infoStore [
	^ infiniteElement infoStore
]

{ #category : #'recycler -> element' }
OBlRecyclerController >> isItemPrefetchEnabled [
	^ infiniteElement layout isItemPrefetchEnabled
]

{ #category : #'recycler -> state' }
OBlRecyclerController >> isPreLayout [
	^ self state isPreLayout
]

{ #category : #'recycler -> data source' }
OBlRecyclerController >> itemIdAt: aPosition [
	^ self dataSource itemIdAt: aPosition
]

{ #category : #'recycler -> data source' }
OBlRecyclerController >> itemTypeAt: aPosition [
	^ self dataSource itemTypeAt: aPosition
]

{ #category : #accessing }
OBlRecyclerController >> recycler [
	^ infiniteElement recycler
]

{ #category : #accessing }
OBlRecyclerController >> state [
	^ infiniteElement state
]

{ #category : #'recycler -> element' }
OBlRecyclerController >> unscrapHolder: anElementHolder [
	self recycler unscrapHolder: anElementHolder
]
