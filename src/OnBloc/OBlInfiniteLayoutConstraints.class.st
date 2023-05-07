Class {
	#name : #OBlInfiniteLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'holder',
		'decorationInsets',
		'insertsDirty',
		'pendingInvalidate'
	],
	#category : #'OnBloc-Infinite-Layout'
}

{ #category : #accessing }
OBlInfiniteLayoutConstraints >> decorationInsets [
	^ decorationInsets
]

{ #category : #accessing }
OBlInfiniteLayoutConstraints >> decorationInsets: aBlInsets [
	decorationInsets := aBlInsets
]

{ #category : #'initialize-release' }
OBlInfiniteLayoutConstraints >> defaultHolder [

	^ OBlInfiniteHolder new
]

{ #category : #'accessing - position' }
OBlInfiniteLayoutConstraints >> elementDataSourcePosition [
	"Returns the up-to-date datasource position that the element I am attached to corresponds to"
	<return: #Number>

	^ holder dataSourcePosition
]

{ #category : #'accessing - position' }
OBlInfiniteLayoutConstraints >> elementLayoutPosition [
	"Returns the datasource position that the element I am attached to corresponds to as of latest layout calculation"
	<return: #Number>

	^ holder layoutPosition
]

{ #category : #accessing }
OBlInfiniteLayoutConstraints >> holder [
	"Return an element holder of the element I am attached to.
	holder can not be nil"
	<return: #OBlInfiniteHolder>

	^ holder
]

{ #category : #accessing }
OBlInfiniteLayoutConstraints >> holder: anElementHolder [
	"Change an element holder of the element I am attached to.
	anElement holder must not be nil"
	
	self
		assert: [ anElementHolder isNotNil ]
		description: [ 'An element holder must not be nil' ].

	holder := anElementHolder
]

{ #category : #'initialize-release' }
OBlInfiniteLayoutConstraints >> initialize [
	super initialize.
	
	holder := self defaultHolder.
	insertsDirty := true.
	pendingInvalidate := false
]

{ #category : #'private - accessing' }
OBlInfiniteLayoutConstraints >> insetsDirty [
	^ insertsDirty
]

{ #category : #'private - accessing' }
OBlInfiniteLayoutConstraints >> insetsDirty: aBoolean [
	insertsDirty := aBoolean
]

{ #category : #testing }
OBlInfiniteLayoutConstraints >> isElementInvalid [
	"Returns true if the element I am attached to is now representing potentially invalid data.
	An InfiniteLayout should scrap/recycle it."
	<return: #Boolean>
	
	^ holder isInvalid
]

{ #category : #testing }
OBlInfiniteLayoutConstraints >> isElementNeedsUpdate [
	"Returns true if the element I am attached to needs to have its content updated from the corresponding datasource"
	<return: #Boolean>

	^ holder needsUpdate
]

{ #category : #testing }
OBlInfiniteLayoutConstraints >> isItemChanged [
	"Returns true if the datasource item corresponding to the element I am attached to has been changed in the data set.
	An InfiniteElement may choose to treat it differently in order to animate its changing state."
	<return: #Boolean>

	^ holder isChanged
]

{ #category : #testing }
OBlInfiniteLayoutConstraints >> isItemRemoved [
	"Returns true if the datasource item corresponding to the element I am attached to has been removed from the data set.
	An InfiniteLayout may choose to treat it differently in order to animate its outgoing or disappearing state"
	<return: #Boolean>

	^ holder isRemoved
]

{ #category : #'private - accessing' }
OBlInfiniteLayoutConstraints >> pendingInvalidate [
	^ pendingInvalidate
]

{ #category : #'private - accessing' }
OBlInfiniteLayoutConstraints >> pendingInvalidate: aBoolean [
	pendingInvalidate := aBoolean
]
