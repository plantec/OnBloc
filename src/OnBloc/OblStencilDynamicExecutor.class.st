Class {
	#name : #OBlStencilDynamicExecutor,
	#superclass : #OBlStencilExecutor,
	#instVars : [
		'valuable'
	],
	#category : #'OnBloc-Stencil'
}

{ #category : #running }
OBlStencilDynamicExecutor >> execute: aCollectionOfArguments [
	self subclassResponsibility
]
