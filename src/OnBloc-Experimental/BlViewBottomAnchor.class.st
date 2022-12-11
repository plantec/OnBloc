Class {
	#name : #BlViewBottomAnchor,
	#superclass : #BlViewEdgeAnchor,
	#category : #'OnBloc-Experimental-LayoutStrategy-Anchor-Support'
}

{ #category : #evaluating }
BlViewBottomAnchor >> value [
	"^ (view localPointToGlobal: self view layoutBounds bottomLeft) y."
	^ self view bounds inSpace bounds bottomLeft y
]
