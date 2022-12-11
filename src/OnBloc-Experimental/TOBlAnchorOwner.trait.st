Trait {
	#name : #TOBlAnchorOwner,
	#category : #'OnBloc-Experimental-Core-Traits'
}

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> anchorBottom: anAnchor [
	"set the receiver bottom anchor"
	self anchors at: #bottom put: anAnchor.
	self requestLayout
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> anchorLeft: anAnchor [
	"set the receiver left anchor"
	self anchors at: #left put: anAnchor.
	self requestLayout
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> anchorRight: anAnchor [
	"set the receiver right anchor"
	self anchors at: #right put: anAnchor.
	self requestLayout.

]

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> anchorTop: anAnchor [
	"set the receiver top anchor"
	self anchors at: #top put: anAnchor.
	self requestLayout
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> anchoredBoundsIn: newBounds [
	"answer the bounds of receiver by taking achors into account"
	| anchors left right top bottom box |
	anchors := self anchors.
	box := self localBoundsToGlobal: newBounds.
	left := anchors at: #left ifAbsent: [ box left ].
	right := anchors at: #right ifAbsent: [ box right ].
	top := anchors at: #top ifAbsent: [ box top ].
	bottom := anchors at: #bottom ifAbsent: [ box bottom ].
	^ BlBounds fromRectangle: (left value @ top value corner: right value @ bottom value)
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> anchors [
	"return all anchors that the layout strategy takes into account to compute the receiver bounds"

	^ self userData at: #anchors ifAbsentPut: [ Dictionary new ]
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> asColumnLayoutCell [
	" return a layout cell used by the BlBoxLayoutStrategy in case of a topToBottom direction "
	^ BlColumnLayoutCell new
		target: self;
		bounds: self bounds;
		yourself
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> asRowLayoutCell [
	" return a layout cell used by the BlBoxLayoutStrategy in case of a leftToRight or rightToLeft direction "
	^ BlRowLayoutCell new
		target: self;
		bounds: self bounds;
		yourself
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> bottomAnchor [
	"return a new anchor linked to the bottom of the receiver"
	^ BlViewBottomAnchor new view: self
]

{ #category : #'t-layout-properties-owner testing' }
TOBlAnchorOwner >> canBeAnywhere [
	^ self layoutProperties canBeAnywhere
]

{ #category : #'t-layout-properties-owner testing' }
TOBlAnchorOwner >> canNotBeAnywhere [
	^ self layoutProperties canNotBeAnywhere
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> extentRestriction [

	^ self layoutProperties extentRestriction
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> heightAnchor [
	"return a new anchor linked to the height of the receiver"
	^ BlViewHeightAnchor new view: self
]

{ #category : #layout }
TOBlAnchorOwner >> layoutBounds [

	^ self bounds
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> layoutPropertiesDo: aBlock [
	aBlock value: self layoutProperties 
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> layoutPropertiesSecondAxisDo: aBlock [ 
	self layoutPropertiesDo: [:lp | lp secondAxisDo: aBlock ]
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> leftAnchor [
	"return a new anchor linked to the left of the receiver"
	^ BlViewLeftAnchor new view: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> maximalExtent [
	^ self extentRestriction maximalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> maximalExtent: anExtent [
	self extentRestriction
		maximalExtent: anExtent;
		updateMaximalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> maximalHeight [
	^ self extentRestriction maximalHeightOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> maximalHeight: aNumber [
	self extentRestriction
		maximalHeight: aNumber;
		updateMaximalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> maximalWidth [
	^ self extentRestriction maximalWidthOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> maximalWidth: aNumber [
	self extentRestriction
		maximalWidth: aNumber;
		updateMaximalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> minimalExtent [
	^ self extentRestriction minimalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> minimalExtent: anExtent [
	self extentRestriction
		minimalExtent: anExtent;
		updateMinimalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> minimalHeight [
	^ self extentRestriction minimalHeightOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> minimalHeight: aNumber [
	self extentRestriction
		minimalHeight: aNumber;
		updateMinimalExtentOf: self

]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> minimalWidth [
	^ self extentRestriction minimalWidthOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TOBlAnchorOwner >> minimalWidth: aNumber [
	self extentRestriction
		minimalWidth: aNumber;
		updateMinimalExtentOf: self
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> rightAnchor [
	"return a new anchor linked to the right of the receiver"
	^ BlViewRightAnchor new view: self
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> topAnchor [
	"return a new anchor linked to the top of the receiver"
	^ BlViewTopAnchor new view: self
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TOBlAnchorOwner >> widthAnchor [
	"return a new anchor linked to the width of the receiver"
	^ BlViewWidthAnchor new view: self
]
