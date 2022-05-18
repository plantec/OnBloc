Class {
	#name : #OBlElementCompanion,
	#superclass : #Object,
	#category : #'OnBloc-element compagnion'
}

{ #category : #converting }
OBlElementCompanion class >> asLook [
	^ self new asLook
]

{ #category : #converting }
OBlElementCompanion >> asLook [
	^ self
]

{ #category : #'api - hooks' }
OBlElementCompanion >> onInstalledIn: anElement [

]

{ #category : #'api - hooks' }
OBlElementCompanion >> onUninstalledIn: anElement [
	"Is sent when I am removed from an element (or from the other actor which was part of the element)"
	self removeEventHandlersFromWidget: anElement.

]

{ #category : #'private - event management' }
OBlElementCompanion >> removeEventHandlersFromWidget: anElement [
	anElement removeEventHandlersSuchThat: [ :eachEventHandler | 
		self flag: 'how to remove my eventHandler ? '.
		true
		"eachEventHandler eventTarget == anElement" ]
]
