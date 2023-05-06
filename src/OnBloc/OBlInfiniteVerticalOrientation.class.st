Class {
	#name : #OBlInfiniteVerticalOrientation,
	#superclass : #OBlInfiniteLayoutOrientation,
	#category : #'OnBloc-Infinite-Layout'
}

{ #category : #testing }
OBlInfiniteVerticalOrientation >> canScrollDown: anInfiniteElement [
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

{ #category : #testing }
OBlInfiniteVerticalOrientation >> canScrollUp: anInfiniteElement [
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

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> decoratedEnd: anElement [
	^ (self layout decoratedBottom: anElement) + anElement constraints margin bottom
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> decoratedEndInParent: anElement [

	^ (self layout boundsInParent: anElement includeDecoration: true) bottom
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> decoratedMeasurement: anElement [
	^ (self layout decoratedMeasuredHeight: anElement) + anElement constraints margin height
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> decoratedMeasurementInOther: anElement [
	^ (self layout decoratedMeasuredWidth: anElement) + anElement constraints margin width
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> decoratedStart: anElement [
	^ (self layout decoratedTop: anElement) - anElement constraints margin top
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> decoratedStartInParent: anElement [

	^ (self layout boundsInParent: anElement includeDecoration: true) top
]

{ #category : #geometry }
OBlInfiniteVerticalOrientation >> end [
	^ self layout height
]

{ #category : #geometry }
OBlInfiniteVerticalOrientation >> endWithPadding [
	^ self layout height - self layout paddingBottom
]

{ #category : #testing }
OBlInfiniteVerticalOrientation >> isHorizontal [
	^ false
]

{ #category : #testing }
OBlInfiniteVerticalOrientation >> isVertical [
	^ true
]

{ #category : #geometry }
OBlInfiniteVerticalOrientation >> maximumSpace [
	<return: #Number>

	^ self layout maximumHeight
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> measurementSpec [
	^ self layout heightSpec
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> measurementSpecInOther [
	^ self layout widthSpec
]

{ #category : #'mouse handlers' }
OBlInfiniteVerticalOrientation >> mouseWheelEvent: anEvent [
	| dY anInfiniteElement isHorizontal |

	anEvent vector isZero ifTrue: [ ^ self ].

	anInfiniteElement := anEvent currentTarget.
	
	isHorizontal := anEvent vector x abs > anEvent vector y abs.
	isHorizontal ifTrue: [ ^ self ].

	dY := (anEvent isScrollDown and: [ self canScrollDown: anInfiniteElement ])
				ifTrue: [ anEvent vector length ]
				ifFalse: [ (anEvent isScrollUp and: [ self canScrollUp: anInfiniteElement ])
					ifTrue: [ anEvent vector length negated ]
					ifFalse: [ 0 ] ].

	dY isZero ifTrue: [ ^ self ].

	anInfiniteElement smoothScrollBy: (0 @ dY) * 200.
	anEvent consumed: true.
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> moveChild: anElement by: aNumber [
	anElement position: anElement position x @ (anElement position y + aNumber)
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> moveChildrenBy: aNumber [
	self layout offsetChildrenVerticallyBy: aNumber
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> paddingEnd [
	^ self layout paddingBottom
]

{ #category : #'children - geometry' }
OBlInfiniteVerticalOrientation >> paddingStart [
	^ self layout paddingTop
]

{ #category : #geometry }
OBlInfiniteVerticalOrientation >> startWithPadding [
	^ self layout paddingTop
]
