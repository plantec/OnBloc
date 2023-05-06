Class {
	#name : #OBlInfiniteHorizontalChildBoundsBasedFinder,
	#superclass : #OBlInfiniteChildBoundsBasedFinder,
	#category : #'OnBloc-Infinite-Layout'
}

{ #category : #accessing }
OBlInfiniteHorizontalChildBoundsBasedFinder >> childEndOf: anElement [
	<return: #Number>
	
	^ (layout decoratedRight: anElement) + anElement margin right
]

{ #category : #accessing }
OBlInfiniteHorizontalChildBoundsBasedFinder >> childStartOf: anElement [
	<return: #Number>
	
	^ (layout decoratedLeft: anElement) - anElement margin left
]

{ #category : #accessing }
OBlInfiniteHorizontalChildBoundsBasedFinder >> parentEnd [
	<return: #Number>
	
	^ layout width - layout paddingRight
]

{ #category : #accessing }
OBlInfiniteHorizontalChildBoundsBasedFinder >> parentStart [
	<return: #Number>
	
	^ layout paddingLeft
]
