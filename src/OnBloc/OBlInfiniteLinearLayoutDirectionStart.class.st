Class {
	#name : #OBlInfiniteLinearLayoutDirectionStart,
	#superclass : #OBlInfiniteLinearLayoutDirection,
	#category : #'OnBloc-Infinite-Layouts-Linear-Utilities'
}

{ #category : #testing }
OBlInfiniteLinearLayoutDirectionStart >> isEnd [
	^ false
]

{ #category : #testing }
OBlInfiniteLinearLayoutDirectionStart >> isStart [
	^ true
]

{ #category : #converting }
OBlInfiniteLinearLayoutDirectionStart >> multiplier [
	<return: #Number>

	^ -1
]
