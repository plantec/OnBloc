Class {
	#name : #OBlInfiniteExampleClassesDataSource,
	#superclass : #OBlInfiniteDataSource,
	#instVars : [
		'classes'
	],
	#category : #'OnBloc-Examples-infinite-class-list'
}

{ #category : #initialization }
OBlInfiniteExampleClassesDataSource >> initialize [
	super initialize.

	classes := Smalltalk globals allClasses asArray
]

{ #category : #accessing }
OBlInfiniteExampleClassesDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ classes size
]

{ #category : #'instance creation' }
OBlInfiniteExampleClassesDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"
	anElementHolder class: (classes at: aPosition)
]

{ #category : #'instance creation' }
OBlInfiniteExampleClassesDataSource >> onCreateHolder: anInfiniteElement [ 
	^ OBlInfiniteExampleClassesElementHolder new
]
