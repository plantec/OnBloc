"
Sent when an element is detached from InfiniteElement.

Sent by:
  - BlInfiniteElement

Example:

infiniteElement
	addEventHandlerOn: OBlInfiniteElementDetachedEvent
	do: [ :event | self inform: 'Detached: ', event element asString ]

"
Class {
	#name : #OBlInfiniteElementDetachedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'OnBloc-Infinite-Events'
}

{ #category : #'instance creation' }
OBlInfiniteElementDetachedEvent class >> element: anElement [
	^ self new
		element: anElement;
		yourself
]

{ #category : #accessing }
OBlInfiniteElementDetachedEvent >> element [
	^ element
]

{ #category : #accessing }
OBlInfiniteElementDetachedEvent >> element: anObject [
	element := anObject
]
