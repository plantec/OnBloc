"
I define an interface between child manager and infinite element.
Child manager communicates with infinite element  only using my interface


"
Class {
	#name : #OBlInfiniteAbstractChildrenController,
	#superclass : #Object,
	#category : #'OnBloc-NotUsed-Infinite-Children'
}

{ #category : #'manager -> element' }
OBlInfiniteAbstractChildrenController >> addChild: anElement at: anIndex [
	"Add anElement as direct child to infinite element at anIndex.
	anElement must not be nil
	anIndex must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
OBlInfiniteAbstractChildrenController >> attachChild: anElement at: anIndex [
	"Adds child to infinite element without redraw or layout requests.
	anElement must not be nil.
	anIndex must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
OBlInfiniteAbstractChildrenController >> childAt: anIndex [
	"Return a child that is at anIndex in children collection
	of infinite element or nil if anIndex is out of range.
	anIndex must not be nil"
	<return: #BlElement or: nil>
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
OBlInfiniteAbstractChildrenController >> childIndexOf: aChildElement [
	"Return an index of aChildElement within children collection
	of infinite element or 0 if child is not a direct child of
	infinite element.
	aChildElement must not be nil.
	aChildElement must not be nil"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
OBlInfiniteAbstractChildrenController >> childrenCount [
	"Return amount of children in infinite element"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
OBlInfiniteAbstractChildrenController >> detachChildAt: anIndex [
	"Remove a child from infinite element at anIndex without
	redraw and layout requests.
	anIndex must not be nil"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
OBlInfiniteAbstractChildrenController >> elementHolderOf: anElement [
	"Return an element holder of the child element.
	ElementHolder can not be nil"
	<return: #BlInfiniteHolder>

	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
OBlInfiniteAbstractChildrenController >> removeAllChildren [
	"Remove all direct children from infinite element"
	
	^ self subclassResponsibility
]

{ #category : #'manager -> element' }
OBlInfiniteAbstractChildrenController >> removeChildAt: anIndex [
	"Remove a child at anIndex from infinite element.
	anIndex must not be nil"
	
	^ self subclassResponsibility
]
