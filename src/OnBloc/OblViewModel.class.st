Class {
	#name : #OBlViewModel,
	#superclass : #OBlElementCompanion,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : #'OnBloc-element compagnion'
}

{ #category : #'event management accessing' }
OBlViewModel >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'api - hooks' }
OBlViewModel >> onInstalledIn: anElement [
	"Is sent when I am added to an element (or to the other actor which is added to the element)"
	super onInstalledIn: anElement.
	eventDispatcher := anElement editor eventDispatcher.	


]

{ #category : #'api - hooks' }
OBlViewModel >> onUninstalledIn: anElement [
	"Is sent when I am removed from an element (or from the other actor which was part of the element)"
	super onUninstalledIn: anElement.
	eventDispatcher := nil
]
