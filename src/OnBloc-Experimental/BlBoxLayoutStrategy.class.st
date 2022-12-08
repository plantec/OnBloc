"
A ==BlBoxLayoutStrategy== is a strategy based on boxes. The container can be expanded based on its contents (==adaptExtentToContents==) or the inverse (==adaptContentsToExtent==). 
The direction in which contents is shifted can be controlled by ==beRightToLeft==, ==beLeftToRight==, ==beTopToBottom==, ==beBottomToTop==.
In addition a global padding can be specified using message ==padding:==. 

Here is a nice example
[ [ [ 
| m |
	m := BlMorph new
		layoutStrategy:
			(BlBoxLayoutStrategy new
				adaptExtentToContents;
				padding: 2;
				yourself).
	m
		withRectangleViewDo: [ :s | 
			s withSolidBorderDo: [ :b | b 
				width: 3;
				color: Color red;
				inset: 4 ] ].
	1 to: 4 do: [ :c | 
		| sm |
		sm := BlMorph new
			layoutStrategy:
				(BlBoxLayoutStrategy new
					adaptExtentToContents;
					beTopToBottom;
					padding: 2;
					yourself).
		sm layoutPropertiesSecondAxisDo: [ :a | a beAtCenter ].
		1 to: 4 do: [ :c2 | 
			| sm2 |
			sm2 := BlMorph new withRectangleViewDo: [ :v |  
					v color: Color white.
					v withSolidBorderDo: [ :b | b 
						width: 1;
						color: Color black].
					v addView: ((BlStringView string: c asString , '-' , c2 asString) position: 5 @ 5) ].
			sm addMorph: sm2 ].
		m addMorph: sm ].
	m extent: 600 @ 210.
	^ m
		openInWorld;
		yourself
]]]
"
Class {
	#name : #BlBoxLayoutStrategy,
	#superclass : #BlLayoutStrategy,
	#instVars : [
		'direction',
		'layout',
		'padding',
		'extentAdaptionPolicy'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy'
}

{ #category : #accessing }
BlBoxLayoutStrategy >> adaptContentsToExtent [
	extentAdaptionPolicy := #adaptContentsToExtent
]

{ #category : #accessing }
BlBoxLayoutStrategy >> adaptExtentToContents [
	extentAdaptionPolicy := #adaptExtentToContents
]

{ #category : #accessing }
BlBoxLayoutStrategy >> beBottomToTop [
	direction := #bottomToTop
]

{ #category : #accessing }
BlBoxLayoutStrategy >> beLeftToRight [
	direction := #leftToRight
]

{ #category : #accessing }
BlBoxLayoutStrategy >> beRightToLeft [
	direction := #rightToLeft
]

{ #category : #accessing }
BlBoxLayoutStrategy >> beTopToBottom [
	direction := #topTobottom
]

{ #category : #accessing }
BlBoxLayoutStrategy >> direction [
	"describes the direction in which a layout should be applied. Possible values are:
		#leftToRight
		#rightToLeft"

	^ direction
]

{ #category : #accessing }
BlBoxLayoutStrategy >> direction: aDirSymbol [
	"describes the direction in which a layout should be applied. Possible values are:
		#leftToRight
		#rightToLeft
		#bottomToTop
		#topToBottom"

	direction := aDirSymbol
]

{ #category : #accessing }
BlBoxLayoutStrategy >> extentAdaptionPolicy [
	^ extentAdaptionPolicy
]

{ #category : #accessing }
BlBoxLayoutStrategy >> extentAdaptionPolicy: aSymbol [
	extentAdaptionPolicy := aSymbol
]

{ #category : #initialization }
BlBoxLayoutStrategy >> initialize [ 
	super initialize.
	direction := #leftToRight.
	padding := 0.
	self adaptExtentToContents

]

{ #category : #testing }
BlBoxLayoutStrategy >> isAdaptingContentsToExtent [
	^ extentAdaptionPolicy = #adaptContentsToExtent
]

{ #category : #testing }
BlBoxLayoutStrategy >> isAdaptingExtentToContents [
	^ extentAdaptionPolicy = #adaptExtentToContents
]

{ #category : #testing }
BlBoxLayoutStrategy >> isBottomToTop [
	^ direction = #bottomToTop
]

{ #category : #layout }
BlBoxLayoutStrategy >> isHorizontal [
	^ self isLeftToRight or: [ self isRightToLeft ]
]

{ #category : #testing }
BlBoxLayoutStrategy >> isLeftToRight [
	^ direction = #leftToRight
]

{ #category : #testing }
BlBoxLayoutStrategy >> isRightToLeft [
	^ direction = #rightToLeft
]

{ #category : #testing }
BlBoxLayoutStrategy >> isTopToBottom [
	^ direction = #topToBottom
]

{ #category : #layout }
BlBoxLayoutStrategy >> layout: aTarget in: newBounds [

	layout := self newLayout
		target: aTarget;
		bounds: newBounds;
		yourself.
	layout perform: self extentAdaptionPolicy.
	aTarget changed
]

{ #category : #layout }
BlBoxLayoutStrategy >> newLayout [
	| cls |
	cls := self isHorizontal
		ifTrue: [ BlRowLayout ]
		ifFalse: [ BlColumnLayout ].
	^ cls new
		strategy: self;
		yourself
]

{ #category : #accessing }
BlBoxLayoutStrategy >> padding [
	^ padding
]

{ #category : #accessing }
BlBoxLayoutStrategy >> padding: anObject [
	padding := anObject asInteger
]
