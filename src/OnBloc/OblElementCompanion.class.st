Class {
	#name : #OBlElementCompanion,
	#superclass : #Object,
	#traits : 'TObservable + TBlAnnouncerProvider',
	#classTraits : 'TObservable classTrait + TBlAnnouncerProvider classTrait',
	#instVars : [
		'userData'
	],
	#category : #'OnBloc-element compagnion'
}

{ #category : #converting }
OBlElementCompanion class >> asLook [
	^ self new asLook
]

{ #category : #initialization }
OBlElementCompanion >> initialize [
	self class initializeSlots: self.
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

{ #category : #accessing }
OBlElementCompanion >> userData [
	"Returns a Dictionary that holds application dependent and temporary objects.
	Be careful to limit the use of such facility and prefer clean instance variables when it is possible to define them.
	If a user data is used, to ensure maintainability, systematically define relevant accessors and a relase method to get, set and remove
	the user data. The use of the key (which is most of time a symbol ) inside other method is strongly not recommended
	"
	<return: #Dictionary>

	^ userData ifNil: [ userData := IdentityDictionary new ]
]
