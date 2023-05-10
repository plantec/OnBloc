Class {
	#name : #OBlInfiniteMouseScrollListener,
	#superclass : #BlBasicEventHandler,
	#classVars : [
		'ScrollingVelocity'
	],
	#category : #'OnBloc-Infinite-Basic'
}

{ #category : #accessing }
OBlInfiniteMouseScrollListener class >> scrollingVelocity [

	^ ScrollingVelocity ifNil: [ ScrollingVelocity := 40 ]
]

{ #category : #accessing }
OBlInfiniteMouseScrollListener class >> scrollingVelocity: anInteger [

	ScrollingVelocity := anInteger
]

{ #category : #'mouse handlers' }
OBlInfiniteMouseScrollListener >> canScrollDown: anInfiniteElement [
	"Return true if an infinite element can be scrolled down"
	<return: #Boolean>	
	| aLastChild |
	
	aLastChild := anInfiniteElement layout childAtPosition: anInfiniteElement layout itemCount.
	aLastChild
		ifNil: [ ^ true ].

	aLastChild bounds inParent bottom > (anInfiniteElement height - anInfiniteElement layout paddingBottom) 
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #'mouse handlers' }
OBlInfiniteMouseScrollListener >> canScrollUp: anInfiniteElement [
	"Return true if an infinite element can be scrolled up"
	<return: #Boolean>	
	| aFirstChild |

	aFirstChild := anInfiniteElement layout childAtPosition: 1.
	aFirstChild
		ifNil: [ ^ true ].
		
	aFirstChild position y < (anInfiniteElement layout paddingTop) 
		ifTrue: [ ^ true ].
		
	^ false
]

{ #category : #accessing }
OBlInfiniteMouseScrollListener >> eventClass [
	^ BlMouseWheelEvent
]

{ #category : #'mouse handlers' }
OBlInfiniteMouseScrollListener >> handleEvent: anEvent [
	anEvent sendTo: self
]

{ #category : #'mouse handlers' }
OBlInfiniteMouseScrollListener >> mouseWheelEvent: anEvent [
	| dX dY anInfiniteElement isHorizontal |

	anEvent vector isZero
		ifTrue: [ ^ self ].

	anInfiniteElement := anEvent currentTarget.
	
	isHorizontal := anEvent vector x abs > anEvent vector y abs.

	dX := isHorizontal
		ifTrue: [ anEvent vector length * anEvent vector x sign ]
		ifFalse: [ 0 ].

	dY := isHorizontal not
		ifTrue: [
			(anEvent isScrollDown and: [ self canScrollDown: anInfiniteElement ])
				ifTrue: [ anEvent vector length ]
				ifFalse: [ (anEvent isScrollUp and: [ self canScrollUp: anInfiniteElement ])
					ifTrue: [ anEvent vector length negated ]
					ifFalse: [ 0 ] ] ]
		"we are horizontal => no vertical scroll"
		ifFalse: [ 0 ].

	anInfiniteElement smoothScrollBy: (dX @ dY) * self scrollingVelocity.
	anEvent consumed: (dY isZero not)
]

{ #category : #printing }
OBlInfiniteMouseScrollListener >> printOn: aStream [
	aStream 
		nextPutAll: 'Event handler of ';
		print: self eventClass.
]

{ #category : #accessing }
OBlInfiniteMouseScrollListener >> scrollingVelocity [

	^ self class scrollingVelocity
]

{ #category : #events }
OBlInfiniteMouseScrollListener >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
