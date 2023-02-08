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
	^ 22
]

{ #category : #initialization }
OBlRowNumberDecoration >> initialize [
	super initialize.
	actualWidth := self defaultWidth.
	"highest priority"
	priority := 0
]

{ #category : #geometry }
OBlRowNumberDecoration >> numberVerticalHeightIn: anItemElement fontHeight: fontHeight [

	" By default, the row number is centered vertically"
	^ (anItemElement height - fontHeight) / 2
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
