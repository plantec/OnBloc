Class {
	#name : #OBlInfiniteRecyclerFetcher,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'OnBloc-Infinite-Recycler'
}

{ #category : #accessing }
OBlInfiniteRecyclerFetcher class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #initialization }
OBlInfiniteRecyclerFetcher >> defaultNext [
	^ nil
]

{ #category : #initialization }
OBlInfiniteRecyclerFetcher >> nextFetcher [
	^ self defaultNext 
]
