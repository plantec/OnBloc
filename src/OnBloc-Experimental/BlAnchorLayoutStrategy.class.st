Class {
	#name : #BlAnchorLayoutStrategy,
	#superclass : #BlLayout,
	#category : #'OnBloc-Experimental-LayoutStrategy'
}

{ #category : #layout }
BlAnchorLayoutStrategy >> layout: anElement in: aRectangle context: aBlElementBoundsUpdater [

	anElement children accountedByLayout do: [ :child |
		| childLayoutBounds |
		childLayoutBounds := child constraints position extent: child measuredExtent.
		child applyLayoutIn: childLayoutBounds context: aBlElementBoundsUpdater].
	self layoutIgnored: anElement context: aBlElementBoundsUpdater
]

{ #category : #layout }
BlAnchorLayoutStrategy >> measure: anElement with: anExtentSpec [

	super measure: anElement with: anExtentSpec
]
