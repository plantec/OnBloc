Class {
	#name : #BlDummyLayoutStrategy,
	#superclass : #BlLayoutStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy'
}

{ #category : #accessing }
BlDummyLayoutStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #layout }
BlDummyLayoutStrategy >> doLayout: aView in: newBounds [

]
