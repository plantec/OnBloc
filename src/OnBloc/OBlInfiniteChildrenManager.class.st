"
I help to manage children (add / remove) and used as mediator between infinite element and data source.

"
Class {
	#name : #OBlInfiniteChildrenManager,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'controller'
	],
	#category : #'OnBloc-Infinite-Children'
}

{ #category : #'children add/remove' }
OBlInfiniteChildrenManager >> addChild: child [ 
	self addChild: child at: 0
]

{ #category : #'children add/remove' }
OBlInfiniteChildrenManager >> addChild: aChildElement at: anIndex [

	"Adds a child at an index and makes it hidden if isHidden is true.
	If an Index is less or equal 0 child will be appended to the end"

	| anOffset |
	anOffset := (anIndex <= 0
		             ifTrue: [ controller childrenCount + 1 ]
		             ifFalse: [ anIndex ]) max: 1.
	controller addChild: aChildElement at: anOffset
]

{ #category : #'children add/remove' }
OBlInfiniteChildrenManager >> attachChild: aChildElement at: anIndex [ 
	"Attaches aChildElement to the infinite element"

	| anOffset |
	
	anOffset := (anIndex <= 0
		ifTrue: [ controller childrenCount + 1 ]
		ifFalse: [ anIndex ]) max: 1.
	
	controller attachChild: aChildElement at: anOffset
]

{ #category : #'children accessing' }
OBlInfiniteChildrenManager >> childAt: anIndex [
	"Returns the child at anIndex"
	<return: #BlElement>

	^ controller childAt: anIndex
]

{ #category : #'children accessing' }
OBlInfiniteChildrenManager >> childIndexOf: aChildElement [
	"Return the index of the child in regular perspective.
	Return 0 if child is not present in infinite element"
	<return: #Number>

	|index|
	
	index := controller childIndexOf: aChildElement.
	index <= 0
		ifTrue: [ ^ 0 ].		
	^ index 
]

{ #category : #'children accessing' }
OBlInfiniteChildrenManager >> childrenCount [
	"Return the number of not hidden children"
	<return: #Number>

	^ controller childrenCount
]

{ #category : #'children accessing' }
OBlInfiniteChildrenManager >> childrenDo: aBlock [

	1 to: self childrenCount do: [ :anIndex |
		aBlock value: (self childAt: anIndex) ]
]

{ #category : #accessing }
OBlInfiniteChildrenManager >> controller [
	^ controller
]

{ #category : #accessing }
OBlInfiniteChildrenManager >> controller: aChildController [
	controller := aChildController
]

{ #category : #initialization }
OBlInfiniteChildrenManager >> defaultBucket [
	^ BlInfiniteBucket new
]

{ #category : #'children add/remove' }
OBlInfiniteChildrenManager >> detachChildAt: anIndex [
	"Detaches a child element at anIndex from infinite element"
	controller detachChildAt: anIndex
]

{ #category : #testing }
OBlInfiniteChildrenManager >> hasChildren [
	"Return true if there are any non-hidden children, false otherwise"
	<return: #Boolean>

	^ self childrenCount > 0
]

{ #category : #initialization }
OBlInfiniteChildrenManager >> initialize [
	super initialize.
	

]

{ #category : #'children add/remove' }
OBlInfiniteChildrenManager >> removeAllChildrenUnfiltered [
	"Remove all children from the infinite element including the hidden ones"

	controller removeAllChildren
]

{ #category : #'children add/remove' }
OBlInfiniteChildrenManager >> removeChild: aChildElement [
	"Remove aChildElement from infinite element
	and do not track it anymore (unhide and remove from bucket)"
	| index |

	index := controller childIndexOf: aChildElement.
	index <= 0
		ifTrue: [ ^ self ].
	
	controller removeChildAt: index
]

{ #category : #'children add/remove' }
OBlInfiniteChildrenManager >> removeChildAt: anIndex [

	"Remove a child at anIndex from infinite element
	and do not track it anymore."

	| anElement |
	anElement := controller childAt: anIndex.
	anElement ifNil: [ ^ self ].

	controller removeChildAt: anIndex
]

{ #category : #'children accessing' }
OBlInfiniteChildrenManager >> unfilteredChildAt: anIndex [
	"Return a child element by infinite element's offset.
	I will not offset this index"
	<return: #BlElement>

	^ controller childAt: anIndex
]

{ #category : #'children accessing' }
OBlInfiniteChildrenManager >> unfilteredChildrenCount [
	"Return the total number of children"
	<return: #Number>

	^ controller childrenCount
]

{ #category : #'children accessing' }
OBlInfiniteChildrenManager >> unfilteredChildrenDo: aBlock [
	"Do not remove children in a Block!"
	| aChildCount |
	aChildCount := self unfilteredChildrenCount.
	1 to: aChildCount do: [ :anIndex |
		aBlock value: (self unfilteredChildAt: anIndex) ]
]
