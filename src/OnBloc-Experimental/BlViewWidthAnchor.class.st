Class {
	#name : #BlViewWidthAnchor,
	#superclass : #BlViewEdgeAnchor,
	#category : #'OnBloc-Experimental-LayoutStrategy-Anchor-Support'
}

{ #category : #evaluating }
BlViewWidthAnchor >> value [
	^ view layoutBounds width
]
