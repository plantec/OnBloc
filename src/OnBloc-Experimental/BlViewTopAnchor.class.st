Class {
	#name : #BlViewTopAnchor,
	#superclass : #BlViewEdgeAnchor,
	#category : #'OnBloc-Experimental-LayoutStrategy-Anchor-Support'
}

{ #category : #evaluating }
BlViewTopAnchor >> value [
	^ (view localPointToGlobal: self view layoutBounds topRight) y 
]
