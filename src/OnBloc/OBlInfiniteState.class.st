Class {
	#name : #OBlInfiniteState,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'targetPosition',
		'layoutStep',
		'data',
		'itemCount',
		'previousLayoutItemCount',
		'deletedInvisibleItemCountSincePreviousLayout',
		'structureChanged',
		'inPreLayout',
		'trackOldChangeHolders',
		'isMeasuring',
		'focusedItemPosition',
		'focusedItemId',
		'focusedSubChild'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'OnBloc-Infinite'
}

{ #category : #asserting }
OBlInfiniteState >> assertLayoutStep: aStep [
	"Make sure that current layout step is aStep"
	
	self
		assert: [ layoutStep has: aStep ]
		description: [ 'Wrong layout state! It should be: ', aStep asString, ' but it is ', layoutStep value asString ]
]

{ #category : #asserting }
OBlInfiniteState >> assertLayoutStep: aStep or: anotherStep [
	"Make sure that current layout step is aStep"

	((layoutStep has: aStep) or: [ layoutStep has: anotherStep ])
		ifFalse: [ self error: 'Wrong layout state! It should be: ', aStep asString, ' or ', anotherStep asString, ' but it is ', layoutStep value asString ]
]

{ #category : #'adding/removing' }
OBlInfiniteState >> at: aResourceKey [

	^ data at: aResourceKey ifAbsent: nil
]

{ #category : #'adding/removing' }
OBlInfiniteState >> at: aResourceKey put: anObject [

	data at: aResourceKey put: anObject
]

{ #category : #'accessing - step' }
OBlInfiniteState >> beStepAnimations [

	layoutStep clear.
	layoutStep addAnimations
]

{ #category : #'accessing - step' }
OBlInfiniteState >> beStepLayout [

	layoutStep clear.
	layoutStep addLayout
]

{ #category : #'accessing - step' }
OBlInfiniteState >> beStepStart [

	layoutStep clear.
	layoutStep addStart
]

{ #category : #initialization }
OBlInfiniteState >> defaultLayoutStep [

	^ BlInfiniteLayoutStepFlags new
		addStart;
		yourself
]

{ #category : #accessing }
OBlInfiniteState >> deletedInvisibleItemCountSincePreviousLayout [
	^ deletedInvisibleItemCountSincePreviousLayout
]

{ #category : #accessing }
OBlInfiniteState >> deletedInvisibleItemCountSincePreviousLayout: anObject [
	deletedInvisibleItemCountSincePreviousLayout := anObject
]

{ #category : #testing }
OBlInfiniteState >> didStructureChange [
	^ structureChanged
]

{ #category : #'accessing - focus' }
OBlInfiniteState >> focusedItemId [
	^ focusedItemId
]

{ #category : #'accessing - focus' }
OBlInfiniteState >> focusedItemId: anObject [
	focusedItemId := anObject
]

{ #category : #'accessing - focus' }
OBlInfiniteState >> focusedItemPosition [
	^ focusedItemPosition
]

{ #category : #'accessing - focus' }
OBlInfiniteState >> focusedItemPosition: anObject [
	focusedItemPosition := anObject
]

{ #category : #'accessing - focus' }
OBlInfiniteState >> focusedSubChild [
	^ focusedSubChild
]

{ #category : #'accessing - focus' }
OBlInfiniteState >> focusedSubChild: anObject [
	focusedSubChild := anObject
]

{ #category : #testing }
OBlInfiniteState >> hasTargetScrollPosition [
	"Return true if current scroll has a target position, false otherwise"
	<return: #Boolean>

	^ targetPosition ~= NoPosition
]

{ #category : #initialization }
OBlInfiniteState >> initialize [
	super initialize.
	
	targetPosition := NoPosition.

	layoutStep := self defaultLayoutStep.

	data := Dictionary new.
	
	itemCount := 0.
	previousLayoutItemCount := 0.
	deletedInvisibleItemCountSincePreviousLayout := 0.
	
	structureChanged := false.
	inPreLayout := false.
	trackOldChangeHolders := false.
	isMeasuring := false.
	
	focusedItemPosition := NoPosition.
	focusedItemId := NoId.
	focusedSubChild := nil
]

{ #category : #'testing - step' }
OBlInfiniteState >> isLayoutStep [
	^ layoutStep hasLayout
]

{ #category : #accessing }
OBlInfiniteState >> isMeasuring [
	^ isMeasuring
]

{ #category : #accessing }
OBlInfiniteState >> isMeasuring: aBoolean [
	isMeasuring := aBoolean
]

{ #category : #accessing }
OBlInfiniteState >> isPreLayout [
	^ inPreLayout
]

{ #category : #accessing }
OBlInfiniteState >> isPreLayout: aBoolean [
	inPreLayout := aBoolean
]

{ #category : #'testing - step' }
OBlInfiniteState >> isStartStep [
	^ layoutStep hasStart
]

{ #category : #accessing }
OBlInfiniteState >> itemCount [
	^ inPreLayout
		ifTrue: [ previousLayoutItemCount - deletedInvisibleItemCountSincePreviousLayout ]
		ifFalse: [ itemCount ]
]

{ #category : #accessing }
OBlInfiniteState >> itemCount: aNumber [
	itemCount := aNumber
]

{ #category : #accessing }
OBlInfiniteState >> previousLayoutItemCount [
	^ previousLayoutItemCount
]

{ #category : #accessing }
OBlInfiniteState >> previousLayoutItemCount: anObject [
	previousLayoutItemCount := anObject
]

{ #category : #'adding/removing' }
OBlInfiniteState >> remove: aResourceKey [
	data removeKey: aResourceKey ifAbsent: [  ]
]

{ #category : #invalidate }
OBlInfiniteState >> reset [
	targetPosition := NoPosition.
	data removeAll.
	itemCount := 0.
	structureChanged := false
]

{ #category : #accessing }
OBlInfiniteState >> structureChanged: aBoolean [

	structureChanged := aBoolean
]

{ #category : #accessing }
OBlInfiniteState >> targetPosition: aNumber [ 
	targetPosition := aNumber
]

{ #category : #accessing }
OBlInfiniteState >> targetScrollPosition [
	^ targetPosition
]

{ #category : #accessing }
OBlInfiniteState >> targetScrollPosition: aPosition [
	targetPosition := aPosition
]

{ #category : #accessing }
OBlInfiniteState >> trackOldChangeHolders [

	^ trackOldChangeHolders
]

{ #category : #accessing }
OBlInfiniteState >> trackOldChangeHolders: aBoolean [
	trackOldChangeHolders := aBoolean
]
