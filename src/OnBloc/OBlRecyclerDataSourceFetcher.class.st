Class {
	#name : #OBlRecyclerDataSourceFetcher,
	#superclass : #OBlInfiniteRecyclerFetcher,
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #'element fetching' }
OBlRecyclerDataSourceFetcher >> elementFor: aPosition in: anInfiniteElement [

	^ anInfiniteElement dataSource createHolder: anInfiniteElement
]
