Class {
	#name : #OblStencilDynamicExecutor,
	#superclass : #OblStencilExecutor,
	#instVars : [
		'valuable'
	],
	#category : #'OnBloc-Stencil'
}

{ #category : #running }
OblStencilDynamicExecutor >> execute: aCollectionOfArguments [
	self subclassResponsibility
]
