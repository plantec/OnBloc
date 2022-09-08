"
I'm an element which is supposed to contain huge amount of children and layout only those of them that are visible inside my viewport.
I work with DataSources to fetch data from and can present data within different Infinite Layouts.

I fire the following events:
   - BlInfiniteElementDetachedEvent when a child element is detached

My main collaborators are:
 - BlInfiniteHolder
 - BlInfiniteLayout
 - BlInfiniteRecycler
 - BlInfiniteState

"
Class {
	#name : #OBlInfiniteElement,
	#superclass : #BlElement,
	#traits : 'TBlScrollable',
	#classTraits : 'TBlScrollable classTrait',
	#instVars : [
		'dataSource',
		'dataSourceManager',
		'childrenManager',
		'state',
		'recycler',
		'hasFixedSize',
		'layoutOrScrollCounter',
		'dispatchScrollCounter',
		'layoutFrozen',
		'layoutRequestEaten',
		'itemDecorations',
		'dataSourceChangedAfterLayout',
		'firstLayoutComplete',
		'itemsAddedOrRemoved',
		'itemsChanged',
		'preserveFocusAfterLayout',
		'layoutPositionsRange',
		'eatRequestLayoutCounter',
		'childrenUpdateRunnable',
		'dataSourceChangeDuringMeasure',
		'dataSourceObserver',
		'scrollFlinger',
		'scrollState',
		'overScrollMode'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'OnBloc-Infinite-! Core'
}

{ #category : #'private - assertions' }
OBlInfiniteElement >> assertInLayoutOrScroll [
	"Checks if InfiniteElement is in the middle of a layout or scroll
	and throws an assertion error if it is not"
	
	self
		assert: [ self isComputingLayout ]
		description: [ 'InfiniteElement is not computing a layout or scrolling while it should' ].
]

{ #category : #'private - assertions' }
OBlInfiniteElement >> assertNotInLayoutOrScroll [
	"Checks if InfiniteElement is in the middle of a layout or scroll
	and throws an assertion error if it is"
	
	Bloc debugModeEnabled
		ifFalse: [ ^ self ].
	
	self
		assert: [ self isComputingLayout not ]
		description: [ 'InfiniteElement is computing a layout or scrolling while it should not' ].
	
	self
		assert: [ dispatchScrollCounter isZero ]
		description: [ 'Can not change the structure of InfiniteElement during scrolling' ]
]

{ #category : #'api - scrolling testing' }
OBlInfiniteElement >> canScrollHorizontally [
	"Return true if I can scroll the current contents horizontally, false otherwise"
	<return: #Boolean>

	^ self layout canScrollHorizontally
]

{ #category : #'api - scrolling testing' }
OBlInfiniteElement >> canScrollVertically [
	"Return true if I can scroll the current contents vertically, false otherwise"
	<return: #Boolean>

	^ self layout canScrollVertically
]

{ #category : #'private - positions' }
OBlInfiniteElement >> changedHolderKeyOf: anElementHolder [
	
	<return: #Number>
	
	^ dataSource hasStableIds
		ifTrue: [ anElementHolder itemId ]
		ifFalse: [ anElementHolder position ]
]

{ #category : #'children - accessing' }
OBlInfiniteElement >> childContainingItemElement: anElement [
	"Traverses the ancestors of the given element and returns the item view that contains it and
	also my direct child. Returned element can be used to get the ElementHolder by sending #childHolderOf:
	Return nil if such element was not found"
	<return: #BlElement or: nil>
	| aParent aPreviousParent |

	aParent := anElement parent.
	[ aParent isNotNil and: [ aParent ~~ self ] ] whileTrue: [ 
		aPreviousParent := aParent.
		aParent := aPreviousParent parent ].
	
	^ aParent == self
		ifTrue: [ aPreviousParent ]
		ifFalse: [ nil ]
]

{ #category : #'children - accessing' }
OBlInfiniteElement >> childHolderContainingItemElement: anElement [
	"Return the ElementHolder that contains the given element.
	Return nil if the provided element is not a my descendant"
	<return: #BlInfiniteHolder or: nil>
	| aChildElement |

	aChildElement := self childContainingItemElement: anElement.
	^ aChildElement ifNotNil: [ :anItemElement |
		self childHolderOf: anItemElement ]
]

{ #category : #'children - accessing' }
OBlInfiniteElement >> childHolderOf: aChildElement [
	"Return an element holder assigned to my direct child.
	aChildElement must be my direct child.
	Element holder can not be nil"
	<return: #BlInfiniteHolder>

	self
		assert: [ aChildElement parent == self ]
		description: [ 'aChildElement must be my direct child!' ].

	^ self elementHolderOf: aChildElement
]

{ #category : #'children - accessing' }
OBlInfiniteElement >> childLayoutPositionOf: anElement [
	"Return the datasource position of the given child element as of the latest completed layout pass.
	This position may not be equal to Item's datasource position if there are pending changes
	in the datasource which have not been reflected to the layout yet"
	<return: #Number>

	^ (self elementHolderOf: anElement) layoutPosition

]

{ #category : #accessing }
OBlInfiniteElement >> childrenManager [
	^ childrenManager
]

{ #category : #'private - positions' }
OBlInfiniteElement >> clearOldPositions [

	childrenManager
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			anElementHolder shouldIgnore ifFalse: [ 
				anElementHolder clearOldPosition ] ]
		in: self.

	recycler clearOldPositions
]

{ #category : #'api - scrolling thumb' }
OBlInfiniteElement >> computeHorizontalScrollExtent [
	"Compute the horizontal extent of the horizontal scrollbar's thumb within the horizontal range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollRange and #computeHorizontalScrollOffset."
	<return: #Number>
	
	^ self layout canScrollHorizontally
		ifTrue: [ self layout computeHorizontalScrollExtent ]
		ifFalse: [ 0 ]
]

{ #category : #'api - scrolling thumb' }
OBlInfiniteElement >> computeHorizontalScrollOffset [
	"Compute the horizontal offset of the horizontal scrollbar's thumb within the horizontal range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollRange."
	<return: #Number>
	
	^ self layout canScrollHorizontally
		ifTrue: [ self layout computeHorizontalScrollOffset ]
		ifFalse: [ 0 ]
]

{ #category : #'api - scrolling thumb' }
OBlInfiniteElement >> computeHorizontalScrollRange [
	"Compute the horizontal range that the horizontal scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollOffset."
	<return: #Number>
	
	^ self layout canScrollHorizontally
		ifTrue: [ self layout computeHorizontalScrollRange ]
		ifFalse: [ 0 ]
]

{ #category : #'api - scrolling thumb' }
OBlInfiniteElement >> computeVerticalScrollExtent [
	"Compute the vertical extent of the vertical scrollbar's thumb within the vertical range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollRange and #computeVerticalScrollOffset"
	<return: #Number>
	
	^ self layout canScrollVertically
		ifTrue: [ self layout computeVerticalScrollExtent ]
		ifFalse: [ 0 ]
]

{ #category : #'api - scrolling thumb' }
OBlInfiniteElement >> computeVerticalScrollOffset [
	"Compute the vertical offset of the vertical scrollbar's thumb within the vertical range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollExtent and #computeVerticalScrollRange."
	<return: #Number>
	
	^ self layout canScrollVertically
		ifTrue: [ self layout computeVerticalScrollOffset ]
		ifFalse: [ 0 ]
]

{ #category : #'api - scrolling thumb' }
OBlInfiniteElement >> computeVerticalScrollRange [
	"Compute the vertical range that the vertical scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollExtent and #computeVerticalScrollOffset."
	<return: #Number>
	
	^ self layout canScrollVertically
		ifTrue: [ self layout computeVerticalScrollRange ]
		ifFalse: [ 0 ]
]

{ #category : #'private - commands' }
OBlInfiniteElement >> consumePendingDataSourceCommands [
	"I help to reflect data changes to the state.
	DataSource changes during a scroll may trigger a crash because scroll assumes no data change but data actually changed.
	I consume all deferred changes to avoid that case."

	(firstLayoutComplete not or: [ dataSourceChangedAfterLayout ])
		ifTrue: [ ^ self dispatchLayout ].
	
	dataSourceManager hasPendingCommands
		ifFalse: [ ^ self ].

	"if it is only an item change (no add-remove-move) we can check
	if any of the visible items is affected and if not, just ignore the change."
	dataSourceManager hasOnlyUpdateCommand
		ifTrue: [ 
			self eatRequestLayout.
			dataSourceManager preProcessCommandsIn: self.
			layoutRequestEaten ifFalse: [ 
				self hasUpdatedChild
					ifTrue: [ self dispatchLayout ]
					"no need to layout, clean state"
					ifFalse: [ dataSourceManager consumePostponedCommandsIn: self ] ].
			self resumeRequestLayout: true ]
		ifFalse: [
			 dataSourceManager hasPendingCommands
				ifTrue: [ self dispatchLayout ] ]
]

{ #category : #accessing }
OBlInfiniteElement >> dataSource [
	^ dataSource
]

{ #category : #accessing }
OBlInfiniteElement >> dataSource: aDataSource [
	dataSource
		ifNotNil: [
			dataSource removeEventHandler: dataSourceObserver.
			dataSource onDetached: self ].
	
	dataSource := aDataSource.
	dataSource addEventHandler: dataSourceObserver.
	dataSource onAttached: self
]

{ #category : #'private - accessing' }
OBlInfiniteElement >> dataSource: aNewDataSource compatible: isCompatibleWithPrevious recycle: shouldRecycleElement [
]

{ #category : #accessing }
OBlInfiniteElement >> dataSourceManager [
	^ dataSourceManager
]

{ #category : #accessing }
OBlInfiniteElement >> dataSourcePositionOf: anElementHolder [
	<return: #Number>
	
	(anElementHolder flags hasInvalid or: [
		anElementHolder flags hasRemoved or: [ 
			anElementHolder flags hasDataSourcePositionUnknown or: [
				anElementHolder isBound not ] ] ])
		ifTrue: [ ^ NoPosition ].
		
	^ self dataSourceManager applyPendingCommandsOnPosition: anElementHolder position
]

{ #category : #'children - geometry' }
OBlInfiniteElement >> decoratedBoundsWithMargins: anElement [
	"Returns the bounds of the child element including its decoration and margins"
	<return: #Rectangle>
	| aMargin anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	aMargin := anElement constraints margin.
	
	^ anInsets expand: (aMargin expand: anElement bounds inParent asRectangle)
]

{ #category : #'item decorations - accessing' }
OBlInfiniteElement >> decorationsInsetsOfChildElement: anElement [

	"Return decoration insets for the given element"

	<return: #BlInsets>
	| anInfiniteConstraints |
	
	anInfiniteConstraints := anElement constraints infinite.
	anInfiniteConstraints insetsDirty ifTrue: [ 
		anInfiniteConstraints decorationInsets:
			(self getDecorationsInsetsOfChildElement: anElement).
		^ anInfiniteConstraints decorationInsets ].

	(self state isPreLayout and: [ 
		 anInfiniteConstraints isItemChanged or: [ 
			 anInfiniteConstraints isElementInvalid ] ]) ifTrue: [ 
		self getDecorationsInsetsOfChildElement: anElement ].
	"changed/invalid items should not be updated until they are rebound"
	^ anInfiniteConstraints decorationInsets
	"	

        final Rect insets = lp.mDecorInsets;
        insets.set(0, 0, 0, 0);
        final int decorCount = mItemDecorations.size();
        for (int i = 0; i < decorCount; i++) {
            mTempRect.set(0, 0, 0, 0);
            mItemDecorations.get(i).getItemOffsets(mTempRect, child, this, mState);
            insets.left += mTempRect.left;
            insets.top += mTempRect.top;
            insets.right += mTempRect.right;
            insets.bottom += mTempRect.bottom;
        }
        lp.mInsetsDirty = false;
        return insets;"
]

{ #category : #'private - focus' }
OBlInfiniteElement >> deepestFocusedChildIn: anElement [
	self shouldBeImplemented
]

{ #category : #initialization }
OBlInfiniteElement >> defaultChildrenController [
	^ OBlInfiniteDefaultChildrenController new
]

{ #category : #initialization }
OBlInfiniteElement >> defaultChildrenManager [
	^ OBlInfiniteChildrenManager new
]

{ #category : #initialization }
OBlInfiniteElement >> defaultChildrenUpdateRunnable [
	"Return class, actual instantiation happens in initialize"
	^ BlInfiniteChildrenUpdateRunnable
]

{ #category : #initialization }
OBlInfiniteElement >> defaultDataSource [
	^ BlInfiniteBasicDataSource new
]

{ #category : #initialization }
OBlInfiniteElement >> defaultDataSourceManager [
	^ OBlInfiniteDataSourceManager new
]

{ #category : #initialization }
OBlInfiniteElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"
	^ OBlInfiniteElementDataSourceObserver
]

{ #category : #initialization }
OBlInfiniteElement >> defaultLayout [
	^ BlInfiniteBasicLayout new
]

{ #category : #initialization }
OBlInfiniteElement >> defaultMouseScrollEventHandler [
	^ BlInfiniteMouseScrollListener new
]

{ #category : #initialization }
OBlInfiniteElement >> defaultOverScrollMode [
	^ BlOverScrollMode never
]

{ #category : #initialization }
OBlInfiniteElement >> defaultRecycler [
	^ OBlInfiniteRecycler new
]

{ #category : #initialization }
OBlInfiniteElement >> defaultScrollFlinger [
	"Return class, actuall instantiation happens in initialize"
	^ BlInfiniteScrollFlinger
]

{ #category : #initialization }
OBlInfiniteElement >> defaultState [
	^ OBlInfiniteState new
]

{ #category : #'private - positions' }
OBlInfiniteElement >> didChildPositionsRangeChange: anInterval [

	<return: #Boolean>

	^ self findMinMaxChildLayoutPositions ~= anInterval
]

{ #category : #dispatching }
OBlInfiniteElement >> dispatchChildAttached: anElement [
	"I am used by
		- ChildrenController's addChild:at:"
	| anElementHolder |
	
	anElementHolder := self elementHolderOf: anElement.
	self onChildAttached: anElement.
	self dataSource onElementAttached: anElementHolder.
	self notifyChildAttached: anElement
]

{ #category : #dispatching }
OBlInfiniteElement >> dispatchChildDetached: anElement [
	"I am used by
		- ChildrenController's removeChildAt: and removeAllChildren
		- InfiniteElement's removeDetachedChild:animate:"
	| anElementHolder |

	anElementHolder := self elementHolderOf: anElement.
	self onChildDetached: anElementHolder.
	self dataSource onElementDetached: anElementHolder.
	self notifyChildDetached: anElement
]

{ #category : #layout }
OBlInfiniteElement >> dispatchLayout [

	self state isMeasuring: false.
	self state isStartStep
		ifTrue: [ 
			self dispatchLayoutFirstStep.
			self layout exactMeasurementSpecFrom: self.
			self dispatchLayoutSecondStep ]
		ifFalse: [ 
			self layout exactMeasurementSpecFrom: self.
			(dataSourceManager hasCommands or: [ 
				 layout width ~= self width or: [ layout height ~= self height ] ]) 
				ifTrue: [ self dispatchLayoutSecondStep ] ].
	self dispatchLayoutThirdStep
]

{ #category : #layout }
OBlInfiniteElement >> dispatchLayoutFirstStep [
	"The first step of a layout where we
  		- process data source updates
		- save information about current child elements
		- If necessary, run predictive layout and save its information"

	self state assertLayoutStep: BlInfiniteLayoutStepFlags Start.
	self state isMeasuring: false.
	self eatRequestLayout.
	self onEnterLayoutOrScroll.
	self processDataSourceCommands.
	self saveFocusInfo.
	itemsAddedOrRemoved := false.
	itemsChanged := false.
	self state isPreLayout: false.
	self state itemCount: self dataSource itemCount.
	self layoutPositionsRange: self findMinMaxChildLayoutPositions.
	
	self clearOldPositions.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false.
	self state beStepLayout
]

{ #category : #layout }
OBlInfiniteElement >> dispatchLayoutSecondStep [
	"The second layout step where we do the actual layout of the element for the final state.
	This step might be run multiple times if necessary (e.g. measure)."
	
	self eatRequestLayout.
	self onEnterLayoutOrScroll.
	
	self state assertLayoutStep: BlInfiniteLayoutStepFlags Layout.
	
	dataSourceManager consumeCommandsInOnePassIn: self.
	self state itemCount: dataSource itemCount.
	self state deletedInvisibleItemCountSincePreviousLayout: 0.
	
	"Run layout"
	self state isPreLayout: false.
	layout layoutChildrenIn: self recycler state: self state.
	self state structureChanged: false.

	self state beStepAnimations.	
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false
]

{ #category : #layout }
OBlInfiniteElement >> dispatchLayoutThirdStep [
	"The final step of the layout where we save the information about elements for animations,
	trigger animations and do any necessary cleanup."

	self state assertLayoutStep: BlInfiniteLayoutStepFlags Animations.
	
	self eatRequestLayout.
	self onEnterLayoutOrScroll.
	self state beStepStart.
		
	layout removeAndRecycleScrap.
	self state previousLayoutItemCount: self state itemCount.
	dataSourceChangedAfterLayout := false.

	layout layoutCompleted.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false.
	
	(self didChildPositionsRangeChange: layoutPositionsRange)
		ifTrue: [ self dispatchOnScrolled: 0@0 ].
	self recoverFocusFromState.
	self resetFocusInfo
]

{ #category : #'api - scrolling notifying' }
OBlInfiniteElement >> dispatchOnScrolled: aPoint [

	dispatchScrollCounter := dispatchScrollCounter + 1.
	
	self onScrolled: aPoint.
	self notifyScrolled: aPoint.
	
	dispatchScrollCounter := dispatchScrollCounter - 1
]

{ #category : #dispatching }
OBlInfiniteElement >> dispatchScrollStateChanged: aScrollState [

	"Let the Layout go first; this allows it to bring any properties into
	a consistent state before the InfiniteElement subclass responds"
	self layout onScrollStateChanged: aScrollState.
	
	"Let the InfiniteElement subclass handle this event next;
	any Layout property changes will be reflected by this time."
	self onScrollStateChanged: aScrollState.
	
	"Event handlers go last. All other internal state is consistent by this point"
	self notifyScrollStateChanged: aScrollState
]

{ #category : #layout }
OBlInfiniteElement >> eatRequestLayout [

	eatRequestLayoutCounter := eatRequestLayoutCounter + 1.
	(eatRequestLayoutCounter = 1 and: [ layoutFrozen not ])
		ifTrue: [ layoutRequestEaten := false ]
]

{ #category : #'children - accessing' }
OBlInfiniteElement >> elementHolderOf: anElement [
	"Return an element holder assigned to anElement.
	anElement should not be necessarily my direct child.
	Element holder can not be nil"
	<return: #BlInfiniteHolder>
	
	^ anElement constraints infinite holder
]

{ #category : #'private - commands' }
OBlInfiniteElement >> elementRangeUpdate: aPositionStart itemCount: anItemCount payload: anObject [
	"Rebind existing elements for the given range, or create new as needed"
	| aPositionEnd |

	aPositionEnd := aPositionStart + anItemCount.
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ 
				(anElementHolder position >= aPositionStart and: [ anElementHolder position < aPositionEnd ])
					ifTrue: [ 
						"We re-bind these elements holders after pre-processing is complete so that
						ElementHolders have their final positions assigned."
						anElementHolder flags addUpdate.
						anElementHolder addPayload: anObject.
						anElement constraints infinite insetsDirty: true ] ] ]
			in: self
]

{ #category : #'children - accessing' }
OBlInfiniteElement >> findElementHolderForDataSourcePosition: aPosition [

	"Return the ViewHolder for the item in the given position of the data set"

	<return: #BlInfiniteHolder or: nil>
	dataSourceChangedAfterLayout ifTrue: [ ^ nil ].

	childrenManager
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			(anElementHolder isRemoved not and: [ 
				 (self dataSourcePositionOf: anElementHolder) = aPosition ]) 
				ifTrue: [ ^ anElementHolder ] ]
		in: self.

	^ nil
]

{ #category : #'children - accessing' }
OBlInfiniteElement >> findElementHolderForItemId: anId [
	self shouldBeImplemented
]

{ #category : #'children - accessing' }
OBlInfiniteElement >> findElementHolderForPosition: aPosition checkNew: shouldCheckNewPosition [

	<return: #BlInfiniteHolder or: nil>
	childrenManager
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			anElementHolder isRemoved ifFalse: [ 
				| shouldSkip |
				shouldSkip := shouldCheckNewPosition
					              ifTrue: [ anElementHolder position ~= aPosition ]
					              ifFalse: [ 
					              anElementHolder layoutPosition ~= aPosition ].
				shouldSkip ifFalse: [ ^ anElementHolder ] ] ]
		in: self.

	"We should not query cached element. It creates a problem during data source updates
	when we are dealing with already laid out elements. Also, for the public use, it is more
	reasonable to return null if position is not laid out"
	^ nil
]

{ #category : #'private - positions' }
OBlInfiniteElement >> findMinMaxChildLayoutPositions [
	<return: #Interval>
	
	| minPositionPreLayout maxPositionPreLayout |
	
	self hasChildren
		ifFalse: [ ^ NoPosition to: NoPosition ].

	minPositionPreLayout := Float infinity.
	maxPositionPreLayout := Float negativeInfinity.
	
	self childrenDo: [ :anElement | 
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			| aPosition |
			aPosition := anElementHolder layoutPosition.
			minPositionPreLayout := minPositionPreLayout min: aPosition.
			maxPositionPreLayout := maxPositionPreLayout max: aPosition ] ].
	^ minPositionPreLayout to: maxPositionPreLayout
]

{ #category : #scrolling }
OBlInfiniteElement >> fling: aVelocity [
	| aVelocityX aVelocityY canScrollHorizontal canScrollVertical |
	
	layoutFrozen
		ifTrue: [ ^ false ].
	
	canScrollHorizontal := self layout canScrollHorizontally.
	canScrollVertical := self layout canScrollVertically.
	
	aVelocityX := aVelocity x.
	aVelocityY := aVelocity y.
	
	(canScrollHorizontal not or: [ aVelocityX abs < self minFlingVelocity ])
		ifTrue: [ aVelocityX := 0 ].
	
	(canScrollVertical not or: [ aVelocityY abs < self minFlingVelocity ])
		ifTrue: [ aVelocityY := 0 ].
	
	"If we don't have any velocity, return false"
	(aVelocityX isZero and: [ aVelocityY isZero ])
		ifTrue: [ ^ false ].
	
	(canScrollHorizontal or: [ canScrollVertical ])
		ifTrue: [ 
			aVelocityX := self maxFlingVelocity negated max: (aVelocityX min: self maxFlingVelocity).
			aVelocityY := self maxFlingVelocity negated max: (aVelocityY min: self maxFlingVelocity).
			scrollFlinger flingBy: aVelocityX @ aVelocityY.
			^ true ].
	^ false
]

{ #category : #'item decorations - accessing' }
OBlInfiniteElement >> getDecorationsInsetsOfChildElement: anItemElement [

	| insets |
	insets := BlInsets all: 0.
	self itemDecorationsDo: [ :d | insets := (d getDecorationsInsetsOfChildElement: anItemElement) + insets ].
	^ insets
	
]

{ #category : #'accessing - properties' }
OBlInfiniteElement >> hasFixedSize [
	"Return true if changes in datasource content cannot change the size of the InfiniteElement itself"
	<return: #Boolean>

	^ hasFixedSize
]

{ #category : #'accessing - properties' }
OBlInfiniteElement >> hasFixedSize: aBoolean [
	"InfiniteElement can perform several optimizations if it can know in advance that InfiniteElement's
	size is not affected by the datasource contents. InfiniteElement can still change its size based
	on other factors (e.g. its parent's size) but this size calculation cannot depend on the
	size of its children or contents of its datasource (except the number of items in the datasource).
	If your use of InfiniteElement falls into this category, set this to true. It will allow
	InfiniteElement to avoid invalidating the whole layout when its datasource contents change"

	hasFixedSize := aBoolean
]

{ #category : #'item decorations - testing' }
OBlInfiniteElement >> hasItemDecorations [
	^ itemDecorations isNotEmpty
]

{ #category : #'private - testing' }
OBlInfiniteElement >> hasUpdatedChild [
	"Return true if any of existing elemnts holder needs to be updated"
	<return: #Boolean>

	self childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore not and:[
			anElementHolder isUpdated ])
				ifTrue: [ ^ true ] ].
	^ false 
]

{ #category : #initialization }
OBlInfiniteElement >> initialize [
	super initialize.
	
	hasFixedSize := false.
	firstLayoutComplete := false.
	layoutOrScrollCounter := 0.
	dispatchScrollCounter := 0.
	eatRequestLayoutCounter := 0.
	layoutFrozen := false.
	layoutRequestEaten := false.
	dataSourceChangedAfterLayout := false.
	dataSourceChangeDuringMeasure := false.
	itemsAddedOrRemoved := false.
	itemsChanged := false.
	preserveFocusAfterLayout := true.
	
	itemDecorations := OrderedCollection new.
	state := self defaultState.
	childrenUpdateRunnable := self defaultChildrenUpdateRunnable on: self.
	overScrollMode := self defaultOverScrollMode.
	scrollFlinger := self defaultScrollFlinger on: self.
	self initializeChildrenManager.
	self initializeDataSource.
	self initializeRecycler.
	
	"Should be initialized last"
	layout infiniteElement: self.
	
	self initializeEventHandlers
]

{ #category : #initialization }
OBlInfiniteElement >> initializeChildrenManager [
	childrenManager := self defaultChildrenManager
]

{ #category : #initialization }
OBlInfiniteElement >> initializeDataSource [
	dataSource := self defaultDataSource.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #initialization }
OBlInfiniteElement >> initializeEventHandlers [

	self addEventHandler: self defaultMouseScrollEventHandler
]

{ #category : #initialization }
OBlInfiniteElement >> initializeRecycler [
	recycler := self defaultRecycler
]

{ #category : #'private - invalidation' }
OBlInfiniteElement >> invalidateItemDecorations [
	"Invalidate all ItemDecorations.
	If I have item decorations, a layout update will be requested"

	self hasItemDecorations
		ifFalse: [ ^ self ].

	self assertNotInLayoutOrScroll.
	self markItemDecorationsInsetsDirty.
	self requestLayout
]

{ #category : #testing }
OBlInfiniteElement >> isAttached [
	"Return true if I am attached to window, false otherwise"
	<return: #Boolean>

	^ self space isNotNil
]

{ #category : #testing }
OBlInfiniteElement >> isComputingLayout [
	"Returns whether InfiniteElement is currently computing a layout.
	If this method returns true, it means that InfiniteElement is in a lockdown state and any
	attempt to update datasource contents will result in an exception because datasource contents
	cannot be changed while InfiniteElement is trying to compute the layout."
	<return: #Boolean>

	^ layoutOrScrollCounter > 0
]

{ #category : #testing }
OBlInfiniteElement >> isDataSourceChangedAfterLayout [
	^ dataSourceChangedAfterLayout
]

{ #category : #testing }
OBlInfiniteElement >> isFirstLayoutComplete [
	"Return true if layout process is completed, false otherwise.
	Set to true after onLayout: is done"
	<return: #Boolean>
	
	^ firstLayoutComplete
]

{ #category : #testing }
OBlInfiniteElement >> isLayoutFrozen [
	"Returns true if layout and scroll are frozen, false otherwise"
	<return: #Boolean>

	^ layoutFrozen
]

{ #category : #'item decorations - accessing' }
OBlInfiniteElement >> itemDecorations [
	^ itemDecorations
]

{ #category : #'item decorations - accessing' }
OBlInfiniteElement >> itemDecorationsDo: aBlock [

	itemDecorations ifNotNil: [ (itemDecorations asSortedCollection: [ :a :b | a priority < b priority ]) do: aBlock ]
]

{ #category : #'private - scrolling' }
OBlInfiniteElement >> jumpToPositionForSmoothScroller: aPosition [

	self layout scrollToPosition: aPosition.
	self awakenScrollBars
]

{ #category : #layout }
OBlInfiniteElement >> layoutFrozen: aBoolean [
	"Enable or disable layout and scroll.  After layoutFrozen is set to true,
	Layout requests will be postponed until layoutFrozen is set to false.
	Child elements are not updated when InfiniteElement is frozen"

	aBoolean = layoutFrozen
		ifTrue: [ ^ self ].
		
	self assertNotInLayoutOrScroll.

	aBoolean
		ifFalse: [ 
			layoutFrozen := false.
			layoutRequestEaten
				ifTrue: [ self requestLayout ].
			layoutRequestEaten := false ]
		ifTrue: [ 
			layoutFrozen := true.
			self stopScroll ]
]

{ #category : #accessing }
OBlInfiniteElement >> layoutPositionsRange [
	"layouted children interval"
	^ layoutPositionsRange 
]

{ #category : #accessing }
OBlInfiniteElement >> layoutPositionsRange: anInterval [
	"layouted children interval"
	layoutPositionsRange := anInterval
]

{ #category : #layout }
OBlInfiniteElement >> markDataSourceChangeDuringMeasure [
	dataSourceChangeDuringMeasure := true
]

{ #category : #'private - invalidation' }
OBlInfiniteElement >> markItemDecorationsInsetsDirty [

	childrenManager
		unfilteredChildrenDo: [ :anElement | 
		anElement constraints infinite insetsDirty: true ]
		in: self
]

{ #category : #layout }
OBlInfiniteElement >> markItemsAddedOrRemoved [
	itemsAddedOrRemoved := true
]

{ #category : #layout }
OBlInfiniteElement >> markItemsChanged [
	itemsChanged := true
]

{ #category : #'private - invalidation' }
OBlInfiniteElement >> markKnownElementsInvalid [

	"Mark all known elements as invalid. Used in response to a, the whole world might have changed data change event"

	childrenManager
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			anElementHolder shouldIgnore ifFalse: [ 
				anElementHolder flags addUpdate.
				anElementHolder flags addInvalid ] ]
		in: self.

	self markItemDecorationsInsetsDirty
]

{ #category : #layout }
OBlInfiniteElement >> markLayoutRequestEaten [
	layoutRequestEaten := true
]

{ #category : #'accessing - properties' }
OBlInfiniteElement >> maxFlingVelocity [
	^ 8000
]

{ #category : #'accessing - properties' }
OBlInfiniteElement >> minFlingVelocity [
	^ 50
]

{ #category : #notifying }
OBlInfiniteElement >> notifyChildAttached: anElement [
	"Notify all event handlers that element is attached to InfiniteElement"

	self fireEvent: (BlInfiniteElementAttachedEvent element: anElement)
]

{ #category : #notifying }
OBlInfiniteElement >> notifyChildDetached: anElement [
	"Notify all event handlers that element is detached from InfiniteElement"

	self fireEvent: (BlInfiniteElementDetachedEvent element: anElement)
]

{ #category : #notifying }
OBlInfiniteElement >> notifyScrollStateChanged: aScrollState [
	"Notify all event handlers that scroll state of InfiniteElement has been changed"

	self fireEvent: (BlInfiniteScrollChangedEvent scrollState: aScrollState)
]

{ #category : #'api - scrolling notifying' }
OBlInfiniteElement >> notifyScrolled: aPoint [
	"Notify all event handlers that InfiniteElemnet scrolled by a delta point"

	self eventDispatcher dispatchScrolled: aPoint
]

{ #category : #'children - geometry' }
OBlInfiniteElement >> offsetChildrenHorizontallyBy: aNumber [
	self childrenDo: [ :anElement |
		| previousPosition newPosition aBlBoundsUpdater |
		previousPosition := anElement position.
		newPosition := (previousPosition x + aNumber) @ previousPosition y.
	
		aBlBoundsUpdater := BlElementBoundsUpdater new.
		
		self flag: 'Implement BlElement>>#moveTo:'.
		anElement measuredBounds position: newPosition.
		anElement position: newPosition extent: anElement extent context: aBlBoundsUpdater.
		aBlBoundsUpdater commitChanges.
		
		self
			assert: [ newPosition closeTo: anElement position epsilon: BlElement epsilon ]
			description: [ 'Position didn''t change as expected! It is super important for scrolling, since we assume that I DO offset children by a number regardless of anything' ] ]
]

{ #category : #'children - geometry' }
OBlInfiniteElement >> offsetChildrenVerticallyBy: aNumber [
	
	self childrenDo: [ :anElement |
		| previousPosition newPosition aBlBoundsUpdater |

		previousPosition := anElement position.
		newPosition := previousPosition x @ (previousPosition y + aNumber).
		aBlBoundsUpdater := BlElementBoundsUpdater new.
		
		self flag: 'Implement BlElement>>#moveTo:'.
		anElement measuredBounds position: newPosition.
		anElement position: newPosition extent: anElement extent context: aBlBoundsUpdater.
		aBlBoundsUpdater commitChanges.

		self
			assert: [ newPosition closeTo: anElement position epsilon: BlElement epsilon ]
			description: [ 'Position didn''t change as expected! It is super important for scrolling, since we assume that I DO offset children by a number regardless of anything' ] ]
]

{ #category : #'private - commands' }
OBlInfiniteElement >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [

	childrenManager
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			(anElementHolder shouldIgnore not and: [ 
				 anElementHolder position >= aStartPosition ]) ifTrue: [ 
				anElementHolder
					offsetPositionBy: anItemCount
					applyToPreLayout: false.
				state structureChanged: true ] ]
		in: self.


	self requestLayout
]

{ #category : #'private - commands' }
OBlInfiniteElement >> offsetPositionRecordsForMove: aFromPosition to: aToPosition [

	| aStart anEnd anInBetweenOffset |
	aFromPosition < aToPosition
		ifTrue: [ 
			aStart := aFromPosition.
			anEnd := aToPosition.
			anInBetweenOffset := -1 ]
		ifFalse: [ 
			aStart := aToPosition.
			anEnd := aFromPosition.
			anInBetweenOffset := 1 ].

	childrenManager
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			(anElementHolder position between: aStart and: anEnd) ifTrue: [ 
				anElementHolder position = aFromPosition
					ifTrue: [ 
						anElementHolder
							offsetPositionBy: aToPosition - aFromPosition
							applyToPreLayout: false ]
					ifFalse: [ 
						anElementHolder
							offsetPositionBy: anInBetweenOffset
							applyToPreLayout: false ].
				state structureChanged: true ] ]
		in: self.

	self requestLayout
]

{ #category : #'private - commands' }
OBlInfiniteElement >> offsetPositionRecordsForRemove: aPositionStart itemCount: anItemCount applyToPreLayout: applyToPreLayout [

	| aPositionEnd |
	aPositionEnd := aPositionStart + anItemCount.

	childrenManager
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			anElementHolder shouldIgnore ifFalse: [ 
				anElementHolder position >= aPositionEnd
					ifTrue: [ 
						anElementHolder
							offsetPositionBy: anItemCount negated
							applyToPreLayout: applyToPreLayout.
						state structureChanged: true ]
					ifFalse: [ 
						anElementHolder position >= aPositionStart ifTrue: [ 
							anElementHolder
								flagRemovedAndOffsetPosition: aPositionStart - 1
								by: anItemCount negated
								applyToPreLayout: applyToPreLayout.
							state structureChanged: true ] ] ] ]
		in: self.

	self requestLayout
]

{ #category : #'hooks - children' }
OBlInfiniteElement >> onChildAttached: anElement [
	"Sent when an item element is attached to this InfiniteElement.
	My subclasses may want to perform extra bookkeeping or modifications of child elements
	as they become attached. This will be called before an InfiniteLayout measures or lays out
	the element and is a good time to perform these changes"
]

{ #category : #'hooks - children' }
OBlInfiniteElement >> onChildDetached: anElement [
	"I sent when an item element is detached from this InfiniteElement.
	My subclasses may want to perform extra bookkeeping or modifications
	of child elements as they become detached. This will be sent as an
	InfiniteLayout fully detaches the child element from the parent"
]

{ #category : #'hooks - layout' }
OBlInfiniteElement >> onEnterLayoutOrScroll [

	layoutOrScrollCounter := layoutOrScrollCounter + 1
]

{ #category : #'hooks - layout' }
OBlInfiniteElement >> onExitLayoutOrScroll [
	
	layoutOrScrollCounter := layoutOrScrollCounter - 1.

	layoutOrScrollCounter < 0
		ifTrue: [
			self error: 'layout or scroll counter cannot go below zero'.
			"it is important anyway to set counter to 0"
			layoutOrScrollCounter := 0 ]
]

{ #category : #layout }
OBlInfiniteElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	self dispatchLayout.
	firstLayoutComplete := true.
	
	self layout layoutIgnored: self context: aBlElementBoundsUpdateContext
]

{ #category : #'hooks - layout' }
OBlInfiniteElement >> onLayoutDone [

	"update decorations bounds after layout"

	| remainingBounds |
	super onLayoutDone.
	remainingBounds := self bounds asRectangle.
	self itemDecorationsDo: [ :d | remainingBounds := d onLayoutDoneIn: self remaining: remainingBounds ]
]

{ #category : #measurement }
OBlInfiniteElement >> onMeasure: anExtentMeasurementSpec [
	layout shouldAutoMeasure
		ifTrue: [ self onMeasureAuto: anExtentMeasurementSpec ]
		ifFalse: [ self onMeasureCustom: anExtentMeasurementSpec ].
		
	self layout measureIgnored: self with: anExtentMeasurementSpec
]

{ #category : #measurement }
OBlInfiniteElement >> onMeasureAuto: anExtentMeasurementSpec [
	| skipMeasure |

	skipMeasure := anExtentMeasurementSpec isExact.
	layout measure: self with: anExtentMeasurementSpec.
	skipMeasure
		ifTrue: [ ^ self ].

	self state isStartStep
		ifTrue: [ self dispatchLayoutFirstStep ].
	
	"set dimensions in 2nd step. Pre-layout should happen with old dimensions for consistency"
	layout measurementSpec: anExtentMeasurementSpec.
	self state isMeasuring: true.
	self dispatchLayoutSecondStep.
	
	"now we can get the width and height from the children"
	layout measureBasedOnChildren: anExtentMeasurementSpec.
	
	"if InfiniteElement has non-exact width and height and if there is at least one child
	which also has non-exact width & height, we have to re-measure."
	layout shouldMeasureTwice
		ifTrue: [ 
			layout measurementSpec: (BlExtentMeasurementSpec exact: self measuredExtent).
			self state isMeasuring: true.
			self dispatchLayoutSecondStep.
			"now we can get the width and height from the children."
			layout measureBasedOnChildren: anExtentMeasurementSpec ]
]

{ #category : #measurement }
OBlInfiniteElement >> onMeasureCustom: anExtentMeasurementSpec [
		
	hasFixedSize
		ifTrue: [ ^ layout measure: self with: anExtentMeasurementSpec ].
	
	"custom onMeasure"
	
	dataSourceChangeDuringMeasure ifTrue: [ 
		self eatRequestLayout.
		self processDataSourceCommands.
		dataSourceManager consumeCommandsInOnePassIn: self.
		self state isPreLayout: false .
		dataSourceChangeDuringMeasure := false.
		self resumeRequestLayout: false ].
	
	self state itemCount: dataSource itemCount.
	self eatRequestLayout.
	
	layout measure: self with: anExtentMeasurementSpec.
	self resumeRequestLayout: false.
	self state isPreLayout: false
]

{ #category : #'hooks - scrolling' }
OBlInfiniteElement >> onScrollStateChanged: aScrollingState [
	"Called when the scroll state of InfiniteElement changes.
	Subclasses should use this method to respond to state changes instead of an explicit listener.
	This method will always be invoked before firing events, but after the Layout responds to the scroll state change"
]

{ #category : #'hooks - scrolling' }
OBlInfiniteElement >> onScrolled: aPoint [

	"Sent when the scroll position of this InfiniteElement changes. Subclasses should use
	this method to respond to scrolling within the datasource's data set instead of an explicit event handler.
	I will always be invoked before event handlers. If a subclass needs to perform any additional upkeep
	or bookkeeping after scrolling but before events fired, this is a good place to do so"

	"self itemDecorationsDo: [ :d | d onScrollDoneIn: self ]"
]

{ #category : #'api - scrolling accessing' }
OBlInfiniteElement >> overScrollMode [
	^ overScrollMode
]

{ #category : #'api - scrolling accessing' }
OBlInfiniteElement >> overScrollMode: aBlOverScrollMode [
	overScrollMode := aBlOverScrollMode
]

{ #category : #'deferred actions' }
OBlInfiniteElement >> postChildrenUpdater [
	"Post children update runnable to consume update operations"
	self postOnAnimation: childrenUpdateRunnable
]

{ #category : #'deferred actions' }
OBlInfiniteElement >> postOnAnimation: aRunnableAction [
	self enqueueTask: aRunnableAction
]

{ #category : #'deferred actions' }
OBlInfiniteElement >> postSmoothScroller [
	scrollFlinger postOnAnimation
]

{ #category : #'accessing - properties' }
OBlInfiniteElement >> prefetchingAllowed [
	^ false
]

{ #category : #'private - commands' }
OBlInfiniteElement >> processDataSourceCommands [

	"Consumes data source commands and calculates which type of animations we want to run.
	Is sent in onMeasure and dispatchLayout.
	This method may process only the pre-layout state of updates or all of them."

	dataSourceChangedAfterLayout ifTrue: [ 
		dataSourceManager resetCommands.
		self markKnownElementsInvalid.
		layout onItemsChanged ].

	dataSourceManager consumeCommandsInOnePassIn: self
]

{ #category : #'private - scrolling' }
OBlInfiniteElement >> pullGlows: anEventPoint overscroll: anOverScrollPoint [
]

{ #category : #'private - focus' }
OBlInfiniteElement >> recoverFocusFromState [

	| aFocusTarget |
	(preserveFocusAfterLayout and: [ self hasFocus ]) ifFalse: [ ^ self ].

	"only recover focus if InfiniteElement itself has the focus"
	self isFocused ifFalse: [ self focusedChild ifNil: [ ^ self ] ].

	aFocusTarget := nil.

	self state focusedItemPosition ~= NoPosition ifTrue: [ 
		aFocusTarget := self findElementHolderForDataSourcePosition: self state focusedItemPosition ].

	(aFocusTarget isNil and: [ self state focusedItemId ~= NoId and: [ dataSource hasStableIds ] ]) ifTrue: [ 
		aFocusTarget := self findElementHolderForItemId: self state focusedItemId ].

	(aFocusTarget isNil or: [ aFocusTarget itemElement hasFocus or: [ aFocusTarget itemElement hasFocusable not ] ]) 
		ifTrue: [ ^ self ]

	"could not find element to give focus to"
]

{ #category : #accessing }
OBlInfiniteElement >> recycler [
	<return: #BlInfiniteRecycler>

	^ recycler
]

{ #category : #'children - add/remove' }
OBlInfiniteElement >> removeDetachedChild: anElement animate: shouldAnimate [
	| anElementHolder |
	
	anElementHolder := self elementHolderOf: anElement.
	
	anElementHolder isTmpDetached
		ifTrue: [ anElementHolder clearTmpDetached ]
		ifFalse: [ anElementHolder shouldIgnore
			ifFalse: [ self error: 'Trying to removeDetachedChild: which is not flagged as temporary detached!' ] ].
	
	self dispatchChildDetached: anElement.
	self removeDetachedChild: anElement
]

{ #category : #'children - add/remove' }
OBlInfiniteElement >> repositionShadowingElements [
	"self shouldBeImplemented"
]

{ #category : #layout }
OBlInfiniteElement >> requestLayout: anElement [
	
	"Layout may be requested by one of my children.
	If it is the case we should let layout request to pass further"
	self flag: 'Find a way to avoid unnecessary requests'.
	"anElement == self
		ifFalse: [ ^ super requestLayout: anElement ]."
	
	super requestLayout: anElement.

	"(eatRequestLayoutCounter isZero and: [ layoutFrozen not ])
		ifTrue: [ super requestLayout: anElement ]
		ifFalse: [ self markLayoutRequestEaten ]"
]

{ #category : #'private - focus' }
OBlInfiniteElement >> resetFocusInfo [
	"Reset all stored focus information from my state"

	self state focusedItemId: NoId.
	self state focusedItemPosition: NoPosition.
	self state focusedSubChild: nil
]

{ #category : #layout }
OBlInfiniteElement >> resumeRequestLayout: shouldPerformLayout [
	
	eatRequestLayoutCounter < 1
		ifTrue: [ self error: 'Invalid eat request layout count' ].

	shouldPerformLayout
		ifFalse: [ layoutRequestEaten := false ].
	
	eatRequestLayoutCounter = 1 ifTrue: [ 
		(shouldPerformLayout and: [
			layoutRequestEaten and: [ 
				layoutFrozen not ] ])
			ifTrue: [ self dispatchLayout ].
		layoutFrozen
			ifFalse: [ layoutRequestEaten := false ] ].
		
	eatRequestLayoutCounter := eatRequestLayoutCounter - 1
]

{ #category : #'private - focus' }
OBlInfiniteElement >> saveFocusInfo [
	"I save information of currently focused element in the state.
	In order to restore foces later we need to save item's position
	in data source, its stable it if any and store reference
	to the focused sub child of item's element to give it focus directly"
	| aFocusedElement aFocusedElementHolder |
	
	aFocusedElement := nil.
	
	(preserveFocusAfterLayout and: [ self hasFocus ])
		ifTrue: [ aFocusedElement := self focusedChild ].
	
	aFocusedElementHolder := aFocusedElement
		ifNotNil: [ :anElement | self childHolderContainingItemElement: anElement ].
		
	aFocusedElementHolder
		ifNil: [ self resetFocusInfo ]
		ifNotNil: [ 
			self state focusedItemId: (dataSource hasStableIds
				ifTrue: [ aFocusedElementHolder itemId ]
				ifFalse: [ NoId ]).
			self state focusedItemPosition: (dataSourceChangedAfterLayout
				ifTrue: [ NoPosition ]
				ifFalse: [ aFocusedElementHolder dataSourcePosition ]).
			self state focusedSubChild: (self deepestFocusedChildIn: aFocusedElementHolder itemElement) ]
]

{ #category : #scrolling }
OBlInfiniteElement >> scrollBy: aPoint [ 
	| canScrollHorizontal canScrollVertical |

	layoutFrozen
		ifTrue: [ ^ self ].
		
	canScrollHorizontal := self layout canScrollHorizontally.
	canScrollVertical := self layout canScrollVertically.
	
	(canScrollHorizontal or: [ canScrollVertical ])
		ifTrue: [ 
			self scrollByInternal: (canScrollHorizontal
				ifTrue: [ aPoint x ]
				ifFalse: [ 0 ]) @ (canScrollVertical
					ifTrue: [ aPoint y ]
					ifFalse: [ 0 ])
			from: nil ]
]

{ #category : #'private - scrolling' }
OBlInfiniteElement >> scrollByInternal: aDeltaPoint from: anEventPoint [
	<return: #Boolean>
	| unconsumedX unconsumedY consumedX consumedY |

	unconsumedX := unconsumedY := consumedX := consumedY := 0.
	
	self consumePendingDataSourceCommands.
	self eatRequestLayout.
	self onEnterLayoutOrScroll.
	
	aDeltaPoint x isZero
		ifFalse: [ 
			consumedX := self layout scrollHorizontallyBy: aDeltaPoint x.
			unconsumedX := aDeltaPoint x - consumedX ].
	aDeltaPoint y isZero
		ifFalse: [ 
			consumedY := self layout scrollVerticallyBy: aDeltaPoint y.
			unconsumedY := aDeltaPoint y - consumedY ].
	
	self repositionShadowingElements.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false.
	
	self overScrollMode ~= BlOverScrollMode never
		ifTrue: [ 
			anEventPoint ifNotNil: [ 
				self pullGlows: anEventPoint overscroll: unconsumedX @ unconsumedY ].
			self considerReleasingGlowsOnScroll: aDeltaPoint ].
	
	(consumedX isZero and: [ consumedY isZero ])
		ifFalse: [ self dispatchOnScrolled: consumedX @ consumedY ].
	
	^ consumedX isZero not or: [ consumedY isZero not ]
]

{ #category : #'api - scrolling accessing' }
OBlInfiniteElement >> scrollFlinger [
	^ scrollFlinger
]

{ #category : #'api - scrolling' }
OBlInfiniteElement >> scrollHorizontallyBy: aNumber [
	"Scroll horizontally by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>

	^ self layout scrollHorizontallyBy: aNumber
]

{ #category : #'api - scrolling geometry' }
OBlInfiniteElement >> scrollPosition [
	<return: #Point>
	
	^ 0@0
]

{ #category : #'private - scrolling accessing' }
OBlInfiniteElement >> scrollState [
	"Return the current scrolling state"
	<return: #Symbol>
	
	^ scrollState
]

{ #category : #'private - scrolling accessing' }
OBlInfiniteElement >> scrollState: aScrollState [
	"Internal! Never set me directly"

	 scrollState = aScrollState
		ifTrue: [ ^ self ].

	scrollState := aScrollState.
	scrollState ~= ScrollSettling
		ifTrue: [ self stopScrollersInternal ].

	self dispatchScrollStateChanged: aScrollState
]

{ #category : #scrolling }
OBlInfiniteElement >> scrollToPosition: aPosition [
	"Convenience method to scroll to a certain datasource position.
	InfiniteElement does not implement scrolling logic, rather forwards the call to
   InfiniteElement>>#scrollToPosition:"

	layoutFrozen
		ifTrue: [ ^ self ].

	self stopScroll.
	self layout scrollToPosition: aPosition.
	self awakenScrollBars
]

{ #category : #'api - scrolling' }
OBlInfiniteElement >> scrollVerticallyBy: aNumber [
	"Scroll vertically by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>

	^ self layout scrollVerticallyBy: aNumber
]

{ #category : #'private - invalidation' }
OBlInfiniteElement >> setDataSourceChangedAfterLayout [

	"We already set that data source is changed"

	dataSourceChangedAfterLayout ifTrue: [ ^ self ].

	dataSourceChangedAfterLayout := true.
	childrenManager
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			anElementHolder shouldIgnore ifFalse: [ 
				anElementHolder flags addDataSourcePositionUnknown ] ]
		in: self.

	"immediately mark all elements as invalid, so prefetched ones can be
	differentiated from elements bound to previous data set - both in children, and cache"
	self markKnownElementsInvalid
]

{ #category : #scrolling }
OBlInfiniteElement >> smoothScrollBy: aPoint [
	"Animate a scroll by the given amount of pixels along either axis"
	| dX dY |
	
	layoutFrozen
		ifTrue: [ ^ self ].
	
	dX := aPoint x.
	dY := aPoint y.
	
	self canScrollHorizontally
		ifFalse: [ dX := 0 ].
	
	self canScrollVertically
		ifFalse: [ dY := 0 ].
	
	(dX isZero and: [ dY isZero ])
		ifFalse: [ scrollFlinger smoothScrollBy: dX @ dY ]
]

{ #category : #scrolling }
OBlInfiniteElement >> smoothScrollToPosition: aPosition [
	"Starts a smooth scroll to a datasource position."
	
	layoutFrozen
		ifTrue: [ ^ self ].
	
	self layout smoothScrollToPosition: aPosition
]

{ #category : #'api - scrolling accessing' }
OBlInfiniteElement >> smoothScroller [
	"Return currently used smooth scroller or nil if I am not in a smooth scrolling state"
	<return: #BlSmoothScroller or: nil>

	^ self layout smoothScroller
]

{ #category : #accessing }
OBlInfiniteElement >> state [
	^ state
]

{ #category : #scrolling }
OBlInfiniteElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"

	self scrollState: ScrollIdle.
	self stopScrollersInternal
]

{ #category : #'private - scrolling' }
OBlInfiniteElement >> stopScrollersInternal [
	"Similar to #stopScroll but does not set the state"

	scrollFlinger stop.
	self layout stopSmoothScroller
]

{ #category : #'accessing - decoration' }
OBlInfiniteElement >> withDecoration: aDecorationClass [

	self itemDecorations
		detect: [ :d | d isKindOf: aDecorationClass ]
		ifNone: [ 
			self itemDecorations add: aDecorationClass new.
			self invalidateItemDecorations ]
]

{ #category : #'accessing - decoration' }
OBlInfiniteElement >> withoutDecoration: aDecorationClass [

	itemDecorations := self itemDecorations reject: [ :d | 
		                   (d isKindOf: aDecorationClass)
			                   ifTrue: [ 
				                   self invalidateItemDecorations.
				                   true ]
			                   ifFalse: [ false ] ]
]
