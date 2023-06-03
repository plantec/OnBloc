"
I provide a binding from an app-specific data set to elements that are displayed within an InfiniteElement

"
Class {
	#name : #OBlInfiniteDataSource,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TBlDebug',
	#classTraits : 'TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'eventDispatcher',
		'hasStableIds'
	],
	#pools : [
		'OBlInfiniteConstants'
	],
	#category : #'OnBloc-Infinite-DataSource'
}

{ #category : #'instance creation' }
OBlInfiniteDataSource class >> noId [
	^ NoId
]

{ #category : #'instance creation' }
OBlInfiniteDataSource >> bindHolder: anElementHolder at: aPosition [

	anElementHolder position: aPosition.
	self hasStableIds
		ifTrue: [ anElementHolder itemId: (self itemIdAt: aPosition) ].
	anElementHolder flags
		clearUpdate;
		clearInvalid;
		clearDataSourcePositionUnknown;
		addBound.

	self onBindHolder: anElementHolder at: aPosition.
	
	anElementHolder itemElement constraints infinite insetsDirty: true
]

{ #category : #'instance creation' }
OBlInfiniteDataSource >> createHolder: anInfiniteElement [ 
	^ self onCreateHolder: anInfiniteElement
]

{ #category : #'event management accessing' }
OBlInfiniteDataSource >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'event management testing' }
OBlInfiniteDataSource >> hasEventHandlers [
	"Returns true if one or more event handlers are attached to this data source"
	<return: #Boolean>

	^ self eventDispatcher handlers handlers isNotEmpty
]

{ #category : #testing }
OBlInfiniteDataSource >> hasStableIds [
	"Returns true if this data source publishes a unique value that can
	act as a key for the item at a given position in the data set. If that item is relocated
	in the data set, the ID returned for that item should be the same"
	<return: #Boolean>

	^ hasStableIds
]

{ #category : #initialization }
OBlInfiniteDataSource >> initialize [
	super initialize.
	
	eventDispatcher := BlDirectEventDispatcher on: self.
	hasStableIds := false
]

{ #category : #accessing }
OBlInfiniteDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #accessing }
OBlInfiniteDataSource >> itemIdAt: aPosition [
	"Return the stable ID for the item at aPosition.
	If #hasStableIds would return false this method should return ===NoId===.
	The default implementation of this method returns ===NoId==="
	<return: #Number>

	^ NoId
]

{ #category : #'event firing' }
OBlInfiniteDataSource >> notifyChanged [
	"Notify any registered event handlers that the data set has changed.
	There are two different classes of data change events, item changes and structural
	changes. Item changes are when a single item has its data updated but no positional
	changes have occurred. Structural changes are when items are inserted, removed or moved
	within the data set.
	This event does not specify what about the data set has changed, forcing
	any observers to assume that all existing items and structure may no longer be valid.
	InfiniteLayout will be forced to fully rebind and relayout all visible elements."

	self notifyWithEvent: (OBlInfiniteDataSourceChanged new
		dataSource: self;
		yourself)
]

{ #category : #'event firing' }
OBlInfiniteDataSource >> notifyItems: anInterval event: anEvent [
	"Notify any registered event handlers that the itemCount items starting at aPosition should receive a given event"
	
	self notifyWithEvent: (OBlInfiniteDataSourceItemRangeEvent new
		position: anInterval first;
		itemCount: anInterval size;
		event: anEvent)
]

{ #category : #'event firing' }
OBlInfiniteDataSource >> notifyItemsChanged: anInterval [
	"Notify any registered event handlers that the itemCount items starting at aPosition have changed.
	This is an item change event, not a structural change event. It indicates that
	any reflection of the data in the given position range is out of date and should
	be updated. The items in the given range retain the same identity"
	
	self notifyWithEvent: (OBlInfiniteDataSourceItemRangeChanged
		position: anInterval first
		itemCount: anInterval size)
]

{ #category : #'event firing' }
OBlInfiniteDataSource >> notifyItemsInserted: anInterval [
	"Notify any registered observers that the currently reflected ===anInterval size===
	items starting at ===anInterval first=== have been newly inserted. The items
	previously located at ===anInterval first=== and beyond can now be found starting
	at position ===anInterval last===.
	This is a structural change event. Representations of other existing items in the
	data set are still considered up to date and will not be rebound, though their positions
	may be altered"

	self notifyWithEvent: (OBlInfiniteDataSourceItemRangeInserted
		position: anInterval first
		itemCount: anInterval size)
]

{ #category : #'event firing' }
OBlInfiniteDataSource >> notifyItemsRemoved: anInterval [
	"Notify any registered event handlers that the ===anInterval size=== items previously
	located at ===anInterval first=== have been removed from the data set. The items
	previously located at and after ===anInterval last=== may now be found ===oldPosition - anInterval size===.
	This is a structural change event. Representations of other existing items in the data
	set are still considered up to date and will not be rebound, though their positions
 	may be altered."

	self notifyWithEvent: (OBlInfiniteDataSourceItemRangeRemoved
		position: anInterval first
		itemCount: anInterval size)
]

{ #category : #'event firing' }
OBlInfiniteDataSource >> notifyWithEvent: anEvent [
	"Dispatch a given event assuming that it will happen in a UI Thread.
	Note that it is a responsibility of a user to #notify* change events from within the UI
	process of a space in which an infinite element resides. Not managing to do so may trigger
	a UI update from outside of the UI process which is undefined behavior.
	Consider notifying the datasource changes from within an enqueued task BlElement>>#enqueueTask:"

	self dispatchEvent: anEvent
]

{ #category : #hooks }
OBlInfiniteDataSource >> onAttached: anInfiniteElement [
	"Is sent by InfiniteElement when it starts observing this DataSource"
]

{ #category : #'instance creation' }
OBlInfiniteDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Override to bind data to an element holder"
]

{ #category : #'instance creation' }
OBlInfiniteDataSource >> onCreateHolder: anInfiniteElement [ 
	"Override to create an ElementHolder for an item type.
	use ===BlElementHolder of: element=== to create a holder for an element".
	^ self subclassResponsibility
]

{ #category : #hooks }
OBlInfiniteDataSource >> onDetached: anInfiniteElement [

	"Is sent by InfiniteElement when it stops observing this DataSource"
]

{ #category : #hooks }
OBlInfiniteDataSource >> onElementAttached: anElementHolder [
	"Sent when an element created by this datasource has been attached to InfiniteElement.
	This can be used as a reasonable signal that the element is about to be seen by the user.
	If the datasource previously freed any resources in #onElementDetached: those resources should be restored here"
]

{ #category : #hooks }
OBlInfiniteDataSource >> onElementDetached: anElementHolder [
	"Sent when an element created by this datasource has been detached from infinite element.
	Becoming detached is not necessarily a permanent condition;
	the consumer of the DataSource's elements may choose to cache elements offscreen while they
	are not visible, attaching and detaching them as appropriate"
]
