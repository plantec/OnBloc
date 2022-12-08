Class {
	#name : #BlStackLayoutStrategy,
	#superclass : #BlLayoutStrategy,
	#category : #'OnBloc-Experimental-LayoutStrategy'
}

{ #category : #layout }
BlStackLayoutStrategy >> boundsOf: aMorph in: newBounds [
	"Layout specific. Apply the given bounds to the receiver after being layed out in its owner."

	| box |
	box := aMorph bounds.
	newBounds = box
		ifTrue: [ ^ box ].
	^ box translateBy: newBounds origin - aMorph position
]

{ #category : #layout }
BlStackLayoutStrategy >> layout: aMorph in: layoutBounds [
	"Compute the layout for the given morph based on the new bounds.
	Supports submorph hResizing, vResizing, cellInset, cellPositioning
	(top, *center, bottom*)."

	| newBounds subBounds mergedBounds positioning |
	aMorph layoutComponents ifEmpty: [ ^ self ].
	newBounds := layoutBounds.
	subBounds := OrderedCollection with: (self boundsOf: aMorph layoutComponents first in: newBounds).
	mergedBounds := subBounds first copy.
	2 to: aMorph layoutComponents size do: [ :p | 
		subBounds add: (self boundsOf: (aMorph layoutComponents at: p) in: newBounds).
		mergedBounds := mergedBounds merge: subBounds last ].	
	"align accordingly"
	aMorph layoutComponents
		with: subBounds
		do: [ :sm :sb | 
			sm layoutPropertiesDo: [ :lp | positioning := lp positioning ].
			sm bounds: (sb align: (sb perform: positioning) with: (mergedBounds perform: positioning)) ].	
	" compute the new extent given the layoutComponents bounds"
	newBounds := newBounds topLeft extent: aMorph layoutBounds extent.	
	"re-align accordingly"
	aMorph layoutComponents
		do: [ :sm | 
			sm layoutPropertiesDo: [ :lp | positioning := lp positioning ].
			sm bounds: (sm bounds align: (sm bounds perform: positioning) with: (newBounds perform: positioning)) ]
]
