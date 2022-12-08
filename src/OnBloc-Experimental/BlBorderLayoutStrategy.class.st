Class {
	#name : #BlBorderLayoutStrategy,
	#superclass : #BlLayoutStrategy,
	#instVars : [
		'managedSubviews'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy'
}

{ #category : #layout }
BlBorderLayoutStrategy >> centeredSubviewsOf: aMorph [
	^ managedSubviews select: [ :sm | sm layoutProperties isAtCenter ] 
]

{ #category : #layout }
BlBorderLayoutStrategy >> horizontalSubviewsOf: aMorph [
	^ managedSubviews
		select: [ :sm | sm layoutProperties isAtBottom or: [ sm layoutProperties isAtTop ] ] 
]

{ #category : #layout }
BlBorderLayoutStrategy >> layout: aMorph in: layoutBounds [
	| centerBounds |
	centerBounds := layoutBounds.
	managedSubviews := self managedSubviewsOf: aMorph.
	(self horizontalSubviewsOf: aMorph) do: [ :r | centerBounds := self layoutHorizontally: r inBounds: centerBounds ].
	(self verticalSubviewsOf: aMorph) do: [ :r | centerBounds := self layoutVertically: r inBounds: centerBounds ].
	(self centeredSubviewsOf: aMorph) do: [ :r | self updateView: r withBounds:  centerBounds  ].
	managedSubviews := nil	
]

{ #category : #layout }
BlBorderLayoutStrategy >> layoutHorizontally: aMorph inBounds: aRectangle [
	| extent |
	aMorph extent: (extent := aRectangle width @ aMorph height).
	aMorph
		layoutPropertiesDo: [ :lp | 
			lp isAtBottom
				ifTrue: [ 
					self updateView: aMorph withBounds: ((aRectangle bottomLeft - (0 @ aMorph height)) extent: extent).
					^ aRectangle topLeft corner: aRectangle corner - (0 @ aMorph height) ].
			self updateView: aMorph withBounds:  (aRectangle topLeft extent: extent).
			^ aRectangle topLeft + (0@ aMorph height ) corner: aRectangle bottomRight ]
]

{ #category : #layout }
BlBorderLayoutStrategy >> layoutVertically: aMorph inBounds: aRectangle [
	| extent |
	aMorph extent: (extent := aMorph width @ aRectangle height).
	aMorph
		layoutPropertiesDo: [ :lp | 
			lp isAtRight
				ifTrue: [ 
					self updateView: aMorph withBounds: ((aRectangle topRight - (aMorph width @ 0)) extent: extent).
					^ aRectangle topLeft corner: aRectangle corner - (aMorph width @ 0) ].
			self updateView: aMorph withBounds: (aRectangle topLeft extent: extent).
			^ (aRectangle topLeft + (aMorph width @ 0)) corner: aRectangle bottomRight ]
]

{ #category : #layout }
BlBorderLayoutStrategy >> managedSubviewsOf: aMorph [
	^ aMorph layoutComponents select: [ :sm | sm visible and: [sm canNotBeAnywhere ] ] 
]

{ #category : #layout }
BlBorderLayoutStrategy >> updateView: aView withBounds: aRectangle [
	| positioning |
	aView bounds: aRectangle.
	aView layoutProperties isAtCenter
		ifTrue: [ 
			aView privateCenter: aRectangle center.
			aView
				layoutPropertiesDo: [ :lp | 
					positioning := lp secondAxisProperties positioning.
					aView perform: positioning asMutator with: (aRectangle perform: positioning) ] ].
	aView
		layoutPropertiesDo: [ :lp | 
			positioning := lp secondAxisProperties positioning.
			aView perform: positioning asMutator with: (aRectangle perform: positioning) ]
]

{ #category : #layout }
BlBorderLayoutStrategy >> verticalSubviewsOf: aMorph [
	^ managedSubviews
		select: [ :sm | sm layoutProperties isAtLeft or: [ sm layoutProperties isAtRight ] ] 
]
