Trait {
	#name : #TBlLayoutPropertiesOwner,
	#category : #'OnBloc-Experimental-Core-Traits'
}

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> anchorBottom: anAnchor [
	"set the receiver bottom anchor"
	self anchors at: #bottom put: anAnchor.
	self requestLayout
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> anchorLeft: anAnchor [
	"set the receiver left anchor"
	self anchors at: #left put: anAnchor.
	self requestLayout
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> anchorRight: anAnchor [
	"set the receiver right anchor"
	self anchors at: #right put: anAnchor.
	self requestLayout.

]

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> anchorTop: anAnchor [
	"set the receiver top anchor"
	self anchors at: #top put: anAnchor.
	self requestLayout
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> anchoredBoundsIn: newBounds [
	"answer the bounds of receiver by taking achors into account"
	| anchors left right top bottom box |
	anchors := self anchors.
	box := self localBoundsToGlobal: newBounds.
	left := anchors at: #left ifAbsent: [ box left ].
	right := anchors at: #right ifAbsent: [ box right ].
	top := anchors at: #top ifAbsent: [ box top ].
	bottom := anchors at: #bottom ifAbsent: [ box bottom ].
	^ (left value @ top value corner: right value @ bottom value)
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> anchors [
	"return all anchors that the layout strategy takes into account to compute the receiver bounds"

	^ self layoutProperties anchors
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> asColumnLayoutCell [
	" return a layout cell used by the BlBoxLayoutStrategy in case of a topToBottom direction "
	^ BlColumnLayoutCell new
		target: self;
		bounds: self bounds;
		yourself
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> asRowLayoutCell [
	" return a layout cell used by the BlBoxLayoutStrategy in case of a leftToRight or rightToLeft direction "
	^ BlRowLayoutCell new
		target: self;
		bounds: self bounds;
		yourself
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> bottomAnchor [
	"return a new anchor linked to the bottom of the receiver"
	^ BlViewBottomAnchor new view: self
]

{ #category : #'t-layout-properties-owner testing' }
TBlLayoutPropertiesOwner >> canBeAnywhere [
	^ self layoutProperties canBeAnywhere
]

{ #category : #'t-layout-properties-owner testing' }
TBlLayoutPropertiesOwner >> canNotBeAnywhere [
	^ self layoutProperties canNotBeAnywhere
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> extentRestriction [

	^ self layoutProperties extentRestriction
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> heightAnchor [
	"return a new anchor linked to the height of the receiver"
	^ BlViewHeightAnchor new view: self
]

{ #category : #layout }
TBlLayoutPropertiesOwner >> layoutBounds [

	^ self bounds
]

{ #category : #'as yet unclassified' }
TBlLayoutPropertiesOwner >> layoutProperties [
	^ self userData at: #layoutProperties ifAbsentPut: [ BlLayoutProperties new ]
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> layoutPropertiesDo: aBlock [
	aBlock value: self layoutProperties 
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> layoutPropertiesSecondAxisDo: aBlock [ 
	self layoutPropertiesDo: [:lp | lp secondAxisDo: aBlock ]
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> leftAnchor [
	"return a new anchor linked to the left of the receiver"
	^ BlViewLeftAnchor new view: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> maximalExtent [
	^ self extentRestriction maximalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> maximalExtent: anExtent [
	self extentRestriction
		maximalExtent: anExtent;
		updateMaximalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> maximalHeight [
	^ self extentRestriction maximalHeightOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> maximalHeight: aNumber [
	self extentRestriction
		maximalHeight: aNumber;
		updateMaximalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> maximalWidth [
	^ self extentRestriction maximalWidthOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> maximalWidth: aNumber [
	self extentRestriction
		maximalWidth: aNumber;
		updateMaximalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> minimalExtent [
	^ self extentRestriction minimalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> minimalExtent: anExtent [
	self extentRestriction
		minimalExtent: anExtent;
		updateMinimalExtentOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> minimalHeight [
	^ self extentRestriction minimalHeightOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> minimalHeight: aNumber [
	self extentRestriction
		minimalHeight: aNumber;
		updateMinimalExtentOf: self

]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> minimalWidth [
	^ self extentRestriction minimalWidthOf: self
]

{ #category : #'t-layout-properties-owner layout protocol' }
TBlLayoutPropertiesOwner >> minimalWidth: aNumber [
	self extentRestriction
		minimalWidth: aNumber;
		updateMinimalExtentOf: self
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> rightAnchor [
	"return a new anchor linked to the right of the receiver"
	^ BlViewRightAnchor new view: self
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> topAnchor [
	"return a new anchor linked to the top of the receiver"
	^ BlViewTopAnchor new view: self
]

{ #category : #'t-layout-properties-owner accessing anchors' }
TBlLayoutPropertiesOwner >> widthAnchor [
	"return a new anchor linked to the width of the receiver"
	^ BlViewWidthAnchor new view: self
]
