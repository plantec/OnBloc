Class {
	#name : #OBlElementCompanion,
	#superclass : #Object,
	#traits : 'TBlAnnouncerProvider',
	#classTraits : 'TBlAnnouncerProvider classTrait',
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

{ #category : #initialization }
OBlElementCompanion >> initialize [
	super initialize.
	announcer := Announcer new
]

{ #category : #'api - hooks' }
OBlElementCompanion >> onInstalledIn: anElement [

]

{ #category : #'api - hooks' }
OBlElementCompanion >> onUninstalledIn: anElement [
	"Is sent when I am removed from an element "
	self unsubscribe: anElement
]
