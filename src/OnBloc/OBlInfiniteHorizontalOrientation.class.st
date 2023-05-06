Class {
	#name : #OBlInfiniteHorizontalOrientation,
	#superclass : #OBlInfiniteLayoutOrientation,
	#category : #'OnBloc-Infinite-Layout'
}

{ #category : #testing }
OBlInfiniteHorizontalOrientation >> canScrollLeft: anInfiniteElement [
	"Return true if an infinite element can be scrolled left"
	<return: #Boolean>	
	| aFirstChild |

	aFirstChild := anInfiniteElement layout childAtPosition: 1.
	aFirstChild
		ifNil: [ ^ true ].
		
	aFirstChild position x < (anInfiniteElement layout paddingLeft) 
		ifTrue: [ ^ true ].
		
	^ false
]

{ #category : #testing }
OBlInfiniteHorizontalOrientation >> canScrollRight: anInfiniteElement [
	"Return true if an infinite element can be scrolled to the right"
	<return: #Boolean>	
	| aLastChild |
	
	aLastChild := anInfiniteElement layout childAtPosition: anInfiniteElement layout itemCount.
	aLastChild
		ifNil: [ ^ true ].

	aLastChild bounds inParent right > (anInfiniteElement width - anInfiniteElement layout paddingRight) 
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> decoratedEnd: anElement [
	^ (self layout decoratedRight: anElement) + anElement constraints margin right
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> decoratedEndInParent: anElement [

	^ (self layout boundsInParent: anElement includeDecoration: true) right
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> decoratedMeasurement: anElement [
	^ (self layout decoratedMeasuredWidth: anElement) + anElement constraints margin width
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> decoratedMeasurementInOther: anElement [
	^ (self layout decoratedMeasuredHeight: anElement) + anElement constraints margin height
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> decoratedStart: anElement [
	^ (self layout decoratedLeft: anElement) - anElement constraints margin left
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> decoratedStartInParent: anElement [

	^ (self layout boundsInParent: anElement includeDecoration: true) left
]

{ #category : #geometry }
OBlInfiniteHorizontalOrientation >> end [
	^ self layout width
]

{ #category : #geometry }
OBlInfiniteHorizontalOrientation >> endWithPadding [
	<return: #Number>

	^ self layout width - self layout paddingRight
]

{ #category : #testing }
OBlInfiniteHorizontalOrientation >> isHorizontal [
	^ true
]

{ #category : #testing }
OBlInfiniteHorizontalOrientation >> isVertical [
	^ false
]

{ #category : #geometry }
OBlInfiniteHorizontalOrientation >> maximumSpace [
	<return: #Number>

	^ self layout maximumWidth
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> measurementSpec [
	^ self layout widthSpec
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> measurementSpecInOther [
	^ self layout heightSpec
]

{ #category : #'mouse handlers' }
OBlInfiniteHorizontalOrientation >> mouseWheelEvent: anEvent [
	| dX anInfiniteElement isHorizontal |

	anEvent vector isZero
		ifTrue: [ ^ self ].

	anInfiniteElement := anEvent currentTarget.
	
	isHorizontal := anEvent vector x abs > anEvent vector y abs.
	
	isHorizontal ifFalse: [ ^ self ].

	dX := (anEvent isScrollLeft and: [ self canScrollLeft: anInfiniteElement ])
				ifTrue: [ anEvent vector length negated ]
				ifFalse: [ (anEvent isScrollRight and: [ self canScrollRight: anInfiniteElement ])
					ifTrue: [ anEvent vector length ]
					ifFalse: [ 0 ] ].

	dX isZero ifTrue: [ ^ self ].

	anInfiniteElement smoothScrollBy: (dX @ 0) * 200.
	anEvent consumed: true
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> moveChild: anElement by: aNumber [
	anElement position: (anElement position x + aNumber) @ anElement position y
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> moveChildrenBy: aNumber [
	self layout offsetChildrenHorizontallyBy: aNumber
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> paddingEnd [
	^ self layout paddingRight
]

{ #category : #'children - geometry' }
OBlInfiniteHorizontalOrientation >> paddingStart [
	^ self layout paddingLeft
]

{ #category : #geometry }
OBlInfiniteHorizontalOrientation >> startWithPadding [
	<return: #Number>

	^ self layout paddingLeft
]
