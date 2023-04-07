Class {
	#name : #OBlElement,
	#superclass : #BlElement,
	#category : #'OnBloc-Basic'
}

{ #category : #'api - space' }
OBlElement >> attachSpace [
	spaceReference := BlAttachedSpaceReference uniqueInstance.
	
	"It is possible that an element requested focus while being temporarily
	detached from the space. We have to requestFocus again, otherwise the focus
	request will never reach the space.
	(https://github.com/feenkcom/gtoolkit/issues/1457)"
	self isFocused
		ifTrue: [ self requestFocus: self ]
		ifFalse: [
			self space focusOwner == self
				ifTrue: [ self loseFocus: self ] ].

	self space enqueueTasksFrom: self taskQueue.

	"It is possible that an element requested itself to repaint while
	being temporarily detached from the space. If we do not resume
	propagation of the repainting request, elements wanting a composition layer
	will not be repainted (https://github.com/feenkcom/gtoolkit/issues/1459)"
	self needsPaint
		ifTrue: [ self markNeedsPaintFrom: self ].

	"self needsStyle
		ifTrue: [ self requestStyle ].

	self needsPropertiesComputation
		ifTrue: [ self requestPropertiesComputation ]"
]

{ #category : #accessing }
OBlElement >> states [

	^ nil
]

{ #category : #accessing }
OBlElement >> styles [

	^ nil
]
