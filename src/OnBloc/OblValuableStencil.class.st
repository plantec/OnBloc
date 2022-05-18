"
I am a special type of stencil whose `=#create`= method can be dynamically defined with the help of a valuable object.

To get a Statefull version of the Stencil users can provide a collection of `=#arguments`= that will be passed to the valuable in the same order as in argument collection.

"
Class {
	#name : #OBlValuableStencil,
	#superclass : #OBlStencil,
	#instVars : [
		'valuable',
		'arguments'
	],
	#category : #'OnBloc-Stencil'
}

{ #category : #'instance creation' }
OBlValuableStencil class >> from: aValuable [
	<return: #OBlStencil>

	^ self new valuable: aValuable
]

{ #category : #accessing }
OBlValuableStencil >> arguments [
	<return: #Collection of: #Object>

	^ arguments
]

{ #category : #accessing }
OBlValuableStencil >> arguments: aCollectionOfObjects [
	arguments := aCollectionOfObjects
]

{ #category : #'api - instantiation' }
OBlValuableStencil >> create [
	<return: #Object>
	
	^ self valuable glamourValueWithArgs: self arguments
]

{ #category : #accessing }
OBlValuableStencil >> valuable [
	^ valuable
]

{ #category : #accessing }
OBlValuableStencil >> valuable: anObject [
	valuable := anObject
]
