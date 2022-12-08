Class {
	#name : #BlLayoutElement,
	#superclass : #Object,
	#instVars : [
		'strategy',
		'targetReference',
		'position',
		'extent'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy-Box-Support'
}

{ #category : #accessing }
BlLayoutElement >> bottom [

	^ self position y + self extent y
]

{ #category : #accessing }
BlLayoutElement >> bottom: aNumber [
	" Move me so that my bottom is at the y-coordinate aNumber. My extent (width & height) are unchanged "

	self position: (self left @ (aNumber - self height))
]

{ #category : #accessing }
BlLayoutElement >> bounds [
	^ self position extent: self extent

]

{ #category : #accessing }
BlLayoutElement >> bounds: aRectangle [
	self position: aRectangle topLeft.
	self extent: aRectangle extent
]

{ #category : #accessing }
BlLayoutElement >> center [
	" Set my height; my position (top-left corner) and width will remain the same "
	^ self bounds center
]

{ #category : #accessing }
BlLayoutElement >> center: aPoint [
	" Set my height; my position (top-left corner) and width will remain the same "

	self position: (aPoint - (self extent // 2))
]

{ #category : #accessing }
BlLayoutElement >> extent [
	^ extent
]

{ #category : #accessing }
BlLayoutElement >> extent: anExtent [
	extent := anExtent asPoint
]

{ #category : #accessing }
BlLayoutElement >> height [
	^ self extent y
]

{ #category : #accessing }
BlLayoutElement >> height: aNumber [
	" Set my height; my position (top-left corner) and width will remain the same "

	self extent: self width @ aNumber asInteger.

]

{ #category : #accessing }
BlLayoutElement >> left [

	^ self position x 
]

{ #category : #accessing }
BlLayoutElement >> left: aNumber [
	" Move me so that my left side is at the x-coordinate aNumber. My extent (width & height) are unchanged "

	self position: (aNumber @ self top)
]

{ #category : #accessing }
BlLayoutElement >> nop [
]

{ #category : #accessing }
BlLayoutElement >> nop: notUsed [
]

{ #category : #accessing }
BlLayoutElement >> position [
	^position
]

{ #category : #accessing }
BlLayoutElement >> position: aPoint [
	position := aPoint asPoint
]

{ #category : #accessing }
BlLayoutElement >> right [

	^ self position x + self extent x
]

{ #category : #accessing }
BlLayoutElement >> right: aNumber [
	" Move me so that my right side is at the x-coordinate aNumber. My extent (width & height) are unchanged "

	self position: ((aNumber - self width) @ self top)
]

{ #category : #accessing }
BlLayoutElement >> strategy [
	^ strategy
]

{ #category : #accessing }
BlLayoutElement >> strategy: aLayoutStrategy [
	strategy := aLayoutStrategy
]

{ #category : #accessing }
BlLayoutElement >> target [
	^ targetReference ifNotNil: [ :tr | tr at: 1 ]
]

{ #category : #accessing }
BlLayoutElement >> target: anObject [
	targetReference := WeakArray with: anObject.

]

{ #category : #accessing }
BlLayoutElement >> top [
	" Return the y-coordinate of my top side "

	^ self position y
]

{ #category : #accessing }
BlLayoutElement >> top: aNumber [
	" Move me so that my top is at the y-coordinate aNumber. My extent (width & height) are unchanged "

	self position: (self left @ aNumber)
]

{ #category : #accessing }
BlLayoutElement >> width [
	^ self extent x
]

{ #category : #accessing }
BlLayoutElement >> width: aNumber [
	" Set my width; my position (top-left corner) and height will remain the same "

	self extent: aNumber asInteger@self height.

]
