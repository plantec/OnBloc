Class {
	#name : #OBlAjacentRectanglesGeometry,
	#superclass : #BlPolygonGeometry,
	#instVars : [
		'collector'
	],
	#category : #'OnBloc-Basic-Geometry'
}

{ #category : #accessing }
OBlAjacentRectanglesGeometry class >> oppositeDelimiterBackgroundColor [
	^ Color lightGray
]

{ #category : #accessing }
OBlAjacentRectanglesGeometry >> adjacentRectangles: aCollection [
	aCollection ifEmpty: [ ^ self ].
	self vertices: (OBlVerticesFromRectanglesOperator new verticesFromRectangles: aCollection)
]

{ #category : #accessing }
OBlAjacentRectanglesGeometry >> collector [

	^ collector
]

{ #category : #accessing }
OBlAjacentRectanglesGeometry >> collector: aValuable [

	" takes the PolyElement as argument "

	collector := aValuable
]

{ #category : #initialization }
OBlAjacentRectanglesGeometry >> initialize [ 

	super initialize.
	collector := [ :element | element children accountedByLayout ]
]

{ #category : #geometry }
OBlAjacentRectanglesGeometry >> matchElement: anElement [

	| bnds children |
	children := self collector value: anElement.
	bnds := Array streamContents: [ :aStream | 
		children do: [ :childElement | 
		aStream nextPut: ((childElement bounds inParent asRectangle expandBy: childElement margin asMargin) expandBy: anElement margin asMargin) ] ].
	self adjacentRectangles: bnds
]
