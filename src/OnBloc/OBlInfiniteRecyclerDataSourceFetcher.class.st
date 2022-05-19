Class {
	#name : #OBlInfiniteRecyclerDataSourceFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #initialization }
OBlInfiniteRecyclerDataSourceFetcher >> defaultNext [
	^ nil
]

{ #category : #'element fetching' }
OBlInfiniteRecyclerDataSourceFetcher >> elementFor: aPosition dryRun: dryRun controller: aRecyclerController [

	| holder |
	holder := aRecyclerController createElementHolderOfType:
		          (aRecyclerController itemTypeAt: aPosition).
	holder ifNil: [ 
		Error signal: 'Data source must not return nil holder!' ].

	^ holder -> false
]
