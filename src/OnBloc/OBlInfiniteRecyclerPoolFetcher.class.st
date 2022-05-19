Class {
	#name : #OBlInfiniteRecyclerPoolFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #initialization }
OBlInfiniteRecyclerPoolFetcher >> defaultNext [
	^ OBlInfiniteRecyclerDataSourceFetcher instance
]

{ #category : #'element fetching' }
OBlInfiniteRecyclerPoolFetcher >> elementFor: aPosition dryRun: dryRun controller: aRecyclerController [
	^ aRecyclerController infiniteElement telemetry
		timeSync: [ 'Fetch element from pool at {1}' format: { aPosition } ]
		during: [
			| holder |
			holder := aRecyclerController recyclerPool at: (aRecyclerController itemTypeAt: aPosition).
			holder ifNotNil: #reset.

			holder
				ifNotNil: [ holder -> false ]
				ifNil: [ self nextDo: [ :next | next elementFor: aPosition dryRun: dryRun controller: aRecyclerController ] ] ]
]
