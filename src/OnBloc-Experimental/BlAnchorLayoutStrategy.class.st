Class {
	#name : #BlAnchorLayoutStrategy,
	#superclass : #BlLayoutStrategy,
	#category : #'OnBloc-Experimental-LayoutStrategy'
}

{ #category : #layout }
BlAnchorLayoutStrategy >> layout: aMorph in: newBounds [
	
	"Arrange the submorph based on anchors "
	" Warning: circular dependencies may exists in such a layout. Have to check this case "
	
	self flag: #broken.
	aMorph layoutComponentsDo: [ :sm | sm bounds: (aMorph globalBoundsToLocal: (sm anchoredBoundsIn: newBounds)) ].
]
