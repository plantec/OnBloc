Class {
	#name : #OBlInfiniteLinearLayoutDirectionEnd,
	#superclass : #OBlInfiniteLinearLayoutDirection,
	#category : #'OnBloc-Infinite-Layouts-Linear-Utilities'
}

{ #category : #testing }
OBlInfiniteLinearLayoutDirectionEnd >> isEnd [
	^ true
]

{ #category : #testing }
OBlInfiniteLinearLayoutDirectionEnd >> isStart [
	^ false
]

{ #category : #converting }
OBlInfiniteLinearLayoutDirectionEnd >> multiplier [
	<return: #Number>

	^ 1
]
