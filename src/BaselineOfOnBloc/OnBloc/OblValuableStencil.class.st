"
I am a special type of stencil whose `=#create`= method can be dynamically defined with the help of a valuable object.

To get a Statefull version of the Stencil users can provide a collection of `=#arguments`= that will be passed to the valuable in the same order as in argument collection.

"
Class {
	#name : #OblValuableStencil,
	#superclass : #OblStencil,
	#instVars : [
		'valuable',
		'arguments'
	],
	#category : #'OnBloc-Stencil'
}

{ #category : #'instance creation' }
OblValuableStencil class >> from: aValuable [
	<return: #OblStencil>

	^ self new valuable: aValuable
]

{ #category : #accessing }
OblValuableStencil >> arguments [
	<return: #Collection of: #Object>

	^ arguments
]

{ #category : #accessing }
OblValuableStencil >> arguments: aCollectionOfObjects [
	arguments := aCollectionOfObjects
]

{ #category : #'api - instantiation' }
OblValuableStencil >> create [
	<return: #Object>
	
	^ self valuable glamourValueWithArgs: self arguments
]

{ #category : #accessing }
OblValuableStencil >> valuable [
	^ valuable
]

{ #category : #accessing }
OblValuableStencil >> valuable: anObject [
	valuable := anObject
]
