Class {
	#name : #OblElementCompanion,
	#superclass : #Object,
	#category : #'OnBloc-element compagnion'
}

{ #category : #converting }
OblElementCompanion class >> asLook [
	^ self new asLook
]

{ #category : #converting }
OblElementCompanion >> asLook [
	^ self
]

{ #category : #'api - hooks' }
OblElementCompanion >> onInstalledIn: anElement [

]

{ #category : #'api - hooks' }
OblElementCompanion >> onUninstalledIn: anElement [
	"Is sent when I am removed from an element (or from the other actor which was part of the element)"
	self removeEventHandlersFromWidget: anElement.

]

{ #category : #'private - event management' }
OblElementCompanion >> removeEventHandlersFromWidget: anElement [
	anElement removeEventHandlersSuchThat: [ :eachEventHandler | 
		self flag: 'how to remove my eventHandler ? '.
		true
		"eachEventHandler eventTarget == anElement" ]
]
