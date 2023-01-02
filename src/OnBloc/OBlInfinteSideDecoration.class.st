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

{ #category : #accessing }
OBlInfinteSideDecoration >> selectionBackgroundColorOf: anItemElement in: anInfiniteElement [
	^ anInfiniteElement selectionColor alpha: 0.3
]

{ #category : #geometry }
OBlInfinteSideDecoration >> selectionLimitRectangleOf: anItemElement in: anInfiniteElement [

	" Select lines with cursor or with an element at left which has a selection that start at 0 "
	(anItemElement children
		 select: [ :e | 
			 (e isKindOf: BlTextElement) and: [ 
				 e hasCursor or: [ e bounds inParent left isZero and: [ e selection isNotEmpty and: [ e selection from isZero ] ] ] ] ]
		 thenCollect: [ :e | e textFlow assignedLine ]) in: [ :l | 
		l ifEmpty: [ ^ nil ].
		^ 0 @ l first origin y corner: self computedBounds width - self gap @ (l last origin y + l last height) ]
]

{ #category : #geometry }
OBlInfinteSideDecoration >> selectionLimitRectangleOf: anItemElement in: anInfiniteElement do: aBlock [
	(self selectionLimitRectangleOf: anItemElement in: anInfiniteElement) ifNotNil: [ :bnds | aBlock value: bnds ]
]
