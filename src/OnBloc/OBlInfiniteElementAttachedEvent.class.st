"
Sent when an element is attached to InfiniteElement.

Sent by:
  - BlInfiniteElement

Example:

infiniteElement
	addEventHandlerOn: OBlInfiniteElementAttachedEvent
	do: [ :event | self inform: 'Atatched:  ', event element asString ]

"
Class {
	#name : #OBlInfiniteElementAttachedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'OnBloc-Infinite-Events'
}

{ #category : #'instance creation' }
OBlInfiniteElementAttachedEvent class >> element: anElement [
	^ self new
		element: anElement;
		yourself
]

{ #category : #accessing }
OBlInfiniteElementAttachedEvent >> element [
	^ element
]

{ #category : #accessing }
OBlInfiniteElementAttachedEvent >> element: anObject [
	element := anObject
]
