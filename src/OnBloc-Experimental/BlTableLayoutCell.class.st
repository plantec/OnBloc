Class {
	#name : #BlTableLayoutCell,
	#superclass : #BlLayoutCell,
	#category : #'OnBloc-Experimental-LayoutStrategy-Box-Support'
}

{ #category : #layouting }
BlTableLayoutCell >> computePosition [
	| p | 
	self left: self layout left.
	p := self secondAxisPositioning.
	self perform: p asMutator with: (self layout perform: p).
	self previous ifNil: [ self top: self layout top ] ifNotNil: [ :prev | self top: prev bottom ]
]

{ #category : #layouting }
BlTableLayoutCell >> firstAxisSize [
	^ self height
]

{ #category : #layouting }
BlTableLayoutCell >> firstAxisSize: aNumber [
	self height: aNumber
]

{ #category : #layouting }
BlTableLayoutCell >> secondAxisSize [
	^ self width
]

{ #category : #layouting }
BlTableLayoutCell >> secondAxisSize: aNumber [
	self width: aNumber
]
