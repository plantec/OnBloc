Class {
	#name : #OBlInfiniteDecoration,
	#superclass : #Object,
	#instVars : [
		'computedBounds',
		'decorationInsets',
		'priority'
	],
	#category : #'OnBloc-Infinite'
}

{ #category : #geometry }
OBlInfiniteDecoration >> computedBounds [ 
	^ computedBounds ifNil: [ Rectangle origin: 0 asPoint corner: 0 asPoint]
]

{ #category : #geometry }
OBlInfiniteDecoration >> decorationInsets [
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ decorationInsets 
]

{ #category : #geometry }
OBlInfiniteDecoration >> getDecorationsInsetsOfChildElement: anElement [
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ decorationInsets := self requiredInsetsOfChildElement: anElement
]

{ #category : #geometry }
OBlInfiniteDecoration >> getDecorationsInsetsOfChildElement: anElement in: anInfiniteElement [
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ decorationInsets := self requiredInsetsOfChildElement: anElement in: anInfiniteElement 
]

{ #category : #initialization }
OBlInfiniteDecoration >> initialize [ 
	super initialize.
	decorationInsets := BlInsets empty
]

{ #category : #updating }
OBlInfiniteDecoration >> onLayoutDoneIn: anEditorElement remaining: remainingRectangle [

	| insets rbnds |
	insets := self decorationInsets.
	rbnds := remainingRectangle.
	insets left isZero ifFalse: [ | insetsLeft |
		insetsLeft := insets left .
		computedBounds := rbnds origin corner: rbnds left + insetsLeft @ rbnds bottom.
		^ rbnds left + insetsLeft @ rbnds top extent: rbnds extent ].
	insets top isZero ifFalse: [ 
		^ rbnds left @ rbnds top + insets top corner: rbnds corner ].
	insets right isZero ifFalse: [ | insetsRight |
		insetsRight := insets right + anEditorElement border width.
		computedBounds := rbnds right - insetsRight @ rbnds top corner: rbnds corner.
		^ rbnds origin corner: rbnds right - insetsRight @ rbnds bottom ].
	insets bottom isZero ifFalse: [ ^ rbnds origin corner: rbnds corner right @ rbnds bottom - insets bottom ].
	^ remainingRectangle
]

{ #category : #updating }
OBlInfiniteDecoration >> onScrollDoneIn: anEditorElement [
]

{ #category : #accessing }
OBlInfiniteDecoration >> priority [
	^ priority ifNil: [ priority := 0 ]
	
]

{ #category : #accessing }
OBlInfiniteDecoration >> priority: anInteger [
	priority := anInteger
	
]

{ #category : #geometry }
OBlInfiniteDecoration >> requiredInsetsOfChildElement: anElement [ 
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ BlInsets empty
]

{ #category : #geometry }
OBlInfiniteDecoration >> requiredInsetsOfChildElement: anElement in: anInfiniteElement [
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ BlInsets empty
]
