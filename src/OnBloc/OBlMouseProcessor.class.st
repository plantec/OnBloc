Class {
	#name : #OBlMouseProcessor,
	#superclass : #BlBaseEventProcessor,
	#instVars : [
		'lastEnteredTargets',
		'lastOverTarget',
		'lastClickEvent',
		'currentDragTarget',
		'lastMouseTarget',
		'dndInProgress',
		'dragStartMask',
		'pressedButtons',
		'dragState',
		'previousMouseDownEvent',
		'lastMouseMoveEvent'
	],
	#category : #'OnBloc-Space - Events'
}

{ #category : #accessing }
OBlMouseProcessor class >> dblClickDelay [
	<return: #Duration>
	^ 400 milliSeconds
]

{ #category : #'event testing' }
OBlMouseProcessor >> canBeClickEvent: aMouseUpEvent [

	^ dndInProgress not
		and: [ (previousMouseDownEvent isNotNil and: [ previousMouseDownEvent primaryButtonPressed ])
				and: [ aMouseUpEvent target = previousMouseDownEvent target  ] ]
]

{ #category : #'event testing' }
OBlMouseProcessor >> canBeDblClickEvent: aMouseUpEvent [

	self flag: 'testing aMouseUpEvent target = lastClickEvent target is in fact needed, however, it breaks the Phlow list'.
	self flag: 'https://github.com/feenkcom/gtoolkit/issues/708'.

	^ lastClickEvent isNotNil and: [  aMouseUpEvent target = lastClickEvent target
				and: [ aMouseUpEvent timestamp - lastClickEvent timestamp < self dblClickDelay ] ]
]

{ #category : #'event testing' }
OBlMouseProcessor >> canStartDrag: aMouseMoveEvent [
	<return: #Boolean>

	^ (pressedButtons includes: BlMouseButton primary)
		and: [ previousMouseDownEvent isNotNil
			and: [ previousMouseDownEvent primaryButtonPressed
				and: [ (aMouseMoveEvent position - previousMouseDownEvent position) r > self startDragThreshold ] ] ]
]

{ #category : #'event processing' }
OBlMouseProcessor >> checkLastOverTarget [

	(lastOverTarget isNotNil and: [lastOverTarget isAttachedToSceneGraph not]) ifFalse: [ ^ self ].
	lastOverTarget := nil
]

{ #category : #accessing }
OBlMouseProcessor >> dblClickDelay [
	^ self class dblClickDelay
]

{ #category : #'event firing' }
OBlMouseProcessor >> dispatchEvent: anEvent target: aTarget [

	" enter/leave events are dispatched to a known target "
	super dispatchEvent: anEvent target: aTarget
]

{ #category : #accessing }
OBlMouseProcessor >> enteredTargets [
	<return: #Collection of: #BlElement>

	^ lastEnteredTargets
]

{ #category : #'event processing' }
OBlMouseProcessor >> fillTargetHierarchy: aTarget [
	^ Array streamContents: [ :aStream |
		aStream nextPut: aTarget.
		aTarget allParentsDo: [ :aParentElement | aStream nextPut: aParentElement  ] ]
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsDragEndEvent: anEvent [

	self fireEvent:
			(anEvent asDragEndEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself)
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsDragEnterEvent: anEvent targets: aCollection [
	aCollection
		do: [ :t | 
			self dispatchEvent:
					(anEvent asDragEnterEvent
						startButtons: dragStartMask;
						target: t;
						gestureSource: currentDragTarget;
						canBePropagated: false;
						yourself)
				target: t ]
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsDragEvent: anEvent [
	self	fireEvent:
			(anEvent asDragEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself)
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsDragLeaveEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asDragLeaveEvent
						startButtons: dragStartMask;
						target: t;
						gestureSource: currentDragTarget;
						canBePropagated: false;
						yourself)
					target: t ]
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsDragStartEvent: anEvent [
	^ self fireEvent:
			(anEvent asDragStartEvent
				startButtons: dragStartMask;
				target: anEvent target;
				gestureSource: anEvent target;
				yourself)
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsDropEvent: anEvent [
	
	self	fireEvent:
			(anEvent asDropEvent
				gestureSource: currentDragTarget;
				gestureTarget: anEvent target;
				startButtons: dragStartMask;
				dragboard: self space dragboard;
				yourself)
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsEnterEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asMouseEnterEvent
						target: t;
						canBePropagated: false;
						yourself)
					target: t ]
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsMouseLeaveEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asMouseLeaveEvent
						target: t;
						canBePropagated: false;
						yourself)
					target:t ]
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsMouseOutEvent: aMouseEvent [
	self fireEvent: (aMouseEvent asMouseOutEvent target: lastOverTarget)
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsMouseOutEvent: aMouseEvent targets: aCollection [
	aCollection do: [ :eachElement |
		self fireEvent: (aMouseEvent asMouseOutEvent target: eachElement) ]
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireAsMouseOverEvent: aMouseEvent [
	self fireEvent: aMouseEvent asMouseOverEvent 
]

{ #category : #'event firing' }
OBlMouseProcessor >> fireEvent: anEvent [

	" for events other than entre/leave "
	^ super fireEvent: anEvent
]

{ #category : #'event processing' }
OBlMouseProcessor >> generateEvents [
	((lastEnteredTargets, { lastOverTarget }) reject: [ :eachElement | eachElement isNil or: [ eachElement space == self space ] ]) asSet
		ifNotEmpty: [ :removedEnteredTargets |
			| aMouseEvent |
			
			aMouseEvent := BlMouseEvent new
				button: (pressedButtons ifEmpty: [ nil ] ifNotEmpty: [ pressedButtons anyOne ]);
				position: 0@0;
				screenPosition: 0@0.
			
			self fireAsMouseLeaveEvent: aMouseEvent targets: removedEnteredTargets.
			self fireAsMouseOutEvent: aMouseEvent targets: removedEnteredTargets ].
	
	lastEnteredTargets := lastEnteredTargets select: [ :eachElement | eachElement isAttachedToSceneGraph ].
	(lastOverTarget notNil and: [ lastOverTarget space ~~ self space ])
		ifTrue: [ lastOverTarget := nil ].
	
	(self isMouseEventValid: previousMouseDownEvent)
		ifFalse: [ previousMouseDownEvent := nil ].

	(self isMouseEventValid: lastClickEvent)
		ifFalse: [ lastClickEvent := nil ]
]

{ #category : #'mouse move' }
OBlMouseProcessor >> handleLastMouseMove [

	| target |
	lastMouseMoveEvent ifNil: [ ^ self ].
	target := self processPicking: lastMouseMoveEvent.	
	lastMouseMoveEvent target: target.
	lastMouseMoveEvent button: (pressedButtons ifEmpty: [ nil ] ifNotEmpty: [ pressedButtons anyOne ]).
	self processMouseMove: lastMouseMoveEvent.
]

{ #category : #'mouse down' }
OBlMouseProcessor >> handleMouseDown: aMouseDownEvent [
	| aTargetElement |

	"First we need to register a pressed button"
	self pressedButtons add: aMouseDownEvent button.

	aTargetElement := self processMouseDownPicking: aMouseDownEvent.
	aMouseDownEvent target: aTargetElement.

	self fireEvent: aMouseDownEvent.

	"now we can update the cursor from the target"
	self updateCursorFrom: aTargetElement.

	"store last mouse down event"
	previousMouseDownEvent := aMouseDownEvent
]

{ #category : #'mouse entered / left' }
OBlMouseProcessor >> handleMouseEntered: aSpaceMouseEnterEvent [
]

{ #category : #'mouse entered / left' }
OBlMouseProcessor >> handleMouseLeft: aSpaceMouseLeaveEvent [
	lastEnteredTargets do: [ :eachEnteredTarget |
		| anEvent |
		
		anEvent := self isDragging
			ifTrue: [ BlDragLeaveEvent new
				startButtons: dragStartMask;
				gestureSource: currentDragTarget ]
			ifFalse: [ BlMouseLeaveEvent new ].

		anEvent
			position: 0@0;
			target: eachEnteredTarget;
			canBePropagated: false;
			timestamp: self space time now.
		
		self dispatchEvent: anEvent target: eachEnteredTarget ].
	
	lastEnteredTargets := #().
	lastOverTarget := nil
]

{ #category : #'mouse move' }
OBlMouseProcessor >> handleMouseMove: aMouseMoveEvent [
	| aTargetElement shouldTryDragStart |
	"picking and mouse move"
	
	aTargetElement := self processPicking: aMouseMoveEvent.
	self
		assert: [ aTargetElement isAttachedToSceneGraph ]
		description: [ 'Target element must be attached to the scene graph' ].
	
	aMouseMoveEvent target: aTargetElement.
	aMouseMoveEvent button: (pressedButtons ifEmpty: [ nil ] ifNotEmpty: [ pressedButtons anyOne ]).

	shouldTryDragStart := self isDragging
		ifFalse: [ (self canStartDrag: aMouseMoveEvent) ]
		ifTrue: [ false ].

	self isDragging
		"we are dragging, handle it as drag move"
		ifTrue: [ self processDragMove: aMouseMoveEvent ]
		ifFalse: [ shouldTryDragStart
			ifTrue: [ (self tryDragStart: previousMouseDownEvent)
				"we sent drag start, have to send first drag move"
				ifTrue: [ self processDragMove: aMouseMoveEvent ]
				"drag start was not handled, process as basic mouse move"
				ifFalse: [ self processMouseMove: aMouseMoveEvent ] ]
			"no need to even try to start a drag"
			ifFalse: [ self processMouseMove: aMouseMoveEvent ] ]
]

{ #category : #'mouse up' }
OBlMouseProcessor >> handleMouseUp: aMouseUpEvent [
	"DragEnd, Simple click and Dbl click"
	| aTargetElement |
	
	"if mouse button was not registered as pressed we can ignore this particular event"
	(self pressedButtons includes: aMouseUpEvent button)
		ifFalse: [ ^ self ].

	"we need to unregister a button"
	self pressedButtons remove: aMouseUpEvent button.

	
	(aMouseUpEvent secondaryButtonPressed and: [previousMouseDownEvent notNil]) 
		ifTrue: [ aTargetElement := previousMouseDownEvent target].
	aTargetElement ifNil: [aTargetElement := self processPicking: aMouseUpEvent].
	aMouseUpEvent target: aTargetElement.

	"depending on whether drag and drop is in process handle mouse up either
	as mouse up itself or as drag end event"
	self isDragging
		ifTrue: [ self processDragEnd: aMouseUpEvent ]
		ifFalse: [ self processMouseUp: aMouseUpEvent ]
]

{ #category : #'initialize-release' }
OBlMouseProcessor >> initialize [
	super initialize.
	lastEnteredTargets := #().
	dragStartMask := 0.
	dndInProgress := false.

	"a set of currently pressed mouse buttons button"
	pressedButtons := Set new.
	dragState := BlMouseDragState new
]

{ #category : #testing }
OBlMouseProcessor >> isDragging [
	"Return true if drag and drop is in process, false otherwise"
	<return: #Boolean>
	
	^ dndInProgress
]

{ #category : #private }
OBlMouseProcessor >> isMouseEventValid: anEvent [

	anEvent ifNil: [ ^ false ].
	(({ 
		  anEvent target.
		  anEvent currentTarget.
		  anEvent source } reject: [ :eachElement | eachElement isNil ]) 
		 anySatisfy: [ :eachTargetElement | 
		 eachTargetElement space ~~ self space ]) ifTrue: [ ^ false ].

	^ true
]

{ #category : #'event testing' }
OBlMouseProcessor >> isValidDragTarget: aEvent [

	^ (aEvent target = self space root) not
]

{ #category : #accessing }
OBlMouseProcessor >> lastClickEvent [
	<return: #BlClickEvent or: nil>

	^ lastClickEvent
]

{ #category : #accessing }
OBlMouseProcessor >> lastMouseMoveEvent [

	^ lastMouseMoveEvent
]

{ #category : #accessing }
OBlMouseProcessor >> lastOverTarget [
	<return: #BlElement>

	^ lastOverTarget
]

{ #category : #'initialize-release' }
OBlMouseProcessor >> onSpaceClosed [
	lastEnteredTargets := #().
	lastOverTarget := nil.
	lastClickEvent := nil.
	currentDragTarget := nil.
	lastMouseTarget := nil.
	dndInProgress := nil.
	dragStartMask := 0.
	pressedButtons := Set new.
	previousMouseDownEvent := nil
]

{ #category : #'event processing' }
OBlMouseProcessor >> postProcess: aMouseEvent [
	
]

{ #category : #'event processing' }
OBlMouseProcessor >> preProcess: aMouseEvent [
	| aTarget |
	
	aTarget := self processPicking: aMouseEvent.

	aMouseEvent target: aTarget.

	"mouse move is only fired when no dnd is in progress (else it is a drag event)"
	dndInProgress ifFalse: [ self fireEvent: aMouseEvent ].
	"now we can update the cursor from the target"
	self updateCursorFrom: aTarget
]

{ #category : #accessing }
OBlMouseProcessor >> pressedButtons [
	"Return a collection of currently pressed mouse buttons"
	<return: #Collection of: #BlMouseButton>

	^ pressedButtons
]

{ #category : #accessing }
OBlMouseProcessor >> previousMouseDownEvent [
	<return: #BlElement or: nil>

	^ previousMouseDownEvent
]

{ #category : #'mouse drag' }
OBlMouseProcessor >> processDragEnd: aMouseUpEvent [

	self
		assert: [ self isDragging ]
		description: [ 'Can not process mouse up event as drag end if I am not in dragging state' ].
		
	self
		assert: [ currentDragTarget isNotNil ]
		description: [ 'When we drag something it can not be nil' ].

	aMouseUpEvent primaryButtonPressed
		ifTrue: [ 
			self fireAsDragEndEvent: aMouseUpEvent.
			self fireAsDropEvent: aMouseUpEvent.
						
			currentDragTarget := nil.
			dndInProgress := false.
			lastOverTarget := nil.
			dragStartMask := 0 ]
]

{ #category : #'mouse drag' }
OBlMouseProcessor >> processDragMove: aMouseMoveEvent [

	"check drag"
	self fireAsDragEvent: aMouseMoveEvent.

	"dragstart/drag events management"
	currentDragTarget ifNotNil: [ self subprocessDragEnterExitEvent: aMouseMoveEvent ].
	
	"update last overed target"
	lastOverTarget := aMouseMoveEvent target
]

{ #category : #'event processing' }
OBlMouseProcessor >> processMouseDownPicking: aMouseEvent [

	<return: #BlElement>
	| aTargetElement |
	
	self checkLastOverTarget.

	"if the last over target contains the point we can start picking from it"
	aTargetElement := self space findMouseDownEventTarget: aMouseEvent.
	"we have to ensure that aTarget is not nil"
	aTargetElement ifNil: [ aTargetElement := self space root ].
	^ aTargetElement
]

{ #category : #'mouse move' }
OBlMouseProcessor >> processMouseEnterLeaveEvent: aMouseEvent [
	| newLeavedTargets newEnteredTargets currentEnteredTargets |

	"mouse is moved over the same element, no need to process enter/leave events"
	lastOverTarget = aMouseEvent target
		ifTrue: [ ^ self ].

	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	
	"fire mouseout to the previous overed target"
	lastOverTarget isNotNil
		ifTrue: [ self fireAsMouseOutEvent: aMouseEvent ].
	
	"fire mouse leave events"
	newLeavedTargets := lastEnteredTargets reject: [ :anElement | (currentEnteredTargets includes: anElement) ].
	newLeavedTargets := newLeavedTargets select: #isAttachedToSceneGraph.

	self fireAsMouseLeaveEvent: aMouseEvent targets: newLeavedTargets.
	
	"fire mouse event to the current target"
	self fireAsMouseOverEvent: aMouseEvent.
	
	"fire enter events"
	newEnteredTargets := currentEnteredTargets reject: [ :anElement | lastEnteredTargets includes: anElement ].
	self fireAsEnterEvent: aMouseEvent targets: newEnteredTargets.

	lastOverTarget := aMouseEvent target.
	lastEnteredTargets := currentEnteredTargets
]

{ #category : #'mouse move' }
OBlMouseProcessor >> processMouseMove: aMouseMoveEvent [

	lastMouseMoveEvent := aMouseMoveEvent.

	self processMouseEnterLeaveEvent: aMouseMoveEvent.

	self fireEvent: aMouseMoveEvent.

	"now we can update the cursor from the target"
	self updateCursorFrom: aMouseMoveEvent target.
	
]

{ #category : #'event handling entrypoint' }
OBlMouseProcessor >> processMouseScroll: aMouseScrollEvent [
	"picking and mouse move"
	self preProcess: aMouseScrollEvent.
	"does nothing for the moment"
	self postProcess: aMouseScrollEvent
]

{ #category : #'mouse up' }
OBlMouseProcessor >> processMouseUp: aMouseUpEvent [

	self fireEvent: aMouseUpEvent.

	self updateCursorFrom: aMouseUpEvent target.

	(self canBeClickEvent: aMouseUpEvent)
		ifTrue: [  
			(self canBeDblClickEvent: aMouseUpEvent)
				ifTrue: [ 
					self fireEvent: aMouseUpEvent asDoubleClickEvent ]
				ifFalse: [ 
					| aClickEvent | 
					aClickEvent := aMouseUpEvent asClickEvent.
					self fireEvent: aClickEvent.
					lastClickEvent := aClickEvent copy ] ]
		ifFalse: [ 
			(previousMouseDownEvent notNil and: [ previousMouseDownEvent secondaryButtonPressed not]) ifTrue: [ 
				self fireEvent:	(previousMouseDownEvent asClickCandidateEvent mouseUpEvent: aMouseUpEvent) ] ]
]

{ #category : #'event processing' }
OBlMouseProcessor >> processPicking: aMouseEvent [

	<return: #BlElement>
	| aTargetElement |
	self checkLastOverTarget.
	"Start picking from root to ensure checking all space layers"
	aTargetElement := self space findMouseEventTargetAt: aMouseEvent position.
	"we have to ensure that aTarget is not nil"
	^ aTargetElement ifNil: [ aTargetElement := self space root ]
]

{ #category : #accessing }
OBlMouseProcessor >> startDragThreshold [
	^ 4
]

{ #category : #'mouse drag' }
OBlMouseProcessor >> subprocessDragEnterExitEvent: aMouseEvent [
	| newEnteredTargets newExitedTargets currentEnteredTargets |

	self 
		assert: [ currentDragTarget isNotNil ]
		description: [ 'Can not process drag mouse event as enter / exit when there is no dragged element' ].
	
	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	
	lastOverTarget = aMouseEvent target ifFalse:[
		newExitedTargets := lastEnteredTargets reject: [ :anElement | currentEnteredTargets includes: anElement ].
		newEnteredTargets := currentEnteredTargets reject: [ :anElement | lastEnteredTargets includes: anElement ].
		self fireAsDragLeaveEvent: aMouseEvent targets: newExitedTargets.
		self fireAsDragEnterEvent: aMouseEvent targets: newEnteredTargets ].
	
	"store last entered targets"
	lastEnteredTargets := currentEnteredTargets
]

{ #category : #'mouse drag' }
OBlMouseProcessor >> tryDragStart: aMouseEvent [
	"Try to start a drag and return true if drag actually started, otherwise false"
	<return: #Boolean>
	| aDragTarget aDragStartEvent |
	
	aDragTarget := aMouseEvent target.
	
	aDragStartEvent := (aMouseEvent asDragStartEvent
		startButtons: dragStartMask;
		target: aDragTarget;
		gestureSource: aDragTarget;
		yourself).

	aDragStartEvent := self fireEvent: aDragStartEvent.
	
	currentDragTarget := aDragStartEvent isConsumed
		ifTrue: [ aDragStartEvent currentTarget ]
		ifFalse: [ nil ].

	^ dndInProgress := aDragStartEvent isConsumed
]

{ #category : #'event processing' }
OBlMouseProcessor >> updateCursorFrom: aTarget [
	| t |
	t := aTarget.
	[ t mouseCursor isNil and: [ t parent isNotNil ] ] whileTrue: [ t := t parent ].
	self space currentCursor = t mouseCursor
		ifTrue: [ ^ self ].
	self space currentCursor: t mouseCursor
]

{ #category : #'event processing' }
OBlMouseProcessor >> updateDragView [

]

{ #category : #'event processing' }
OBlMouseProcessor >> updateFocusOwner: aNode [
	
]
