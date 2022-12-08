Class {
	#name : #BlRowLayoutCell,
	#superclass : #BlLayoutCell,
	#category : #'OnBloc-Experimental-LayoutStrategy-Box-Support'
}

{ #category : #layouting }
BlRowLayoutCell >> computePosition [
	| p | 
	self top: self layout top.
	p := self secondAxisPositioning.
	self perform: p asMutator with: (self layout perform: p).
	self previous ifNil: [ self left: self layout left ] ifNotNil: [ :prev | self left: prev right ]
]

{ #category : #layouting }
BlRowLayoutCell >> firstAxisSize [
	^ self width
]

{ #category : #layouting }
BlRowLayoutCell >> firstAxisSize: aNumber [
	self width: aNumber
]

{ #category : #layouting }
BlRowLayoutCell >> secondAxisSize [
	^ self height
]

{ #category : #layouting }
BlRowLayoutCell >> secondAxisSize: aNumber [
	self height: aNumber
]
