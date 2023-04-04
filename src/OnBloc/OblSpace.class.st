"
I'm a replacement for `BlSpace`. The idea is to simplify and to remove complex  computations that are implemented in `BlSpace`. 
For now
- I don't use layout resizing propagation rules at all (compare `BlSpace>>#doStyle` and `ToSpace>>#doStyle`)

- I bring a different toplevel structure. I'm made of a `layerHolder` with owns all top level holders which are layouted on top of each other, with the same extent (`rootLayer`, `contextMenuLayer` and `popupLayer`) 

## Comments from `BlSpace`
I am the logical representation of a window in Bloc regardless of the current Host in use.
Here are some of the important objects I use and talk to:
- `BlCursor`
- `BlTime`
- Various `BlBaseEventProcessor` subclasses broker `BlEvent` types
- `BlSpaceFrame`

## Gracefully closing the image when a space is closed
A common use case is to quit the application when some particular space is closed. To do this, we provide `BlSpaceShutdownOnCloseListener` which can be added to any space as an event handler. It listens for a `BlSpaceClosedEvent`, which is sent after a space is closed. See the listener class for configuration options.

"
Class {
	#name : #OBlSpace,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TBlSpaceProperties + TBlDebug',
	#classTraits : 'TBlEventTarget classTrait + TBlSpaceProperties classTrait + TBlDebug classTrait',
	#instVars : [
		'id',
		'host',
		'hostSpace',
		'extent',
		'position',
		'resizable',
		'borderless',
		'dirtyAreas',
		'eventDispatcher',
		'eventListener',
		'eventRecorder',
		'mouseProcessor',
		'focusProcessor',
		'keyboardProcessor',
		'focusChain',
		'dragboard',
		'nextPulseRequested',
		'currentCursor',
		'session',
		'focused',
		'title',
		'fullscreen',
		'fullsize',
		'layoutError',
		'tasks',
		'time',
		'frame',
		'elementsNeedingPaint',
		'elementsNeedingLayout',
		'telemetry',
		'reference',
		'elementsNeedingStyle',
		'elementsNeedingPropertiesComputation',
		'iconStencil',
		'contextMenuLayer',
		'popupLayer',
		'rootLayer',
		'layerHolder',
		'overlayLayer'
	],
	#classVars : [
		'UniqueIdGenerator'
	],
	#category : #'OnBloc-Space'
}

{ #category : #'private - change' }
OBlSpace class >> extractRoots: aSetOfElements [
	| theElementsToCheck theElementsToProcess |
	
	theElementsToCheck := aSetOfElements as: Stack.
	theElementsToProcess := Set new.
	
	[ theElementsToCheck isEmpty ] whileFalse: [
		| eachElement |
		
		eachElement := theElementsToCheck pop.
		(theElementsToCheck anySatisfy: [ :eachPotentialParent | eachElement hasParent: eachPotentialParent ])
			ifFalse: [ theElementsToProcess add: eachElement ] ].

	^ theElementsToProcess
]

{ #category : #'class initialization' }
OBlSpace class >> initialize [
	UniqueIdGenerator := BlUniqueIdGenerator new
]

{ #category : #'debug - simulation' }
OBlSpace class >> locationInside: anElement [
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	anElement topMostParent forceLayout.
	theBounds := anElement bounds inSpace bounds.
	aPosition := theBounds atRandom.
		
	self
		assert: [ theBounds containsPoint: aPosition ]
		description: [ 'Point({1}) must be inside of the bounds({2})' format: { aPosition . theBounds } ].
		
	^ aPosition
]

{ #category : #'debug - simulation' }
OBlSpace class >> locationOutside: anElement [
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	anElement topMostParent forceLayout.
	theBounds := anElement bounds inSpace bounds.
	aPosition := {
		theBounds topRight - (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds topRight + (100 atRandom @ theBounds height asInteger atRandom).
		theBounds bottomLeft + (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds bottomLeft - (100 atRandom @ theBounds height asInteger atRandom).
	}	atRandom.
		
	self
		assert: [ (theBounds containsPoint: aPosition) not ]
		description: [ 'Point must be outside of the bounds' ].
		
	^ aPosition
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateClickOn: anElement [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	<return: #Point>
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition }
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateClickOutside: anElement [
	"Simulate a click event in outside of a given element by
	performing mouse down and mouse up events in a sequence"
	| aPosition |
	
	aPosition := self locationOutside: anElement.
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateDoubleClickOn: anElement [
	"Simulate a double click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a double click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition.
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition. }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateDragOn: anElement by: aBlVector [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	| aPosition aDelta |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	aDelta := (anElement localBoundsToGlobal: (BlBounds origin: 0.0@0.0 extent: aBlVector)) extent.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseMoveEvent primary position: aPosition + aDelta.
			BlMouseUpEvent primary position: aPosition + aDelta }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateEvent: anEvent on: anElement [
	"I simulate a given low level space UI event such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordinates of the provided element.
	Note: I create a temporary space if provided element does not have one. if you need to simulate
	a sequence of dependent events it is better to use #simulateEvents:on: directy"

	self simulateEvents: { anEvent } on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
	"I simulate a given sequence of low level space UI events such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordinates of the provided element"
	
	"we should update timestamps"
	aCollectionOfEvents do: [ :anEvent | anEvent timestamp: DateAndTime now ].
	
	anElement isAttachedToSceneGraph
		ifTrue: [
			| aSpace |
			"element may be removed from the space."
			aSpace := anElement space.
			aSpace pulse.
			aCollectionOfEvents do: [ :anEvent | aSpace dispatchEvent: anEvent ].
			aSpace dispatchEvent: BlSpaceEventsProcessedEvent new.
			aSpace pulse ]
		ifFalse: [ 
			| temporarySpace topMostElement |
			topMostElement := anElement topMostParent.
			[ 
				temporarySpace := self new.
				temporarySpace root addChild: topMostElement.
				temporarySpace pulse.
				aCollectionOfEvents do: [ :anEvent | temporarySpace dispatchEvent: anEvent ].
				temporarySpace dispatchEvent: BlSpaceEventsProcessedEvent new.
				temporarySpace pulse
			] ensure: [ topMostElement removeFromParent ] ]
	
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateKeyDownOn: anElement key: aBlKeyboardKey [
	"Simulate a key down event"

	self
		simulateEvents: { BlKeyDownEvent new key: aBlKeyboardKey; scanCode: aBlKeyboardKey valueOrZero }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateKeyUpOn: anElement key: aBlKeyboardKey [
	"Simulate a key up event"

	self
		simulateEvents: { BlKeyUpEvent new key: aBlKeyboardKey; scanCode: aBlKeyboardKey valueOrZero }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateMouseDownOn: anElement [
	"Simulate a mouse down event in the middle of a given element"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvents: { BlMouseDownEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateMouseDownOn: anElement at: aPoint [
	"Simulate a mouse down event at a given location in the space of the element"

	self
		simulateEvents: { BlMouseDownEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateMouseMoveInside: anElement [
	"Simulate a mouse move event at a random location within element's bounds"
	| aPosition |
	
	aPosition := self locationInside: anElement.

	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateMouseMoveOn: anElement at: aPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary
			position: aToPoint;
			delta: (aToPoint - aFromPoint)  }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateMouseMoveOutside: anElement [
	"Simulate a mouse move event at a random location outside of element's bounds"
	| aPosition |
	
	"we never know if an element was already layered out"
	aPosition := self locationOutside: anElement.
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateMouseUpOn: anElement [
	"Simulate a mouse up event in the middle of a given element"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvents: { BlMouseUpEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateMouseUpOn: anElement at: aPoint [
	"Simulate a mouse up event at a given location in the space of the element"

	self
		simulateEvents: { BlMouseUpEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateMouseWheelOn: anElement by: aBlVector [
	"Simulate a mouse wheel event in the middle of a given element"
	| aPosition aBlocEvent |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"Bloc event"
	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: aBlVector asBlocVector;
		position: aPosition.
	
	self
		simulateEvent: aBlocEvent
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
OBlSpace class >> simulateSecondaryClickOn: anElement [
	"Simulate a secondary click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	<return: #Point>
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a secondary click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent secondary position: aPosition.
			BlMouseUpEvent secondary position: aPosition }
		on: anElement.
		
	^ aPosition
]

{ #category : #'class initialization' }
OBlSpace class >> spaceWithId: aSpaceId do: aBlock [
	^ self allSubInstances
		detect: [ :eachSpace | eachSpace id = aSpaceId ]
		ifFound: aBlock
		ifNone: [ nil ]
]

{ #category : #'api - adding children' }
OBlSpace >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	
	self root addChild: anElement
]

{ #category : #drawing }
OBlSpace >> aeAsForm [

	^ self layerHolder aeAsForm
]

{ #category : #drawing }
OBlSpace >> aeDrawOn: aeCanvas [

	self layerHolder aeFullDrawOn: aeCanvas

]

{ #category : #accessing }
OBlSpace >> asReference [
	<return: #BlSpaceReference>

	^ reference ifNil: [ reference := BlAttachedCachedSpaceReference forSpace: self ]
]

{ #category : #'-- extensions-sparta --' }
OBlSpace >> asSpartaForm [
	<return: #Form>

	^ self layerHolder asSpartaForm
]

{ #category : #'change - rendering' }
OBlSpace >> beDirtyArea [

	self
		invalidRect:
		(BlBounds origin: 0.0 @ 0.0 extent: self layerHolder extent)
		from: self layerHolder
]

{ #category : #'api - displaying' }
OBlSpace >> becomeVisible [
	"Notify root element that it is now visible to the user"
	self layerHolder space: self

]

{ #category : #'window - properties' }
OBlSpace >> borderless [
	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace borderless ]
		ifAbsent: [ borderless ]
]

{ #category : #'window - properties' }
OBlSpace >> borderless: aBoolean [
	borderless := aBoolean.
	 self hostSpaceDo: [ :aHostSpace | aHostSpace borderless: aBoolean ].
]

{ #category : #accessing }
OBlSpace >> bounds [

	^ BlBounds origin: self position extent: self extent
]

{ #category : #'change - properties' }
OBlSpace >> canComputeProperties: anElement [
	"Return true if properties of the given element can be computed"
	<return: #Boolean>

	^ anElement hasParent and: [ anElement parent needsPropertiesComputation not ]
]

{ #category : #'api - displaying' }
OBlSpace >> center [
	"Tell host to change my position to be centered. Do nothing if host space is not present (e.g. not shown)."

	self hostSpace ifNotNil: [ :hw | hw center ]
]

{ #category : #'children - accessing' }
OBlSpace >> children [

	^ self layerHolder children
]

{ #category : #'change - rendering' }
OBlSpace >> clearDirtyAreas [

	"Clear all dirty areas.
	Default implementation simply removes all areas from the collection"

	self dirtyAreas removeAll.
	self elementsNeedingPaint removeAll
]

{ #category : #'api - displaying' }
OBlSpace >> close [
	"Delegate closing work to the Universe"
	
	(BlParallelUniverse forHost: self host class) closeSpace: self
]

{ #category : #'api - painting' }
OBlSpace >> compositionLayer [
	"Return my composition layer if I have one or nil otherwise"
	<return: #BlCompositionLayer or: nil>

	^ self layerHolder compositionLayer
]

{ #category : #accessing }
OBlSpace >> contextMenuLayer [
	"Return my current root element.
	root can not be nil"
	
	^ contextMenuLayer
]

{ #category : #'cursor managing' }
OBlSpace >> currentCursor [
	^ currentCursor 
]

{ #category : #'cursor managing' }
OBlSpace >> currentCursor: aCursor [

	currentCursor ifNotNil: [ :cc | cc deactivateOn: self ].
	currentCursor := aCursor.
	currentCursor ifNil: [ ^ self updateCursor: BlCursor default ].
	currentCursor activateOn: self
]

{ #category : #initialization }
OBlSpace >> defaultContextMenuElevation [

	^ 50
]

{ #category : #initialization }
OBlSpace >> defaultContextMenuLayer [

	^ BlElement new
		  background: Color transparent;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		  elevation:
			  (BlRelativeElevation elevation: self defaultContextMenuElevation);
		  labeled: 'Context menu layer';
		  yourself
]

{ #category : #initialization }
OBlSpace >> defaultEventDispatcher [
	^ BlDirectEventDispatcher on: self
]

{ #category : #initialization }
OBlSpace >> defaultEventListener [
	^ BlSpaceEventListener space: self
]

{ #category : #initialization }
OBlSpace >> defaultEventRecorder [
	^ BlEmptyEventRecorder new
]

{ #category : #initialization }
OBlSpace >> defaultExtent [
	^ 800@600
]

{ #category : #initialization }
OBlSpace >> defaultLayerHolder [

	^ BlElement new
		  layout: BlFrameLayout new;
		  labeled: 'Top';
		  yourself
]

{ #category : #initialization }
OBlSpace >> defaultOverlayElevation [

	^ 40
]

{ #category : #initialization }
OBlSpace >> defaultOverlayLayer [

	^ BlElement new
		  background: Color transparent;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		  elevation:
			  (BlRelativeElevation elevation: self defaultOverlayElevation);
		  labeled: 'Overlay layer';
		  yourself
]

{ #category : #initialization }
OBlSpace >> defaultPopupElevation [

	^ 100
]

{ #category : #initialization }
OBlSpace >> defaultPopupLayer [

	^ BlElement new
		  background: Color transparent;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		  elevation:
			  (BlRelativeElevation elevation: self defaultPopupElevation);
		  labeled: 'Popup layer';
		  yourself
]

{ #category : #initialization }
OBlSpace >> defaultRoot [

	^ BlElement new
		  background: self defaultRootBackground;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		  elevation:
			  (BlRelativeElevation elevation: self defaultRootElevation);
		  labeled: self defaultRootLabel;
		  yourself
]

{ #category : #initialization }
OBlSpace >> defaultRootBackground [
	^ Color white
]

{ #category : #initialization }
OBlSpace >> defaultRootElevation [

	^ 0
]

{ #category : #initialization }
OBlSpace >> defaultRootLabel [
	^ 'Root element'
]

{ #category : #initialization }
OBlSpace >> defaultTitle [
	^ ''
]

{ #category : #'window - properties' }
OBlSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace densityDpi ]
		"Without an actual window we can only guess"
		ifAbsent: [ 96.0 ]
]

{ #category : #'api - tasks' }
OBlSpace >> dequeueTask: aBlTask [
	self taskQueue dequeue: aBlTask.
	self requestNextPulse
]

{ #category : #'host space - accessing' }
OBlSpace >> detachHostSpace [
	"Detach my current host space if I have one"

	hostSpace := nil
]

{ #category : #accessing }
OBlSpace >> dirtyAreas [
	<return: #SequenceableCollection of: #BlBounds>

	^ dirtyAreas
]

{ #category : #'children dispatching' }
OBlSpace >> dispatchAddedToSceneGraph [
	"Sent after any of my parents or I was added to scene graph.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self layerHolder dispatchAddedToSceneGraph

]

{ #category : #'children dispatching' }
OBlSpace >> dispatchRemovedFromSceneGraph [
	"Sent after topFrame was removed from scene graph.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self layerHolder dispatchRemovedFromSceneGraph
]

{ #category : #pulse }
OBlSpace >> dispatchTimeEvent: aSpaceStepEventClass during: aBlock [
	| aStartTime |
	
	aStartTime := self time now.
	aBlock cull: self.
	self eventDispatcher dispatchEvent:
			(aSpaceStepEventClass new
				start: aStartTime;
				end: self time now;
				yourself)
]

{ #category : #'change - properties' }
OBlSpace >> doComputeProperties [
	| theElementToProcess |
	
	"if everything is clean, do nothing"
	(self needsPropertiesComputation)
		ifFalse: [ ^ self ].

	"only care about element that are attached to this space"
	theElementToProcess := self extractAttachedElements: self elementsNeedingPropertiesComputation.

	"first we should make sure that all parents have resolved properties"
	theElementToProcess := self extractUnresolvedToComputeProperties: theElementToProcess.

	"then we should eliminate child elements if their parent is already on the list"
	theElementToProcess := self extractRoots: theElementToProcess.
	
	self elementsNeedingPropertiesComputation removeAll.
	
	((theElementToProcess includes: self layerHolder) or: [ self layerHolder needsPropertiesComputation ])
		ifTrue: [ self doComputePropertiesFromRoot: self layerHolder ]
		ifFalse: [ self doComputePropertiesOf: theElementToProcess ]
]

{ #category : #'change - properties' }
OBlSpace >> doComputeProperties: anElement withGlobalProperties: aGlobalResolvedProperties [
	self
		assert: [ anElement hasParent ]
		description: [ 'Can not compute properties of an element without parent' ].

	self
		assert: [ anElement parent needsPropertiesComputation not ]
		description: [ 'Parent properties must be computed' ].

	self
		doComputeProperties: anElement
		withParentProperties: anElement parent properties maybeResolvedProperties propertiesToPropagateToChildren
		withGlobalProperties: aGlobalResolvedProperties
]

{ #category : #'change - properties' }
OBlSpace >> doComputeProperties: anElement withParentProperties: aParentResolvedProperties withGlobalProperties: aGlobalResolvedProperties [
	| theResolvedProperties thePropagatableProperties |

	self
		assert: [ aParentResolvedProperties isKindOf: BlElementPropagatableProperties ]
		description: [ 'Parent properties must be propagatable' ].
		
	self
		assert: [ aGlobalResolvedProperties isKindOf: BlElementPropagatableProperties ]
		description: [ 'Global properties must be propagatable' ].

	theResolvedProperties := anElement properties
		resolveWithParentProperties: aParentResolvedProperties
		orGlobal: aGlobalResolvedProperties.

	thePropagatableProperties := theResolvedProperties propertiesToPropagateToChildren.

	anElement childrenDo: [ :eachChild |
		self
			doComputeProperties: eachChild
			withParentProperties: thePropagatableProperties 
			withGlobalProperties: aGlobalResolvedProperties ].

	"we need to merge properties starting from global"
	((aGlobalResolvedProperties
		mergedWithProperties: aParentResolvedProperties)
			mergedWithProperties: theResolvedProperties)
				applyOnElement: anElement.

	anElement properties flushPropertiesToRemove
]

{ #category : #'change - properties' }
OBlSpace >> doComputePropertiesFromRoot: aRootElement [
	| theGlobalResolvedProperties |

	aRootElement properties
		resolveWithParentProperties: BlElementResolvedProperties new
		orGlobal: BlElementResolvedProperties new.
	
	theGlobalResolvedProperties := aRootElement properties maybeResolvedProperties propertiesToPropagateToChildren.
	
	self
		doComputeProperties: aRootElement
		withParentProperties: theGlobalResolvedProperties
		withGlobalProperties: theGlobalResolvedProperties
]

{ #category : #'change - properties' }
OBlSpace >> doComputePropertiesOf: aCollectionOfElements [
	| theGlobalResolvedProperties |

	self
		assert: [ (aCollectionOfElements includes: self layerHolder) not ]
		description: [ 'Must not include root' ].

	theGlobalResolvedProperties := self layerHolder properties maybeResolvedProperties propertiesToPropagateToChildren.
	aCollectionOfElements do: [ :eachElement |
		"it is possible that properties manipulate the graphical scene,
		therefore we have to check it here again"
		eachElement hasParent
			ifTrue: [
				self
					doComputeProperties: eachElement
					withGlobalProperties: theGlobalResolvedProperties ] ]
]

{ #category : #'change - layout' }
OBlSpace >> doLayout [
	| layoutCounter maxLayoutCount |

	self
		assert: [ self isLayoutRequested ]
		description: [ 'Root element must request layout in order to update it' ].

	[
		layoutCounter := 0.
		maxLayoutCount := 100.

		[ self hasLayoutError not and: [ self isLayoutRequested and: [ layoutCounter < maxLayoutCount ] ] ]
			whileTrue: [
				self doUpdateLayout.
				layoutCounter := layoutCounter + 1.
				layoutCounter = 50
					ifTrue: [ 'Warning: Layout was performed 50 times per frame!' traceCr ] ].

		self layerHolder dispatchLayoutDone

	"I prevent infinite spawn of debuggers"
	] on: Error do: [ :anError |
		layoutError := anError.
		[ layoutError debug ] ensure: [ layoutError := nil ] ].
]

{ #category : #'change - style' }
OBlSpace >> doStyle [
	| theElementsToStyle |
	
	self needsStyleComputation
		ifFalse: [ ^ self ].
	
	"only care about element that are attached to this space"
	theElementsToStyle := self elementsNeedingStyle.

	"first we should make sure that all parents are styled"
	theElementsToStyle := self extractUnstyled: theElementsToStyle.

	"then we should eliminate child elements if their parent is already on the list"
	theElementsToStyle := self extractRoots: theElementsToStyle.
	
	self elementsNeedingStyle removeAll.
	
	theElementsToStyle do: [ :eachElement | self doStyle: eachElement ]
]

{ #category : #'change - style' }
OBlSpace >> doStyle: anElement [
	anElement applyStyles
]

{ #category : #'focus managing' }
OBlSpace >> doUpdateFocus [
	(self focusOwner notNil and: [ self focusOwner isAttachedToSceneGraph not ])
		ifTrue: [
			focusChain
				deepestAttachedElementDo: [ :aNewFocusOwner |
					aNewFocusOwner requestFocusDueTo: BlFocusDueToRemovedFromSpaceReason uniqueInstance ]
				ifAbsent: [ self focusProcessor focusOwner: nil ] ].

	self focusOwner
		ifNil: [ self initializeFocus ]
]

{ #category : #'change - layout' }
OBlSpace >> doUpdateLayout [
	| elementsToLayout aBlElementBoundsUpdater |
	
	self elementsNeedingLayout copy do: [ :eachElement |
		eachElement privatePreviousMeasurementSpec
			ifNil: [
				self elementsNeedingLayout remove: eachElement.
				eachElement requestLayout ] ].
	
	elementsToLayout := self elementsNeedingLayout reject: [ :eachElement |
		| shouldIgnore |
		
		shouldIgnore := false.
		
		self elementsNeedingLayout do: [ :eachPotentialParent |
			(eachElement hasParent: eachPotentialParent)
				ifTrue: [
					eachElement
						allParentsTo: eachPotentialParent
						do: [ :eachParent | eachParent privateRequestingLayout: true ].
					shouldIgnore := true ] ].
		
		shouldIgnore ].
	
	"we should clear the elements needing layout before we compute layout to support multiple layout passes"
	self elementsNeedingLayout removeAll.
	
	elementsToLayout := elementsToLayout
		collect: [ :eachElement | eachElement -> eachElement compositionDepth ] as: Array.
	elementsToLayout := (elementsToLayout sort: [ :a :b | a value > b value ]) collect: [ :each | each key ].

	aBlElementBoundsUpdater := BlElementBoundsUpdater new.

	elementsToLayout do: [ :eachElement |
		self doUpdateLayoutBoundary: eachElement context: aBlElementBoundsUpdater ].
	
	self layerHolder isLayoutRequested
		ifTrue: [ self doUpdateLayout: self layerHolder context: aBlElementBoundsUpdater ].
		
	aBlElementBoundsUpdater commitChanges
]

{ #category : #'change - layout' }
OBlSpace >> doUpdateLayout: anElement context: aBlElementBoundsUpdater [
	"Perform layout of a given element (e.g. root or glass)"

	| currentExtent |
	"First, we measure..."
	currentExtent := self extent.
	anElement measure: (BlExtentMeasurementSpec new
		widthSpec: (anElement layout
			measurementSpecFor: (BlMeasurementSpec exact: currentExtent x)
			usedSize:  0.0
			resizer: BlLayoutResizer matchParent);
		heightSpec: (anElement layout
			measurementSpecFor: (BlMeasurementSpec exact: currentExtent y)
			usedSize:  0.0
			resizer: BlLayoutResizer matchParent)).

	"...then, we layout in measured during previous step bounds"
	anElement
		applyLayoutIn: anElement measuredBounds asRectangle
		context: aBlElementBoundsUpdater

]

{ #category : #'change - layout' }
OBlSpace >> doUpdateLayoutBoundary: anElement context: aBlElementBoundsUpdater [
	"Perform layout of a given element (e.g. root or glass)"

	"first we measure.."
	anElement measure: anElement privatePreviousMeasurementSpec.

	"...then we layout in measured during previous step bounds"
	anElement applyLayoutIn: (anElement position extent: anElement measuredBounds extent) context: aBlElementBoundsUpdater
]

{ #category : #accessing }
OBlSpace >> dragboard [
	^ dragboard
]

{ #category : #accessing }
OBlSpace >> dragboard: anObject [
	dragboard := anObject
]

{ #category : #'change - layout' }
OBlSpace >> elementsNeedingLayout [
	^ elementsNeedingLayout
]

{ #category : #'change - rendering' }
OBlSpace >> elementsNeedingPaint [

	^ elementsNeedingPaint
]

{ #category : #'change - layout' }
OBlSpace >> elementsNeedingPropertiesComputation [
	^ elementsNeedingPropertiesComputation ifNil: [ elementsNeedingPropertiesComputation := Set new ]
]

{ #category : #'change - layout' }
OBlSpace >> elementsNeedingStyle [
	^ elementsNeedingStyle
		ifNil: [ elementsNeedingStyle := Set new ]
]

{ #category : #'api - tasks' }
OBlSpace >> enqueueTask: aBlTask [
	aBlTask onEnqueued: self.
	self taskQueue enqueue: aBlTask.
	self requestNextPulse
]

{ #category : #'api - tasks' }
OBlSpace >> enqueueTasksFrom: aTaskQueue [
	aTaskQueue tasks do: [ :eachTask | eachTask onEnqueued: self ].	
	self taskQueue enqueueFrom: aTaskQueue.
	self requestNextPulse
]

{ #category : #pulse }
OBlSpace >> ensureSession [
	"Check current session and perform required operations if it changed since last frame"

	session == Smalltalk session
		ifTrue: [ ^ self ].

	self onSessionChanged: Smalltalk session
]

{ #category : #'event management accessing' }
OBlSpace >> eventDispatcher [
	^ eventDispatcher
]

{ #category : #accessing }
OBlSpace >> eventListener [
	^ eventListener
]

{ #category : #accessing }
OBlSpace >> eventListener: anObject [
	eventListener := anObject
]

{ #category : #accessing }
OBlSpace >> eventRecorder [
	<return: #BlSpaceEventRecorder>

	^ eventRecorder
]

{ #category : #accessing }
OBlSpace >> eventRecorder: anEventRecorder [
	eventRecorder := anEventRecorder
]

{ #category : #'window - properties' }
OBlSpace >> extent [
	<return: #Point>

	^ self windowExtent
]

{ #category : #'window - properties' }
OBlSpace >> extent: aNewExtent [
	self windowExtent: aNewExtent
]

{ #category : #'private - change' }
OBlSpace >> extractAttachedElements: aSetOfElements [
	^ aSetOfElements select: [ :eachElement |
		eachElement isAttachedToSceneGraph
			and: [ eachElement space == self ] ]
]

{ #category : #'private - change' }
OBlSpace >> extractParents: aSetOfElements suchThat: aConditionBlock [
	| theElementToProcess |

	theElementToProcess := Set new.

	aSetOfElements do: [ :eachElement |
		eachElement
			topMostParentSuchThat: aConditionBlock
			ifFound: [ :aNotYetResolvedParent | theElementToProcess add: aNotYetResolvedParent ]
			ifNone: [ theElementToProcess add: eachElement ] ].

	^ theElementToProcess
]

{ #category : #'private - change' }
OBlSpace >> extractRoots: aSetOfElements [
	^ self class extractRoots: aSetOfElements
]

{ #category : #'change - properties' }
OBlSpace >> extractUnresolvedToComputeProperties: aSetOfElements [
	^ self
		extractParents: aSetOfElements
		suchThat: [ :eachParent | eachParent needsPropertiesComputation ]
]

{ #category : #'change - style' }
OBlSpace >> extractUnstyled: aSetOfElements [
	^ self
		extractParents: aSetOfElements
		suchThat: [ :eachParent | eachParent needsStyle ]
]

{ #category : #'event handling' }
OBlSpace >> findMouseDownEventTarget: anEvent [

	"Return the deepest child element among all my children or myself that may be a target for mouse event at provided location.
	The coordinate point is given in space coordinates.
	I may return nil if no such child is found and if I can not be event target either"

	<return: #BlElement or: nil>
	self children sortedByElevation reversed do: [ :eachChild | 
		| found |
		found := eachChild findMouseEventTargetAt: anEvent position.
		(found notNil and: [ found ~~ eachChild ]) ifTrue: [
			self processMouseDown: anEvent inside: found on: self popupLayer.
			^ found ] ].
	self processMouseDown: anEvent inside: nil on: self popupLayer.
	^ nil
]

{ #category : #'event handling' }
OBlSpace >> findMouseEventTargetAt: aPoint [

	"Return the deepest child element among all my children or myself that may be a target for mouse event at provided location.
	The coordinate point is given in space coordinates.
	I may return nil if no such child is found and if I can not be event target either"

	<return: #BlElement or: nil>
	self children sortedByElevation reversed do: [ :eachChild | 
		| found |
		found := eachChild findMouseEventTargetAt: aPoint.
		(found notNil and: [ found ~~ eachChild ]) ifTrue: [
			^ found ] ].
	^ nil
]

{ #category : #'focus managing' }
OBlSpace >> focusOwner [
	<return: #BlElement>

	^ focusChain ifNotNil: [ :aFocusChain | aFocusChain last ]
]

{ #category : #'focus managing' }
OBlSpace >> focusOwner: anElement [
	focusChain := anElement ifNotNil: [ BlFocusChain of: anElement ]
]

{ #category : #'accessing - processors' }
OBlSpace >> focusProcessor [
	<return: #BlFocusProcessor>

	^ focusProcessor
]

{ #category : #'accessing - processors' }
OBlSpace >> focusProcessor: aFocusProcessor [
	focusProcessor := aFocusProcessor
]

{ #category : #'window - properties' }
OBlSpace >> focused [
	<return: #Boolean>

	^ focused
]

{ #category : #'window - properties' }
OBlSpace >> focused: aBoolean [
	focused := aBoolean
]

{ #category : #accessing }
OBlSpace >> frame [
	<return: #BlSpaceFrame>

	^ frame
]

{ #category : #drawing }
OBlSpace >> fullDrawOn: anCanvas [

	anCanvas fullDraw: self layerHolder
]

{ #category : #'-- extensions-bloc-dev-tool --' }
OBlSpace >> fullPaintWithTransformOn: aCompositorPainter offset: anOffset [

	self layerHolder fullPaintWithTransformOn: aCompositorPainter offset: anOffset
]

{ #category : #'window - properties' }
OBlSpace >> fullscreen [
	"Return true if an underlying window is in fullscreen mode,
	false otherwise"
	<return: #Boolean>

	^ self 
		hostSpaceDo: [ :aHostSpace | aHostSpace fullscreen ]
		ifAbsent: [ fullscreen ]
]

{ #category : #'window - properties' }
OBlSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"

	fullscreen := aBoolean.
	 self hostSpaceDo: [ :aHostSpace | aHostSpace fullscreen: aBoolean ]
]

{ #category : #'window - properties' }
OBlSpace >> fullsize [
	"Return true if an underlying window is in fullsize mode,
	false otherwise.
	Fullsize means that the content of a window is rendered underneath the title bar, which is transparent
	and has no window title"
	<return: #Boolean>

	^ self 
		hostSpaceDo: [ :aHostSpace | aHostSpace fullsize ]
		ifAbsent: [ fullsize ]
]

{ #category : #'window - properties' }
OBlSpace >> fullsize: aBoolean [
	"Switch underlying window to fullsize if true is given
	and exit fullsize mode if false is given.
	See ${method:TBlSpaceProperties>>#fullsize}"

	fullsize := aBoolean.
	 self hostSpaceDo: [ :aHostSpace | aHostSpace fullsize: aBoolean ]
]

{ #category : #'focus managing' }
OBlSpace >> grabFocus [
	self focused: true
]

{ #category : #'-- extensions-bloc-dev-tool --' }
OBlSpace >> hasCompositionLayer [

	^ self layerHolder hasCompositionLayer
]

{ #category : #testing }
OBlSpace >> hasDirtyAreas [
	"Return true if space has dirty areas and therefore needs to be rendered,
	false otherwise"
	<return: #Boolean>
	
	^ self dirtyAreas isNotEmpty
]

{ #category : #'focus managing' }
OBlSpace >> hasFocus: anElement [
	"Return true if a given element is within the focus chain"
	
	self focusOwner
		ifNil: [ ^ false ].
		
	self focusOwner == anElement
		ifTrue: [ ^ true ].
		
	^ self focusOwner hasParent: anElement
]

{ #category : #'host space - accessing' }
OBlSpace >> hasHostSpace [
	"Return true if I have a host space, false otherwise"
	<return: #Boolean>

	^ self hostSpace isNotNil
]

{ #category : #testing }
OBlSpace >> hasLayoutError [
	"Return true if there was a layout error, false otherwise"
	<return: #Boolean>

	^ layoutError isNotNil
]

{ #category : #testing }
OBlSpace >> hasOwner [
	"To be polymorphic with BlElement's traversal API.
	Space does not have an owner"
	<return: #Boolean>
	
	^ false
]

{ #category : #'window - properties' }
OBlSpace >> height [
	<return: #Number>

	^ self extent y
]

{ #category : #'api - displaying' }
OBlSpace >> hide [
	self hostSpace ifNotNil: [ :hw | hw hide ]
]

{ #category : #'host space - accessing' }
OBlSpace >> host [
	^ host
]

{ #category : #'host space - accessing' }
OBlSpace >> host: aHost [
	"Change the host of this space. Asynchronous. If the space is opened, first destroy the host window and then open the space with a new host"
	| aDetachedEventHandler |

	aDetachedEventHandler := nil.

	aDetachedEventHandler := BlEventHandler
		on: BlSpaceDetachedEvent
		do: [ :anEvent |
			self removeEventHandler: aDetachedEventHandler.
			host := aHost.
			self universe attachSpace: self ].

	self isOpened
		ifTrue: [ self universe detachSpace: self ]
		ifFalse: [ host := aHost ]
]

{ #category : #'host space - accessing' }
OBlSpace >> hostSpace [
	^ hostSpace
]

{ #category : #'host space - accessing' }
OBlSpace >> hostSpace: aHostSpace [
	"Assign a host space window that will be a source of UI events
	and will provide a rendering surface on which I will be rendered.
	aHostSpace must not be nil"

	self
		assert: [ aHostSpace isNotNil ]
		description: [ 'Host space must not be nil!' ].

	hostSpace := aHostSpace.
	self hostSpaceChanged.
]

{ #category : #'host space - accessing' }
OBlSpace >> hostSpaceChanged [
	"When host space changed we might want to adapt sizes"
	self windowExtent: self windowExtent.
	"host space changed => renderer changed, we want to redraw the whole space"
	self beDirtyArea
]

{ #category : #'host space - accessing' }
OBlSpace >> hostSpaceDo: aBlock [
	^ self hostSpaceDo: aBlock ifAbsent: [ self ]
]

{ #category : #'host space - accessing' }
OBlSpace >> hostSpaceDo: aBlock ifAbsent: anAbsentBlock [
	self hasHostSpace
		ifFalse: [ ^ anAbsentBlock value ].

	self hostSpace needsRebuild
		ifTrue: [ ^ anAbsentBlock value ].
		
	^ aBlock cull: self hostSpace
]

{ #category : #'window - properties' }
OBlSpace >> icon [
	"Return an object that understands #asElement, or nil"
	^ iconStencil
]

{ #category : #'window - properties' }
OBlSpace >> icon: aStencil [
	"aStencil is an object that undestands #asElement and returns ${class:BlElement}$"
	
	iconStencil = aStencil ifTrue: [ ^ self ].
	
	iconStencil := aStencil.
	
	self fireEvent: (BlSpaceIconChangedEvent new iconStencil: aStencil)
]

{ #category : #accessing }
OBlSpace >> id [
	<return: #Number>
	
	^ id
]

{ #category : #initialization }
OBlSpace >> initDispatcher [
	self eventDispatcher addEventFilter: self eventListener
]

{ #category : #initialization }
OBlSpace >> initialize [
	super initialize.
	
	id := UniqueIdGenerator generateUniqueId.
	
	host := BlHost pickHost.
	nextPulseRequested := true.
	session := Smalltalk session.
	dirtyAreas := OrderedCollection new.
	elementsNeedingPaint := Set new.
	elementsNeedingLayout := Set new.
	elementsNeedingStyle := Set new.
	elementsNeedingPropertiesComputation := Set new.
	
	eventDispatcher := self defaultEventDispatcher.
	eventListener := self defaultEventListener.
	eventRecorder := self defaultEventRecorder.
	self initDispatcher.
	
	mouseProcessor := OBlMouseProcessor space: self.
	focusProcessor := BlFocusProcessor space: self.
	keyboardProcessor := BlKeyboardProcessor space: self.

	tasks := BlSpaceTaskQueue space: self.
	time := BlTime real.
	frame := BlSpaceFrame new.
	telemetry := BlNullTelemetry uniqueInstance.

	layerHolder := self defaultLayerHolder.
	overlayLayer := self defaultOverlayLayer.
	popupLayer := self defaultPopupLayer.
	contextMenuLayer := self defaultContextMenuLayer.
	rootLayer := self defaultRoot.

	self extent: self defaultExtent.

	self resizable: true.
	self borderless: false.
	self fullscreen: false.
	self fullsize: false.
	self title: self defaultTitle.
	self focused: false.

	self updateCursor: BlCursor default.

	self layerHolder space: self.
	self layerHolder addChild: self root.
	self layerHolder addChild: self overlayLayer.
	self layerHolder addChild: self contextMenuLayer.
	self layerHolder addChild: self popupLayer


]

{ #category : #'focus managing' }
OBlSpace >> initializeFocus [
	self root isFocusable
		ifTrue: [ self root requestFocus ]
]

{ #category : #'-- extensions-spec2 --' }
OBlSpace >> inspectionPreview: aBuilder [
	"<inspectorPresentationOrder: 1 title: 'Preview'>"

	^ self layerHolder inspectionPreview: aBuilder
]

{ #category : #'-- extensions-spec2 --' }
OBlSpace >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Tree'>

	^ self layerHolder inspectionTree: aBuilder
]

{ #category : #'change - rendering' }
OBlSpace >> invalidRect: aBlBounds from: anElement [

	self makeDirty: aBlBounds.
	self requestNextPulse.

	self hostSpaceDo: [ :aHostSpace | aHostSpace requestRedraw ]
]

{ #category : #'change reporting' }
OBlSpace >> invalidationBounds [
	<return: #Rectangle>

	^ self layerHolder invalidationBounds
]

{ #category : #testing }
OBlSpace >> isFocused [
	^ self focused
]

{ #category : #'change - layout' }
OBlSpace >> isLayoutRequested [
	"Indicates whether or not root element's layout needs to be updated next frame"
	<return: #Boolean>
	
	^ self layerHolder isLayoutRequested or: [ self elementsNeedingLayout isNotEmpty ]
]

{ #category : #testing }
OBlSpace >> isOpened [
	"Return true if the space was shown (by sending #show message), false otherwise.
	Please note, that an opened space can be hidden which does not influence the result of #isOpened"
	<return: #Boolean>

	^ (BlParallelUniverse existsForHost: self host class)
		and: [ (BlParallelUniverse forHost: self host class) hasSpace: self ]
]

{ #category : #'host space - text input' }
OBlSpace >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"

	^ self hostSpaceDo: [:hs | hs isTextInputActive] ifAbsent: [ false ]
]

{ #category : #testing }
OBlSpace >> isVisible [
	^ self hasHostSpace
		ifTrue: [ self hostSpace isVisible ]
		ifFalse: [ false ]
]

{ #category : #'accessing - processors' }
OBlSpace >> keyboardProcessor [
	<return: #BlKeyboardProcessor>

	^ keyboardProcessor
]

{ #category : #'accessing - processors' }
OBlSpace >> keyboardProcessor: aKeyboardProcessor [
	keyboardProcessor := aKeyboardProcessor
]

{ #category : #'window - properties' }
OBlSpace >> knowsPosition [
	"Return true if this space knows its position.
	By default, spaces don't know their position and allow the window manager to choose one.
	Setting an explicit position during space creation will result in a window created at a specified position"
	<return: #Boolean>

	^ position notNil
]

{ #category : #accessing }
OBlSpace >> layerHolder [
	"Return my current root element.
	root can not be nil"
	
	^ layerHolder
]

{ #category : #'focus managing' }
OBlSpace >> loseFocusFor: anElement [
	self focusProcessor loseFor: anElement
]

{ #category : #'change - rendering' }
OBlSpace >> makeDirty: aBlBounds [

	self
		assert: [ aBlBounds isKindOf: BlBounds ]
		description: [ 'Only BlBounds can be used as dirty area' ].

	aBlBounds expanded.
	self dirtyAreas
		ifEmpty: [ self dirtyAreas add: aBlBounds copy ]
		ifNotEmpty: [ :aCollection | aCollection first merge: aBlBounds ].
]

{ #category : #'change - rendering' }
OBlSpace >> markNeedsCompositionPaint: anElement from: aSourceElement [

	self beDirtyArea.
	self hostSpaceDo: [ :aHostSpace | aHostSpace requestRedraw ].
	self requestNextPulse
]

{ #category : #'change - rendering' }
OBlSpace >> markNeedsPaint: anElement from: aSourceElement [

	self beDirtyArea.
	self elementsNeedingPaint add: anElement.
	self hostSpaceDo: [ :aHostSpace | aHostSpace requestRedraw ].
	self requestNextPulse
]

{ #category : #'api - displaying' }
OBlSpace >> maximize [
	self hostSpace ifNotNil: [ :hw | hw maximize ]
]

{ #category : #'api - displaying' }
OBlSpace >> maximized [
	self hostSpace ifNotNil: [ :hw | ^ hw maximized ].
	^ false
]

{ #category : #dispatch }
OBlSpace >> measureTextParagraph: aBlTextParagraph [

	self
		hostSpaceDo: [ :aHostSpace | 
			aHostSpace renderer isValid ifTrue: [
				^ aHostSpace renderer measureTextParagraph: aBlTextParagraph ] ]
		ifAbsent: [ ].

	"TODO"
	host offscreenMeasureTextParagraph: aBlTextParagraph
]

{ #category : #pulse }
OBlSpace >> measureTextParagraph: aBlTextParagraph ifNotAvailable: aBlock [
	self
		hostSpaceDo: [ :aHostSpace | aHostSpace measureTextParagraph: aBlTextParagraph ]
		ifAbsent: aBlock
]

{ #category : #'api - displaying' }
OBlSpace >> minimize [
	self hostSpace ifNotNil: [ :hw | hw minimize ]
]

{ #category : #'api - displaying' }
OBlSpace >> minimized [
	self hostSpace ifNotNil: [ :hw | ^ hw minimized ].
	^ false
]

{ #category : #'accessing - processors' }
OBlSpace >> mouseProcessor [
	<return: #BlMouseProcessor>

	^ mouseProcessor
]

{ #category : #'accessing - processors' }
OBlSpace >> mouseProcessor: aMouseProcessor [
	mouseProcessor := aMouseProcessor
]

{ #category : #'change - properties' }
OBlSpace >> needsPropertiesComputation [
	<return: #Boolean>
	
	^ self elementsNeedingPropertiesComputation isNotEmpty
		or: [ self layerHolder needsPropertiesComputation ]
]

{ #category : #'change - properties' }
OBlSpace >> needsPropertiesComputation: anElement [
	"Return true if a given element or any of its children wants properties computation"
	<return: #Boolean>

	^ self elementsNeedingPropertiesComputation
		anySatisfy: [ :eachElement | 
			(eachElement = anElement
				or: [ eachElement hasParent: anElement ])
					and: [ anElement hasParent
						and: [ anElement parent needsPropertiesComputation not ] ] ]
]

{ #category : #'change - style' }
OBlSpace >> needsStyleComputation [
	<return: #Boolean>
	
	^ self elementsNeedingStyle isNotEmpty
]

{ #category : #'change - style' }
OBlSpace >> needsStyleComputation: anElement [
	"Return true if a given element or any of its children wants style computation"
	<return: #Boolean>
	
	^ self elementsNeedingStyle
		anySatisfy: [ :eachElement | eachElement = anElement or: [ eachElement hasParent: anElement ] ]
]

{ #category : #pulse }
OBlSpace >> onSessionChanged: aNewSession [
	session := aNewSession.
	self beDirtyArea.
	self requestNextPulse.
	
	self layerHolder onSessionChanged: aNewSession
]

{ #category : #accessing }
OBlSpace >> overlayLayer [
	"Return my current root element.
	root can not be nil"
	
	^ overlayLayer
]

{ #category : #accessing }
OBlSpace >> popupLayer [
	"Return my current root element.
	root can not be nil"
	
	^ popupLayer
]

{ #category : #'window - properties' }
OBlSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace position ]
		ifAbsent: [ position ifNil: [ 0@0 ] ]
]

{ #category : #'window - properties' }
OBlSpace >> position: aPoint [
	"Request to change window's position to a given point in screen coordinates"

	self setPosition: aPoint.
	self hostSpaceDo: [ :aHostSpace | aHostSpace position: aPoint ]
]

{ #category : #printing }
OBlSpace >> printOn: aStream [

	super printOn: aStream.
	aStream
		<< '(';
		print: title;
		<< ')'
]

{ #category : #'event handling' }
OBlSpace >> processMouseDown: anEvent inside: anElement on: aLayer [

	| evt |
	evt := anEvent clone.
	evt currentTarget: anElement.
	aLayer childrenDo: [ :child | 
		(anElement isNil or: [ (child == anElement or: [ anElement hasParent: child ]) not ]) 
			ifTrue: [ 
				child dispatchEvent: (BlSpaceMouseDownOutsideEvent new
						 event: evt;
						 yourself) ] ]
]

{ #category : #pulse }
OBlSpace >> processPulse [
	self ensureSession.
	
	self pulseRequested
		ifFalse: [ ^ self ].
	
	"flip to false beforehand to be able to know if the next pulse was needed during the frame"
	nextPulseRequested := false.

	self telemetry
		reset;
		timeSync: 'Frame'
			during: [ self frame runOn: self ];
		emit.
]

{ #category : #pulse }
OBlSpace >> pulse [
	self processPulse
]

{ #category : #'change - rendering' }
OBlSpace >> pulseRequested [

	"Return true if space pulse was requested, false otherwise"

	<return: #Boolean>
	^ nextPulseRequested
]

{ #category : #'api - adding children' }
OBlSpace >> removeChild: anElement [
	"Remove a given element from the space root"
	
	self root removeChild: anElement
]

{ #category : #pulse }
OBlSpace >> render [
	"Render this space in my host window if it is assigned, otherwise do nothing"

	self
		hostSpaceDo: [ :aHostSpace | aHostSpace render: self ]
		"if there is no host we should clear dirty areas, otherwise
		it may lead to memory leaks"
		ifAbsent: [ self clearDirtyAreas ]
]

{ #category : #'focus managing' }
OBlSpace >> requestFocusFor: anElement dueTo: aFocusReason [
	self
		assert: [ anElement space = self ]
		description: [ 'anElement must be attached to the scenegraph owned by this space' ].
		
	self focusProcessor requestFor: anElement dueTo: aFocusReason
]

{ #category : #'change - layout' }
OBlSpace >> requestLayout: anElement [
	elementsNeedingLayout add: anElement.
	self requestNextPulse
]

{ #category : #'change - rendering' }
OBlSpace >> requestNextPulse [

	nextPulseRequested := true
]

{ #category : #'change - properties' }
OBlSpace >> requestPropertiesComputation: anElement [
	self elementsNeedingPropertiesComputation add: anElement.
	self requestNextPulse
]

{ #category : #'change - style' }
OBlSpace >> requestStyle: anElement [		
	self elementsNeedingStyle add: anElement.
	self requestNextPulse
]

{ #category : #'window - properties' }
OBlSpace >> resizable [
	"Return true if underlying window is resizable, false otherwise"
	<return: #Boolean>

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace resizable ]
		ifAbsent: [ resizable ]
]

{ #category : #'window - properties' }
OBlSpace >> resizable: aBoolean [
	"Make underlying window resizable if true is given"
	
	resizable := aBoolean.
	self hostSpaceDo: [ :aHostSpace | aHostSpace resizable: aBoolean ]
]

{ #category : #accessing }
OBlSpace >> root [
	"Return my current root element.
	root can not be nil"
	
	^ rootLayer
]

{ #category : #accessing }
OBlSpace >> root: anElement [
	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"
	
	self
		assert: [ anElement isNotNil ]
		description: [ 'anElement must not be nil' ].

	self
		assert: [ anElement space isNil ]
		description: [ 'New root must not be already have a space assigned!' ].

	anElement
		space: self;
		size: self extent.

	rootLayer := anElement
]

{ #category : #accessing }
OBlSpace >> rootDo: aBlock [
	"A helper method to evaluate a given block with the root element as its argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : #pulse }
OBlSpace >> runTasks [
	"Run animations and other runnable tasks"

	self taskQueue runOn: self
]

{ #category : #accessing }
OBlSpace >> session [
	^ session
]

{ #category : #'private - accessing' }
OBlSpace >> setExtent: anExtent [
	"Actually change space and root extent to a given one"

	extent := anExtent.
	self layerHolder requestLayout
]

{ #category : #'private - accessing' }
OBlSpace >> setPosition: aPoint [
	"Actually change space, root and glass extent to a given one"

	position := aPoint
]

{ #category : #'api - displaying' }
OBlSpace >> show [
	"Open me in a window and show it to the user"

	"delegate showing work to the Universe"	
	(BlParallelUniverse forHost: self host class) openSpace: self
]

{ #category : #'api - displaying' }
OBlSpace >> showSpace: aSpace [
	"I show a given space either inside of me or let it open by default"
	aSpace show
]

{ #category : #accessing }
OBlSpace >> space [

	^ self
]

{ #category : #'host space - text input' }
OBlSpace >> startTextInput [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	self hostSpaceDo: [:hs | hs startTextInput]
]

{ #category : #'host space - text input' }
OBlSpace >> startTextInputAtRectangle: aRectangle [

	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	self hostSpaceDo: [:hs | hs startTextInputAtRectangle: aRectangle]
]

{ #category : #'host space - text input' }
OBlSpace >> stopTextInput [
	"Stop receiving any text input events"

	self hostSpaceDo: [:hs | hs stopTextInput]
]

{ #category : #'api - tasks' }
OBlSpace >> taskQueue [
	<return: #BlSpaceTaskQueue>
	
	^ tasks
]

{ #category : #accessing }
OBlSpace >> telemetry [
	<return: #BlTelemetry>
	
	^ telemetry
]

{ #category : #accessing }
OBlSpace >> telemetry: aBlTelemetry [
	telemetry := aBlTelemetry
]

{ #category : #accessing }
OBlSpace >> time [
	<return: #BlTime>
	
	^ time
]

{ #category : #accessing }
OBlSpace >> time: aBlTime [
	time := aBlTime
]

{ #category : #'window - properties' }
OBlSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace title ]
		ifAbsent: [ title ]
]

{ #category : #'window - properties' }
OBlSpace >> title: aString [
	"Change window's title"

	title := aString.
	self hostSpaceDo: [ :aHostSpace | aHostSpace title: aString ]
]

{ #category : #'api - displaying' }
OBlSpace >> toBack [
	self hostSpace ifNotNil: [ :hw | hw toBack ]
]

{ #category : #'api - displaying' }
OBlSpace >> toFront [
	self hostSpace ifNotNil: [ :hw | hw toFront ]
]

{ #category : #accessing }
OBlSpace >> topMostParent [
	^ self root
]

{ #category : #'focus managing' }
OBlSpace >> ungrabFocus [
	self focused: false
]

{ #category : #accessing }
OBlSpace >> universe [
	<return: #BlParallelUniverse>

	^ BlParallelUniverse forHost: self host class
]

{ #category : #'cursor managing' }
OBlSpace >> updateCursor: aBlCursor [

	self hostSpaceDo: [ :aHostSpace | aHostSpace cursor: aBlCursor ]
]

{ #category : #'host dependent - ToDo' }
OBlSpace >> visualBoundsOf: aBlElement [

	^ host visualBoundsOf: aBlElement
]

{ #category : #'-- extensions-bloc-dev-tool --' }
OBlSpace >> wantsSeparateCompositingLayer [

	^ self layerHolder wantsSeparateCompositingLayer
]

{ #category : #'window - properties' }
OBlSpace >> width [
	<return: #Number>

	^ self extent x
]

{ #category : #'window - properties' }
OBlSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels on high dpi (retina) screens.
	Use #extent to get actual pixel size"

	<return: #Point>
	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace logicalSize width @ aHostSpace logicalSize height ]
		ifAbsent: [ extent ]
]

{ #category : #'window - properties' }
OBlSpace >> windowExtent: anExtent [
	"Request to change a window size to aNewExtent.
	Note, that window size may be different from renderer size on high dpi (retina) displays"

	self setExtent: anExtent.
	self hostSpaceDo: [ :aHostSpace | aHostSpace windowExtent: anExtent ]
]

{ #category : #'window - properties' }
OBlSpace >> windowScale [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace scaleFactor ]
		ifAbsent: [ 1.0 asPoint ]
]

{ #category : #'api - children enumeration' }
OBlSpace >> withAllChildrenBreadthFirst [
	<return: #Collection of: #BlElement>
	
	^ self layerHolder withAllChildrenBreadthFirst
]

{ #category : #'api - children enumeration' }
OBlSpace >> withAllChildrenBreadthFirstDo: aBlock [ 
	
	^ self layerHolder withAllChildrenBreadthFirstDo: aBlock 
]

{ #category : #'-- extensions-bloc-dev-tool --' }
OBlSpace >> withHalos [
	"self root addEventFilter: BlDevHalosEventListener new"
]
