Class {
	#name : #BlViewEdgeAnchor,
	#superclass : #BlViewAnchor,
	#instVars : [
		'view'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy-Anchor-Support'
}

{ #category : #accessing }
BlViewEdgeAnchor >> view [

	^ view
]

{ #category : #accessing }
BlViewEdgeAnchor >> view: anObject [

	view := anObject
]

{ #category : #accessing }
BlViewEdgeAnchor >> viewLayoutBounds [
	^ view bounds
]
