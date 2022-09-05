"
I am an observer for watching changes to an DataSource
"
Class {
	#name : #OBlInfiniteDataSourceObserver,
	#superclass : #BlBasicEventHandler,
	#category : #'OnBloc-Infinite-DataSource'
}

{ #category : #events }
OBlInfiniteDataSourceObserver >> eventClass [
	^ BlInfiniteDataSourceEvent
]

{ #category : #events }
OBlInfiniteDataSourceObserver >> handleEvent: anEvent [
	anEvent sendTo: self
]

{ #category : #'event handling' }
OBlInfiniteDataSourceObserver >> onChanged: anEvent [
	"@see BlInfiniteDataSourceChanged"

	self subclassResponsibility
]

{ #category : #'event handling' }
OBlInfiniteDataSourceObserver >> onItemsChanged: anEvent [
	"@see BlInfiniteDataSourceItemRangeChanged"

	self subclassResponsibility
]

{ #category : #'event handling' }
OBlInfiniteDataSourceObserver >> onItemsEvent: anEvent [
	"@see BlInfiniteDataSourceItemRangeEvent"

	self subclassResponsibility
]

{ #category : #'event handling' }
OBlInfiniteDataSourceObserver >> onItemsInserted: anEvent [
	"@see BlInfiniteDataSourceItemRangeInserted"

	self subclassResponsibility
]

{ #category : #'event handling' }
OBlInfiniteDataSourceObserver >> onItemsMoved: anEvent [
	"@see BlInfiniteDataSourceItemRangeMoved"

	self subclassResponsibility
]

{ #category : #'event handling' }
OBlInfiniteDataSourceObserver >> onItemsRemoved: anEvent [
	"@see BlInfiniteDataSourceItemRangeRemoved"

	self subclassResponsibility
]

{ #category : #events }
OBlInfiniteDataSourceObserver >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
