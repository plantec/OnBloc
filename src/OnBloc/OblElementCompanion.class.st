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
	"Is sent when I am removed from an element "
]
