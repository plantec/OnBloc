"
I am a default implementation of communication interface between child manager and infinite element.
It is enough to use me in most cases.

"
Class {
	#name : #OBlInfiniteDefaultChildrenController,
	#superclass : #OBlInfiniteAbstractChildrenController,
	#instVars : [
		'infiniteElement',
		'childManager'
	],
	#category : #'OnBloc-NotUsed-Infinite-Children'
}

{ #category : #'manager -> element' }
OBlInfiniteDefaultChildrenController >> addChild: anElement at: anIndex [
	infiniteElement addChild: anElement at: anIndex.
	infiniteElement dispatchChildAttached: anElement
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultChildrenController >> attachChild: anElement at: anIndex [
	| anElementHolder |

	anElementHolder := self elementHolderOf: anElement.
	(anElementHolder isTmpDetached not and: [ anElementHolder shouldIgnore not ])
		ifTrue: [ self error: 'Can not attach a child which is not previously detached ' ].
	
	anElementHolder clearTmpDetached.
	infiniteElement attachChild: anElement at: anIndex
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultChildrenController >> childAt: anIndex [
	^ infiniteElement children at: anIndex
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultChildrenController >> childIndexOf: aChildElement [
	^ infiniteElement childIndexOf: aChildElement
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultChildrenController >> childrenCount [
	^ infiniteElement childrenCount
]

{ #category : #accessing }
OBlInfiniteDefaultChildrenController >> childrenManager [
	^ childManager
]

{ #category : #accessing }
OBlInfiniteDefaultChildrenController >> childrenManager: anObject [
	childManager := anObject.
	childManager controller: self
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultChildrenController >> detachChildAt: anIndex [
	| anElement anElementHolder |
	anElement := infiniteElement children 
		at: anIndex
		ifAbsent: [ ^ self ].
	
	anElementHolder := self elementHolderOf: anElement.
	
	(anElementHolder isTmpDetached and: [
		anElement shouldIgnore not ])
			ifTrue: [ self error: 'Can not detach already detached child!' ].
	
	anElementHolder flags addTmpDetached.
	infiniteElement detachChild: anElement
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultChildrenController >> elementHolderOf: anElement [
	^ infiniteElement elementHolderOf: anElement
]

{ #category : #accessing }
OBlInfiniteDefaultChildrenController >> infiniteElement [
	^ infiniteElement
]

{ #category : #accessing }
OBlInfiniteDefaultChildrenController >> infiniteElement: anInfiniteElement [
	infiniteElement := anInfiniteElement
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultChildrenController >> removeAllChildren [
	
	1 to: self childrenCount do: [ :anIndex |
		| anElement |
		anElement := self childAt: anIndex.
		infiniteElement dispatchChildDetached: anElement ].
	
	infiniteElement removeAllChildren
]

{ #category : #'manager -> element' }
OBlInfiniteDefaultChildrenController >> removeChildAt: anIndex [
	| anElement |
	anElement := infiniteElement children 
		at: anIndex
		ifAbsent: [ ^ self ].

	infiniteElement dispatchChildDetached: anElement.
	infiniteElement removeChildAt: anIndex
]
