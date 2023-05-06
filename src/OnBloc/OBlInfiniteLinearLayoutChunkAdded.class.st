Class {
	#name : #OBlInfiniteLinearLayoutChunkAdded,
	#superclass : #OBlInfiniteLinearLayoutAnnouncements,
	#instVars : [
		'element'
	],
	#category : #'OnBloc-Infinite-Layouts-Linear'
}

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkAdded >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
OBlInfiniteLinearLayoutChunkAdded >> element: aBlElement [
	element := aBlElement
]
