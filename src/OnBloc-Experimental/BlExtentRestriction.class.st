Class {
	#name : #BlExtentRestriction,
	#superclass : #Object,
	#instVars : [
		'minimalWidth',
		'minimalHeight',
		'maximalWidth',
		'maximalHeight'
	],
	#category : #'OnBloc-Experimental-Core-Support'
}

{ #category : #initialization }
BlExtentRestriction >> defaultMaximalHeight [

	^ SmallInteger maxVal
]

{ #category : #initialization }
BlExtentRestriction >> defaultMaximalWidth [

	^ SmallInteger maxVal
]

{ #category : #initialization }
BlExtentRestriction >> defaultMinimalHeight [

	^ 0
]

{ #category : #initialization }
BlExtentRestriction >> defaultMinimalWidth [

	^ 0
]

{ #category : #'accessing setters' }
BlExtentRestriction >> extent: anExtent of: aView [
	aView extent = anExtent
		ifTrue: [ ^ self ].
	aView changedAround: [ aView privateExtent: anExtent ]
]

{ #category : #'accessing setters' }
BlExtentRestriction >> height: aNumber of: aView [
	aView extent: aView width @ aNumber asInteger
]

{ #category : #'accessing getters' }
BlExtentRestriction >> heightOf: aView [
	^ aView bounds height
]

{ #category : #initialization }
BlExtentRestriction >> initialize [
	super initialize.
	
	maximalHeight := self defaultMaximalHeight.
	maximalWidth := self defaultMaximalWidth.
	minimalHeight := self defaultMinimalHeight.
	minimalWidth := self defaultMinimalWidth
]

{ #category : #'accessing setters' }
BlExtentRestriction >> maximalExtent: aPoint [
	|e|
	e := aPoint asPoint.
	self
		maximalWidth: e x;
		maximalHeight: e y
]

{ #category : #'accessing getters' }
BlExtentRestriction >> maximalExtentOf: aView [

	^ (self maximalWidthOf: aView) @ (self maximalHeightOf: aView)
]

{ #category : #'accessing setters' }
BlExtentRestriction >> maximalHeight: anObject [
	maximalHeight := anObject
]

{ #category : #'accessing getters' }
BlExtentRestriction >> maximalHeightOf: aView [
	" returns maximal height of a View. Default implementation converts value to Number "
	^ maximalHeight asNumber
]

{ #category : #'accessing setters' }
BlExtentRestriction >> maximalWidth: anObject [
	maximalWidth := anObject
]

{ #category : #'accessing getters' }
BlExtentRestriction >> maximalWidthOf: aView [
	" returns maximal width of a View. Default implementation converts value to Number "
	^ maximalWidth asNumber
]

{ #category : #'accessing setters' }
BlExtentRestriction >> minimalExtent: aPoint [
	|e|
	e := aPoint asPoint.
	self
		minimalWidth: e x;
		minimalHeight: e y
]

{ #category : #'accessing getters' }
BlExtentRestriction >> minimalExtentOf: aView [

	^ (self minimalWidthOf: aView) @ (self minimalHeightOf: aView)
]

{ #category : #'accessing setters' }
BlExtentRestriction >> minimalHeight: anObject [
	minimalHeight := anObject
]

{ #category : #'accessing getters' }
BlExtentRestriction >> minimalHeightOf: aView [
	" returns minimal height of a View. Default implementation converts value to Number"
	^ minimalHeight asNumber
]

{ #category : #'accessing setters' }
BlExtentRestriction >> minimalWidth: anObject [
	minimalWidth := anObject
]

{ #category : #'accessing getters' }
BlExtentRestriction >> minimalWidthOf: aView [
	" returns minimal width of a View. Default implementation converts value to Number "
	^ minimalWidth asNumber
]

{ #category : #updating }
BlExtentRestriction >> updateMaximalExtentOf: aView [
	| e |
	e := aView extent.
	(e x > (self maximalWidthOf: aView))
		ifTrue: [ e := (self maximalWidthOf: aView) @ e y ].
	(e y > (self maximalHeightOf: aView))
		ifTrue: [ e := e x @ (self maximalHeightOf: aView) ].
	aView extent: e
]

{ #category : #updating }
BlExtentRestriction >> updateMinimalExtentOf: aView [
	| e |
	e := aView extent.
	(e x < (self minimalWidthOf: aView))
		ifTrue: [ e := (self minimalWidthOf: aView) @ e y ].
	(e y < (self minimalHeightOf: aView))
		ifTrue: [ e := e x @ (self minimalHeightOf: aView) ].
	aView extent: e
]

{ #category : #'accessing setters' }
BlExtentRestriction >> width: aNumber of: aView [
	aView extent: aNumber asInteger @ aView height
]

{ #category : #'accessing getters' }
BlExtentRestriction >> widthOf: aView [
	^ aView bounds width
]
