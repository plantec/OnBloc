Class {
	#name : #OBlResponse,
	#superclass : #BlEvent,
	#category : #'OnBloc-Events'
}

{ #category : #initialization }
OBlResponse >> reply: anObject [
	self subclassResponsibility
]
