Class {
	#name : #OBlInfiniteExampleClassesElement,
	#superclass : #OBlInfiniteElement,
	#category : #'OnBloc-Examples-infinite-class-list'
}

{ #category : #example }
OBlInfiniteExampleClassesElement class >> example_ClassesMultiple [

	self new openInOBlSpace 

]

{ #category : #initialization }
OBlInfiniteExampleClassesElement >> defaultLayout [
	^ OBlInfiniteLinearLayout new
]

{ #category : #initialization }
OBlInfiniteExampleClassesElement >> initialize [

	super initialize.
	self dataSource: OBlInfiniteExampleClassesDataSource new.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ]
]
