Class {
	#name : #OblResponse,
	#superclass : #BlEvent,
	#category : #'OnBloc-Events'
}

{ #category : #initialization }
OblResponse >> reply: anObject [
	self subclassResponsibility
]
