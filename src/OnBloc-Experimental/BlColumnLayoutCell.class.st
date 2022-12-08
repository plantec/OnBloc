Class {
	#name : #BlColumnLayoutCell,
	#superclass : #BlLayoutCell,
	#category : #'OnBloc-Experimental-LayoutStrategy-Box-Support'
}

{ #category : #layouting }
BlColumnLayoutCell >> computePosition [
	| p | 
	self left: self layout left.
	p := self secondAxisPositioning.
	self perform: p asMutator with: (self layout perform: p).
	self previous ifNil: [ self top: self layout top ] ifNotNil: [ :prev | self top: prev bottom ]
]

{ #category : #layouting }
BlColumnLayoutCell >> firstAxisSize [
	^ self height
]

{ #category : #layouting }
BlColumnLayoutCell >> firstAxisSize: aNumber [
	self height: aNumber
]

{ #category : #layouting }
BlColumnLayoutCell >> secondAxisSize [
	^ self width
]

{ #category : #layouting }
BlColumnLayoutCell >> secondAxisSize: aNumber [
	self width: aNumber
]
