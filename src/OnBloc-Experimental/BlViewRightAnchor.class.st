Class {
	#name : #BlViewRightAnchor,
	#superclass : #BlViewEdgeAnchor,
	#category : #'OnBloc-Experimental-LayoutStrategy-Anchor-Support'
}

{ #category : #evaluating }
BlViewRightAnchor >> value [
	"^ (view localPointToGlobal: self view layoutBounds topRight) x "
		
	^ self view bounds inSpace bounds right
]
