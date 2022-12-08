Class {
	#name : #BlLayoutCell,
	#superclass : #BlLayoutElement,
	#instVars : [
		'layout',
		'next',
		'previous'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy-Box-Support'
}

{ #category : #enumerating }
BlLayoutCell >> do: aBlock [
	| curr |
	curr := self.
	[ curr notNil ]
		whileTrue: [ 
			aBlock value: curr.
			curr := curr next ]
]

{ #category : #accessing }
BlLayoutCell >> extent: anExtent [ 
	super extent: (self target allowedExtentFrom: anExtent)
]

{ #category : #layouting }
BlLayoutCell >> fillOwnerHeight [
	self height: layout height
]

{ #category : #layouting }
BlLayoutCell >> isFirstAxisFlexible [
	self target layoutPropertiesDo: [ :a | ^ a isFlexible ].
	^ false
]

{ #category : #layouting }
BlLayoutCell >> isSecondAxisFlexible [
	self target layoutPropertiesSecondAxisDo: [ :a | ^ a isFlexible ].
	^ false
]

{ #category : #accessing }
BlLayoutCell >> layout [
	^ layout
]

{ #category : #accessing }
BlLayoutCell >> layout: aLayout [ 
	layout := aLayout
]

{ #category : #accessing }
BlLayoutCell >> next [
	^ next
]

{ #category : #accessing }
BlLayoutCell >> next: aLayoutCellOrNil [
	next := aLayoutCellOrNil
]

{ #category : #layouting }
BlLayoutCell >> placeTarget [
	self target privatePosition: self position
]

{ #category : #accessing }
BlLayoutCell >> previous [
	^ previous
]

{ #category : #accessing }
BlLayoutCell >> previous: aLayoutCellOrNil [
	previous := aLayoutCellOrNil
]

{ #category : #layouting }
BlLayoutCell >> resizeTarget [
	self target extent: self extent
]

{ #category : #enumerating }
BlLayoutCell >> reverseDo: aBlock [
	| curr |
	curr := self.
	[ curr notNil ]
		whileTrue: [ 
			aBlock value: curr.
			curr := curr previous ]
]

{ #category : #accessing }
BlLayoutCell >> secondAxisPositioning [
	self target layoutPropertiesSecondAxisDo: [ :a | ^ a positioning ].
	^ #nop
]
