Class {
	#name : #OblRequest,
	#superclass : #BlEvent,
	#instVars : [
		'response',
		'isOneWay'
	],
	#category : #'OnBloc-Events'
}

{ #category : #'instance creation' }
OblRequest class >> oneWay [
	^ self new oneWay
]

{ #category : #testing }
OblRequest >> canRespond [
	"Not all requests support responses, return true if I am one of them"
	<return: #Boolean>

	^ self responseClass = OblNoResponse
]

{ #category : #initialization }
OblRequest >> initialize [
	super initialize.
	
	response := self responseClass new.
	isOneWay := false.
	self canBePropagated: true
]

{ #category : #testing }
OblRequest >> isOneWay [
	^ isOneWay
]

{ #category : #accessing }
OblRequest >> oneWay [
	isOneWay := true
]

{ #category : #accessing }
OblRequest >> response [
	^ response
]

{ #category : #accessing }
OblRequest >> response: anObject [
	response := anObject
]

{ #category : #initialization }
OblRequest >> responseClass [
	<return: #'AlbResponse class'>

	^ OblNoResponse
]

{ #category : #accessing }
OblRequest >> responseFor: aWidgetModel [
	^ self response
]
