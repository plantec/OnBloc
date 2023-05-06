Class {
	#name : #OBlInfiniteChildBoundsBasedFinder,
	#superclass : #BlChildBoundsBasedFinder,
	#instVars : [
		'layout'
	],
	#category : #'OnBloc-Infinite-Layout'
}

{ #category : #accessing }
OBlInfiniteChildBoundsBasedFinder >> childAt: anIndex [
	<return: #BlElement>
	
	^ layout childAt: anIndex
]

{ #category : #accessing }
OBlInfiniteChildBoundsBasedFinder >> layout [
	^ layout
]

{ #category : #accessing }
OBlInfiniteChildBoundsBasedFinder >> layout: anObject [
	layout := anObject
]
