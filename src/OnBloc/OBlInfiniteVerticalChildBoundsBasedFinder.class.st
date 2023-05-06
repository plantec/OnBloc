Class {
	#name : #OBlInfiniteVerticalChildBoundsBasedFinder,
	#superclass : #OBlInfiniteChildBoundsBasedFinder,
	#category : #'OnBloc-Infinite-Layout'
}

{ #category : #accessing }
OBlInfiniteVerticalChildBoundsBasedFinder >> childEndOf: anElement [
	<return: #Number>
	
	^ (layout decoratedBottom: anElement) + anElement margin bottom
]

{ #category : #accessing }
OBlInfiniteVerticalChildBoundsBasedFinder >> childStartOf: anElement [
	<return: #Number>
	
	^ (layout decoratedTop: anElement) - anElement margin top
]

{ #category : #accessing }
OBlInfiniteVerticalChildBoundsBasedFinder >> parentEnd [
	<return: #Number>
	
	^ layout height - layout paddingBottom
]

{ #category : #accessing }
OBlInfiniteVerticalChildBoundsBasedFinder >> parentStart [
	<return: #Number>
	
	^ layout paddingTop
]
