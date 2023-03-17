"
I represent a child holder  within infinite element and store data related to child - current position within data source, old position and maybe additional data needed by infinite layout

"
Class {
	#name : #OBlInfiniteHolder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'itemElement',
		'position',
		'itemId',
		'preLayoutPosition',
		'flags',
		'isScrap',
		'infiniteElement'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'OnBloc-Infinite'
}

{ #category : #'private - position' }
OBlInfiniteHolder >> clearOldPosition [

	preLayoutPosition := NoPosition
]

{ #category : #'private - flags changing' }
OBlInfiniteHolder >> clearReturnedFromScrap [
	self flags clearReturnedFromScrap
]

{ #category : #'private - flags changing' }
OBlInfiniteHolder >> clearTmpDetached [
	self flags clearTmpDetached
]

{ #category : #accessing }
OBlInfiniteHolder >> dataSourcePosition [
	"Returns the datasource position of the item represented by this ElementHolder."
	<return: #Number>

	^ infiniteElement dataSourcePositionOf: self
]

{ #category : #private }
OBlInfiniteHolder >> detachInfiniteElement [

	infiniteElement := nil
]

{ #category : #private }
OBlInfiniteHolder >> detachRecycler [
	"Detaches recycler setting it to nil and isInChangeScrap to false.
	Additionally set returned from scrap flag to false"
	"recycler := nil."
	isScrap := false.
	self clearReturnedFromScrap
]

{ #category : #private }
OBlInfiniteHolder >> flagRemovedAndOffsetPosition: aNewPosition by: anOffset applyToPreLayout: applyToPreLayout [

	self flags addRemoved.
	self offsetPositionBy: anOffset applyToPreLayout: applyToPreLayout.
	position := aNewPosition
]

{ #category : #accessing }
OBlInfiniteHolder >> flags [
	^ flags
]

{ #category : #'private - accessing' }
OBlInfiniteHolder >> infiniteElement [
	"Return an infinite element a child of which a hold.
	infiniteElement may be nil if I am not attached, for example if
	I am recycled or removed"
	<return: #BlInfiniteElement>

	^ infiniteElement
]

{ #category : #'private - accessing' }
OBlInfiniteHolder >> infiniteElement: anInfiniteElement [
	"Set an infinite element a child of which a hold.
	anInfiniteElement must not be nil"
	
	infiniteElement := anInfiniteElement
]

{ #category : #initialization }
OBlInfiniteHolder >> initialize [
	super initialize.
	
	position := NoPosition.
	preLayoutPosition := NoPosition.
	itemId := NoId.
	flags := BlInfiniteElementHolderFlags new.
	isScrap := false
]

{ #category : #'private - flags testing' }
OBlInfiniteHolder >> isBound [
	^ self flags hasBound
]

{ #category : #'private - flags testing' }
OBlInfiniteHolder >> isChanged [
	^ self flags hasUpdate
]

{ #category : #'private - flags testing' }
OBlInfiniteHolder >> isInvalid [
	^ self flags hasInvalid
]

{ #category : #'private - flags testing' }
OBlInfiniteHolder >> isRemoved [
	^ self flags hasRemoved
]

{ #category : #'private - flags testing' }
OBlInfiniteHolder >> isScrap [
	"Return true if an item I represent is added to scrap, false otherwise"
	<return: #Boolean>

	^ isScrap
]

{ #category : #'private - flags testing' }
OBlInfiniteHolder >> isTmpDetached [
	^ self flags hasTmpDetached
]

{ #category : #'private - flags testing' }
OBlInfiniteHolder >> isUpdated [
	^ self flags hasUpdate
]

{ #category : #accessing }
OBlInfiniteHolder >> itemElement [
	^ itemElement
]

{ #category : #accessing }
OBlInfiniteHolder >> itemId [
	"Returns The itemId represented by this ElementHolder if datasource has stable ids, `BlInfiniteElement noId` otherwise"
	<return: #Number>

	^ itemId
]

{ #category : #'private - accessing' }
OBlInfiniteHolder >> itemId: anIdemId [
	itemId := anIdemId
]

{ #category : #accessing }
OBlInfiniteHolder >> layoutPosition [
	"Returns the position of the ElementHolder in terms of the latest layout pass"
	<return: #Number>

	^ preLayoutPosition = NoPosition
		ifTrue: [ position ]
		ifFalse: [ preLayoutPosition ]
]

{ #category : #'private - flags testing' }
OBlInfiniteHolder >> needsUpdate [
	^ self flags hasUpdate
]

{ #category : #private }
OBlInfiniteHolder >> offsetPositionBy: anOffset applyToPreLayout: shouldApplyOnPreLayout [
	
	preLayoutPosition = NoPosition
		ifTrue: [ preLayoutPosition := position ].
	
	shouldApplyOnPreLayout
		ifTrue: [ preLayoutPosition := preLayoutPosition + anOffset ].
	
	position := position + anOffset.
	itemElement constraints infinite insetsDirty: true
]

{ #category : #'private - position' }
OBlInfiniteHolder >> position [
	"For inner use ONLY! Instead try #layoutPosition or #dataSourcePosition"
	<return: #Number>

	^ position
]

{ #category : #'private - position' }
OBlInfiniteHolder >> position: aPosition [
	"For inner use ONLY!"
	position := aPosition
]

{ #category : #'private - position' }
OBlInfiniteHolder >> preLayoutPosition: aPosition [
	"For inner use ONLY!"
	preLayoutPosition := aPosition
]

{ #category : #'private - invalidate' }
OBlInfiniteHolder >> reset [

	flags clear.
	position := NoPosition.
	itemId := NoId.
	preLayoutPosition := NoPosition
]

{ #category : #'private - flags testing' }
OBlInfiniteHolder >> shouldIgnore [
	^ self flags hasIgnore
]

{ #category : #'private - flags changing' }
OBlInfiniteHolder >> startIgnoring [
	"Start ignoring an element I represent"

	self flags addIgnore
]

{ #category : #'private - flags changing' }
OBlInfiniteHolder >> stopIgnoring [
	"Stop ignoring an element I represent"

	self flags clearIgnore
]

{ #category : #private }
OBlInfiniteHolder >> unscrap [
	"Unscrap me from recycler detaching it from me as result"
	self deprecated: 'Because recycler inst var should be removed to avoid bi-directionnal reference between BlInfiniteHolder and the recycler. use Recycler>>#unscrapHolder: instead'.
	"recycler unscrapHolder: self"
]

{ #category : #'private - flags testing' }
OBlInfiniteHolder >> wasReturnedFromScrap [
	<return: #Boolean>

	^ self flags hasReturnedFromScrap
]
