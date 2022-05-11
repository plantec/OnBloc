Class {
	#name : #OblViewModel,
	#superclass : #OblElementCompanion,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : #'OnBloc-element compagnion'
}

{ #category : #'event management accessing' }
OblViewModel >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'api - hooks' }
OblViewModel >> onInstalledIn: anElement [
	"Is sent when I am added to an element (or to the other actor which is added to the element)"
	super onInstalledIn: anElement.
	eventDispatcher := anElement eventDispatcher.	


]

{ #category : #'api - hooks' }
OblViewModel >> onUninstalledIn: anElement [
	"Is sent when I am removed from an element (or from the other actor which was part of the element)"
	super onUninstalledIn: anElement.
	eventDispatcher := nil
]

{ #category : #'event management' }
OblViewModel >> request: aRequest [

	self dispatchEvent: aRequest.

	^ aRequest response
]

{ #category : #'event management' }
OblViewModel >> when: aRequestClass reply: aBlock [
	self when: aRequestClass do: [ :aRequest |
		| aReplyEvent |
		
		aRequest consumed: true.

		aReplyEvent := aBlock cull: (aRequest responseFor: self) cull: aRequest.

		aRequest canRespond
			ifTrue: [ aRequest response: aReplyEvent ].

		aReplyEvent source: self.
		
		aRequest isConsumed ifTrue: [ 
			aRequest isOneWay ifFalse: [ 
				self dispatchEvent: aReplyEvent ] ] ]
]
