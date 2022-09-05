Class {
	#name : #OBlRecyclerDataSourceFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #initialization }
OBlRecyclerDataSourceFetcher >> defaultNext [
	^ nil
]

{ #category : #'element fetching' }
OBlRecyclerDataSourceFetcher >> elementFor: aPosition controller: aRecyclerController [

	| holder |
	holder := aRecyclerController createElementHolderOfType: (aRecyclerController itemTypeAt: aPosition).
	^ holder -> false
]
