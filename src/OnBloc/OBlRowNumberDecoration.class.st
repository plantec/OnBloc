Class {
	#name : #OBlRowNumberDecoration,
	#superclass : #OBlInfinteSideDecoration,
	#instVars : [
		'actualWidth'
	],
	#category : #'OnBloc-Infinite'
}

{ #category : #initialization }
OBlRowNumberDecoration >> defaultWidth [
	^ 10
]

{ #category : #initialization }
OBlRowNumberDecoration >> initialize [
	super initialize.
	actualWidth := self defaultWidth.
	"highest priority"
	priority := 0
]

{ #category : #geometry }
OBlRowNumberDecoration >> onActualWidthChangeWith: anInteger do: aBlock [

	anInteger <= actualWidth ifTrue: [ ^ self ].
	actualWidth := anInteger.
	aBlock value
]

{ #category : #geometry }
OBlRowNumberDecoration >> requiredInsetsOfChildElement: anElement in: anInfiniteElement [

	^ BlInsets left: self requiredWidth + anInfiniteElement margin left
]

{ #category : #geometry }
OBlRowNumberDecoration >> requiredWidth [

	^ actualWidth  
]
