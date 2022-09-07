Class {
	#name : #OBlInfiniteRecyclerFetcher,
	#superclass : #Object,
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #initialization }
OBlInfiniteRecyclerFetcher >> defaultNext [
	^ nil
]

{ #category : #initialization }
OBlInfiniteRecyclerFetcher >> nextFetcher [
	^ self defaultNext 
]
