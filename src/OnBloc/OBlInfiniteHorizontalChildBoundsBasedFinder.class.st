Class {
	#name : #OBlInfiniteHorizontalChildBoundsBasedFinder,
	#superclass : #OBlInfiniteChildBoundsBasedFinder,
	#category : #'OnBloc-Infinite-Layout'
}

{ #category : #accessing }
OBlInfiniteHorizontalChildBoundsBasedFinder >> childEndOf: anElement [
	
	^ (layout decoratedRight: anElement) + anElement margin right
]

{ #category : #accessing }
OBlInfiniteHorizontalChildBoundsBasedFinder >> childStartOf: anElement [
	
	^ (layout decoratedLeft: anElement) - anElement margin left
]

{ #category : #accessing }
OBlInfiniteHorizontalChildBoundsBasedFinder >> parentEnd [
	
	^ layout width - layout paddingRight
]

{ #category : #accessing }
OBlInfiniteHorizontalChildBoundsBasedFinder >> parentStart [
	
	^ layout paddingLeft
]
