Class {
	#name : #OBlInfiniteLinearLayoutAvailableSpaceChanged,
	#superclass : #OBlInfiniteLinearLayoutAnnouncements,
	#instVars : [
		'availableSpace'
	],
	#category : #'OnBloc-Infinite-Layouts-Linear'
}

{ #category : #accessing }
OBlInfiniteLinearLayoutAvailableSpaceChanged >> availableSpace [
	<return: #Number>

	^ availableSpace
]

{ #category : #accessing }
OBlInfiniteLinearLayoutAvailableSpaceChanged >> availableSpace: aNumber [
	availableSpace := aNumber
]
