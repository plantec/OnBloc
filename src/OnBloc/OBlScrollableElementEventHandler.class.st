Class {
	#name : #OBlScrollableElementEventHandler,
	#superclass : #BlEventListener,
	#category : #'OnBloc-Scrollable-Core'
}

{ #category : #'mouse handlers' }
OBlScrollableElementEventHandler >> mouseWheelEvent: anEvent [
	| aScrollHappened |
	
	"I implement touch support, so ignore fake mouse wheel events"
	anEvent isTouch
		ifTrue: [ ^ self ].

	aScrollHappened := anEvent currentTarget scrollBy: (anEvent vector * 20) negated.
	anEvent consumed: aScrollHappened
]
