Class {
	#name : #BlViewHeightAnchor,
	#superclass : #BlViewEdgeAnchor,
	#category : #'OnBloc-Experimental-LayoutStrategy-Anchor-Support'
}

{ #category : #evaluating }
BlViewHeightAnchor >> value [
	^ view layoutBounds height
]
