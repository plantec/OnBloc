Class {
	#name : #OBlInfiniteLayoutOrientation,
	#superclass : #Object,
	#instVars : [
		'lastTotalSpace',
		'layout'
	],
	#category : #'OnBloc-Infinite-Layout'
}

{ #category : #'children - geometry' }
OBlInfiniteLayoutOrientation >> decoratedEnd: anElement [
	"Return the end of the element including its decoration and margin"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'children - geometry' }
OBlInfiniteLayoutOrientation >> decoratedEndInParent: anElement [
	"Return the end of the Element after its matrix transformations are applied to its layout position.
	I am useful when trying to detect the visible edge of an element.
	Note: It include the decorations but do not include the margins"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'children - geometry' }
OBlInfiniteLayoutOrientation >> decoratedMeasurement: anElement [
	"Return the space occupied by an element in the current orientation including decorations and margins"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'children - geometry' }
OBlInfiniteLayoutOrientation >> decoratedMeasurementInOther: anElement [
	"Return the space occupied by an element in the perpendicular orientation including decorations and margins"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'children - geometry' }
OBlInfiniteLayoutOrientation >> decoratedStart: anElement [
	"Return the start of the element including its decoration and margin"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'children - geometry' }
OBlInfiniteLayoutOrientation >> decoratedStartInParent: anElement [
	"Return the start of the Element after its matrix transformations are applied to its layout position.
	I am useful when trying to detect the visible edge of an element.
	Note: It include the decorations but do not include the margins"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
OBlInfiniteLayoutOrientation >> end [
	"Return the end position of the layout without taking padding into account"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
OBlInfiniteLayoutOrientation >> endWithPadding [
	"Return the end position of the layout after the end padding is removed"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #testing }
OBlInfiniteLayoutOrientation >> isHorizontal [
	^ self subclassResponsibility
]

{ #category : #testing }
OBlInfiniteLayoutOrientation >> isVertical [
	^ self subclassResponsibility
]

{ #category : #accessing }
OBlInfiniteLayoutOrientation >> layout [
	^ layout
]

{ #category : #accessing }
OBlInfiniteLayoutOrientation >> layout: aLayout [
	layout := aLayout
]

{ #category : #layout }
OBlInfiniteLayoutOrientation >> layoutCompleted [
	"I record information like layout bounds that might be useful in the next layout calculations"
	lastTotalSpace := self totalSpace
]

{ #category : #geometry }
OBlInfiniteLayoutOrientation >> maximumSpace [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #geometry }
OBlInfiniteLayoutOrientation >> measurementSpec [
	"Return the MeasurementSpec for the current orientation from the InfiniteLayout"
	<return: #BlMeasurementSpec>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
OBlInfiniteLayoutOrientation >> measurementSpecInOther [
	"Return the MeasurementSpec for the perpendicular orientation from the InfiniteLayout"
	<return: #BlMeasurementSpec>

	^ self subclassResponsibility
]

{ #category : #'mouse handlers' }
OBlInfiniteLayoutOrientation >> mouseWheelEvent: anEvent [
	"Scroll an infinite element to a direction indicated by the event.
	The ${method:BlInfiniteMouseScrollOrientationLimitedListener>>#mouseWheelEvent:}$
	dispatches mouse wheel event processing to layouts. Layouts decides whether and how to scroll items.
	See ${method:BlInfiniteLinearLayout>>#mouseWheelEvent:}$"
	self subclassResponsibility
]

{ #category : #'children - geometry' }
OBlInfiniteLayoutOrientation >> moveChild: anElement by: aNumber [
	"Move a child element by offsetting its position by the given amount"
	
	self subclassResponsibility
]

{ #category : #'children - geometry' }
OBlInfiniteLayoutOrientation >> moveChildrenBy: aNumber [
	"Move all children by offsetting their positions by the given amount"
	
	self subclassResponsibility
]

{ #category : #geometry }
OBlInfiniteLayoutOrientation >> paddingEnd [
	"Returns the padding at the end of the layout.
	For horizontal orientation, this is the right padding and for vertical, this is the bottom padding.
	Note: I do not check whether the layout is RTL or not"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
OBlInfiniteLayoutOrientation >> paddingStart [
	"Returns the padding at the beginning of the layout.
	For horizontal orientation, this is the left padding and for vertical, this is the top padding.
	Note: I do not check whether the layout is RTL or not"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #invalidation }
OBlInfiniteLayoutOrientation >> reset [
	lastTotalSpace := nil.
	layout := nil
]

{ #category : #geometry }
OBlInfiniteLayoutOrientation >> startWithPadding [
	"Return the start position of the layout after the start padding is added"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
OBlInfiniteLayoutOrientation >> totalSpace [
	"Returns the total space to layout"
	<return: #Number>

	^ self endWithPadding - self startWithPadding
]

{ #category : #geometry }
OBlInfiniteLayoutOrientation >> totalSpaceChange [
	"Return the layout space change between the previous layout pass and current layout pass"
	<return: #Number>
	
	^ lastTotalSpace
		ifNil: [ 0 ]
		ifNotNil: [ :aNumber | self totalSpace - aNumber ]
]
