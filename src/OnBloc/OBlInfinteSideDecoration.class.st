Class {
	#name : #OBlInfinteSideDecoration,
	#superclass : #OBlInfiniteDecoration,
	#category : #'OnBloc-Infinite'
}

{ #category : #geometry }
OBlInfinteSideDecoration >> gap [
	^ 0
]

{ #category : #geometry }
OBlInfinteSideDecoration >> requiredWidth [
	^ self subclassResponsibility 
]
