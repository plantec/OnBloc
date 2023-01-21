Class {
	#name : #OBlAjacentRectanglesGeometry,
	#superclass : #BlPolygonGeometry,
	#category : #'OnBloc-Basic-Geometry'
}

{ #category : #accessing }
OBlAjacentRectanglesGeometry class >> oppositeDelimiterBackgroundColor [
	^ Color lightGray
]

{ #category : #accessing }
OBlAjacentRectanglesGeometry >> adjacentRectangles: aCollection [
	aCollection ifEmpty: [ ^ self ].
	self vertices: (self verticesFromRectangles: aCollection)
]

{ #category : #geometry }
OBlAjacentRectanglesGeometry >> matchElement: anElement [

	| bnds |
	bnds := Array streamContents: [ :aStream | 
		anElement children accountedByLayout do: [ :childElement | 
		aStream nextPut: ((childElement bounds inParent asRectangle expandBy: childElement margin asMargin) expandBy: anElement margin asMargin) ] ].
	self adjacentRectangles: bnds
]

{ #category : #'private - vertices computing' }
OBlAjacentRectanglesGeometry >> maxXRightCoord: yCoord fromRectangles: aListOfRectangles [
	" optimized with compiled in-line primitives "

	| l mostRight |
	l := self rectanglesAtY: yCoord fromRectangles: aListOfRectangles.
	mostRight := l first right.
	2 to: l size do: [ :pos | mostRight := mostRight max: (l at: pos) right ].
	^ mostRight
]

{ #category : #'private - vertices computing' }
OBlAjacentRectanglesGeometry >> minXLeftCoord: yCoord fromRectangles: aListOfRectangles [
	"optimized with compiled in-line primitives "

	| l mostLeft |
	l := self rectanglesAtY: yCoord fromRectangles: aListOfRectangles.
	mostLeft := l first left.
	2 to: l size do: [ :pos | mostLeft := mostLeft min: (l at: pos) left ].
	^ mostLeft
]

{ #category : #'private - vertices computing' }
OBlAjacentRectanglesGeometry >> rectanglesAtY: anY fromRectangles: aListOfRectangles [

	| rectsAtYExcBottomLines |
	rectsAtYExcBottomLines := self rectsAtYExcBottomLines: anY fromRectangles: aListOfRectangles.
	rectsAtYExcBottomLines ifNotEmpty: [ ^ rectsAtYExcBottomLines ].
	^ self rectsAtYIncBottomLines: anY fromRectangles: aListOfRectangles
]

{ #category : #'private - vertices computing' }
OBlAjacentRectanglesGeometry >> rectsAtYExcBottomLines: anY fromRectangles: aListOfRectangles [

	^ Array streamContents: [ :stream | aListOfRectangles do: [ :rect |
			(rect top <= anY and: [ rect bottom > anY ]) ifTrue: [ stream nextPut: rect ] ]]
]

{ #category : #'private - vertices computing' }
OBlAjacentRectanglesGeometry >> rectsAtYIncBottomLines: anY fromRectangles: aListOfRectangles [

	^ Array streamContents: [ :stream | aListOfRectangles do: [ :rect |
			(rect top <= anY and: [ rect bottom = anY ]) ifTrue: [ stream nextPut: rect ] ]]
]

{ #category : #'private - vertices computing' }
OBlAjacentRectanglesGeometry >> verticesFromRectangles: aListOfRectangles [

	| ret yCoords previousLeftCoord previousRightCoord |
	ret := OrderedCollection new.
	yCoords := self yCoordsFromRectangles: aListOfRectangles.
	yCoords := yCoords sort: [ :a :b | a < b ].
	previousLeftCoord := 0.
	previousRightCoord := 0.
	yCoords do: [ :yCoord | 
		| minimumXLeftCoord maximumXRightCoord first |
		minimumXLeftCoord := self minXLeftCoord: yCoord fromRectangles: aListOfRectangles.
		maximumXRightCoord := self maxXRightCoord: yCoord fromRectangles: aListOfRectangles.
		first := yCoords first.
		yCoord = yCoords first
			ifTrue: [ ret add: minimumXLeftCoord @ yCoord ]
			ifFalse: [ 
				minimumXLeftCoord ~= previousLeftCoord ifTrue: [ ret add: previousLeftCoord @ yCoord beforeIndex: 1 ].
				ret add: minimumXLeftCoord @ yCoord beforeIndex: 1.
				maximumXRightCoord ~= previousRightCoord ifTrue: [ ret add: previousRightCoord @ yCoord ] ].
		ret add: maximumXRightCoord @ yCoord.
		previousLeftCoord := minimumXLeftCoord.
		previousRightCoord := maximumXRightCoord ].
	^ ret
]

{ #category : #'private - vertices computing' }
OBlAjacentRectanglesGeometry >> yCoordsFromRectangles: aListOfRectangles [

	| allBotoms allTops allCoords |
	allBotoms := aListOfRectangles collect: [ :rect | rect bottom ].
	allTops := aListOfRectangles collect: [ :rect | rect top ].
	allCoords := Set new.
	allCoords addAll: allTops.
	allCoords addAll: allBotoms.
	^ allCoords asArray
]
