Class {
	#name : #OBlInfiniteVerticalChildBoundsBasedFinder,
	#superclass : #OBlInfiniteChildBoundsBasedFinder,
	#category : #'OnBloc-Infinite-Layout'
}

{ #category : #accessing }
OBlInfiniteVerticalChildBoundsBasedFinder >> childEndOf: anElement [
	
	^ (layout decoratedBottom: anElement) + anElement margin bottom
]

{ #category : #accessing }
OBlInfiniteVerticalChildBoundsBasedFinder >> childStartOf: anElement [
	
	^ (layout decoratedTop: anElement) - anElement margin top
]

{ #category : #accessing }
OBlInfiniteVerticalChildBoundsBasedFinder >> parentEnd [
	
	^ layout height - layout paddingBottom
]

{ #category : #accessing }
OBlInfiniteVerticalChildBoundsBasedFinder >> parentStart [
	
	^ layout paddingTop
]
