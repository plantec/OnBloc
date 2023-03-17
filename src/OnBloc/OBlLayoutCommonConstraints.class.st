Class {
	#name : #OBlLayoutCommonConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'constraints',
		'position',
		'margin',
		'padding',
		'minHeight',
		'minWidth',
		'maxHeight',
		'maxWidth',
		'ignoredByLayout',
		'previouslyAccessedConstraints',
		'previouslyAccessedConstraintsType',
		'accountTransformation'
	],
	#category : #'OnBloc-Layouts-Basic'
}

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> accountByLayout [
	"Makes an element with this constraits be accounted by layout (not ignored)"

	ignoredByLayout := false
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> accountTransformation [
	"Let the layout know that the element's transformation should be taken into account during layout"
	
	accountTransformation := true
]

{ #category : #'specific constraints accessing' }
OBlLayoutCommonConstraints >> at: aLayoutClass [
	"Return a layout constrait object specific for a given layout defined by its class.
	Returned constraint can not be nil"
	<return: #BlLayoutConstraints>
	| aConstraints |
	
	"In most cases there is only one layout-specific constraint that is accessed extremely often.
	We can optimize lookup for this particular case by storing a type of previously accessed constraint"
	previouslyAccessedConstraintsType == aLayoutClass
		ifTrue: [ ^ previouslyAccessedConstraints ].
	
	constraints
		ifNil: [ constraints := Dictionary new ].

	aConstraints := constraints
		at: aLayoutClass
		ifAbsentPut: [ aLayoutClass constraints ].

	"Store the reference to the constraints and its type for optimization purpose described above"
	previouslyAccessedConstraints := aConstraints.
	previouslyAccessedConstraintsType := aLayoutClass.
	
	^ aConstraints
	
]

{ #category : #initialization }
OBlLayoutCommonConstraints >> defaultHorizontal [
	^ BlLayoutCommonConstraintsAxis new
]

{ #category : #initialization }
OBlLayoutCommonConstraints >> defaultVertical [
	^ BlLayoutCommonConstraintsAxis new
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> doNotAccountTransformation [
	"Let the layout know that the element's transformation should *not* be taken into account during layout"
	
	accountTransformation := false
]

{ #category : #'specific constraints accessing' }
OBlLayoutCommonConstraints >> flow [
	^ self at: BlFlowLayout
]

{ #category : #'specific constraints accessing' }
OBlLayoutCommonConstraints >> frame [
	^ self at: BlFrameLayout
]

{ #category : #'specific constraints accessing' }
OBlLayoutCommonConstraints >> grid [
	^ self at: BlGridLayout
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> ignoreByLayout [
	"Makes an element with this constraits be ignored by layout.
	An element will still be measured but will not be taken into account
	while measuring and laying out other elements"

	ignoredByLayout := true
]

{ #category : #'specific constraints accessing' }
OBlLayoutCommonConstraints >> ignored [
	^ self at: BlIgnoredLayout
]

{ #category : #testing }
OBlLayoutCommonConstraints >> ignoredByLayout [
	"Return true if an element must be ignored by layout, otherwise false"
	<return: #Boolean>

	^ ignoredByLayout
]

{ #category : #'specific constraints accessing' }
OBlLayoutCommonConstraints >> infinite [
	^ self at: OBlInfiniteLayout
]

{ #category : #initialization }
OBlLayoutCommonConstraints >> initialize [
	super initialize.
	
	position := 0.0@0.0.
	
	margin := BlInsets empty.
	padding := BlInsets empty.

	maxHeight := Float infinity.
	maxWidth := Float infinity.
	minHeight := 0.0.
	minWidth := 0.0.
	
	ignoredByLayout := false.
	accountTransformation := false.
	
	"Initialzed lazily in at:"
	constraints := nil
]

{ #category : #'specific constraints accessing' }
OBlLayoutCommonConstraints >> linear [
	^ self at: BlLinearLayout
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> margin [
	"Return an immutable margin property,
	margin can not be nil"
	<return: #BlInsets>
	^ margin
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> margin: aBlMargin [
	"Change element's margin to aBlMargin"
	
	margin := aBlMargin
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> maxHeight [
	"Return a maximal height an element can have,
	maxHeight can not be nil,
	maxHeight is always non-negative"
	<return: #Number>
	^ maxHeight
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> maxHeight: aNumber [
	"Set maximal height to be aNumber,
	aNumber must not be nil
	aNumber must be non-negative (#isBlocPositive)"
	
	maxHeight := aNumber asFloat
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> maxWidth [
	"Return a maximal width an element can have,
	maxWidth can not be nil,
	maxWidth is always non-negative"
	<return: #Number>
	^ maxWidth
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> maxWidth: aNumber [
	"Set maximal width to be aNumber,
	aNumber must not be nil
	aNumber must be non-negative (#isBlocPositive)"
	
	maxWidth := aNumber asFloat
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> minHeight [
	"Return a minimal height an element can have,
	minHeight can not be nil or infinity"
	<return: #Number>
	^ minHeight
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> minHeight: aNumber [
	"Set minimal height to be aNumber,
	aNumber must not be nil
	aNumber must not be infinite
	aNumber must be non-negative (#isBlocPositive)"
	
	minHeight := aNumber asFloat
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> minWidth [
	"Return a minimal width an element can have,
	minWidth can not be nil or infinity"
	<return: #Number>
	^ minWidth
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> minWidth: aNumber [
	"Set minimal width to be aNumber,
	aNumber must not be nil
	aNumber must not be infinite
	aNumber must be non-negative (#isBlocPositive)"
		
	minWidth := aNumber asFloat
]

{ #category : #accessing }
OBlLayoutCommonConstraints >> other [
	^ constraints ifNil: [ ^ Dictionary new ]
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> padding [
	"Return an immutable padding property.
	The padding can not be nil"
	<return: #BlInsets>

	^ padding
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> padding: aBlPadding [
	"Change element's padding."
	
	padding := aBlPadding
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> position [
	<return: #Point>

	^ position
]

{ #category : #'api - constraints' }
OBlLayoutCommonConstraints >> position: aPoint [
	position := aPoint
]

{ #category : #'specific constraints accessing' }
OBlLayoutCommonConstraints >> relative [
	^ self at: BlRelativeLayout
]

{ #category : #testing }
OBlLayoutCommonConstraints >> shouldAccountTransformation [
	<return: #Boolean>

	^ accountTransformation
]

{ #category : #'specific constraints accessing' }
OBlLayoutCommonConstraints >> zoomable [
	^ self at: BlZoomableLayout
]
