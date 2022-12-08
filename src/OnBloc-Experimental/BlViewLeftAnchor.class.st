Class {
	#name : #BlViewLeftAnchor,
	#superclass : #BlViewEdgeAnchor,
	#category : #'OnBloc-Experimental-LayoutStrategy-Anchor-Support'
}

{ #category : #evaluating }
BlViewLeftAnchor >> value [
	^  (view localPointToGlobal: self view layoutBounds topLeft) x 
]
