Class {
	#name : #OBlSpaceFrame,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'id',
		'phases',
		'currentPhaseLink'
	],
	#category : #'OnBloc-Space - Frame'
}

{ #category : #adding }
OBlSpaceFrame >> addPhase: aFramePhase [

	self phases add: aFramePhase
]

{ #category : #adding }
OBlSpaceFrame >> addPhases: aCollectonOfPhases [
	aCollectonOfPhases do: [ :aFramePhase | self addPhase: aFramePhase ]
]

{ #category : #accessing }
OBlSpaceFrame >> currentPhase [

	^ currentPhaseLink value
]

{ #category : #testing }
OBlSpaceFrame >> hasNextPhase [
	<return: #Boolean>

	^ currentPhaseLink nextLink isNotNil
]

{ #category : #accessing }
OBlSpaceFrame >> id [
	"Return the frame id, which is a linearly increasing counter of frames"
	<return: #Number>
	
	^ id
]

{ #category : #private }
OBlSpaceFrame >> incrementFrameId [
	id := id + 1
]

{ #category : #initialization }
OBlSpaceFrame >> initialize [
	super initialize.
	
	id := 0.
	phases := LinkedList new.
	self initializePhases.
	currentPhaseLink := phases firstLink
]

{ #category : #initialization }
OBlSpaceFrame >> initializePhases [
	self addPhases: { 
		BlSpaceFrameIdlePhase new.
		BlSpaceFrameHostValidationPhase new.
		BlSpaceFrameTaskPhase new.
		BlSpaceFrameEventPhase new.
		"BlSpaceFrameStylePhase new."
		"BlSpaceFramePropertiesPhase new."
		BlSpaceFrameDrawingValidationPhase new.
		BlSpaceFrameLayoutPhase new.
		BlSpaceFrameDrawingPhase new }
]

{ #category : #private }
OBlSpaceFrame >> nextPhaseLink [
	"Return the link with a next frame after the current one"
	<return: #Link>

	^ self hasNextPhase
		ifTrue: [ currentPhaseLink nextLink ]
		ifFalse: [ phases firstLink ]
]

{ #category : #accessing }
OBlSpaceFrame >> phases [
	"Return a collection of all phases"
	<return: #Collection of: #BlSpaceFramePhase>

	^ phases
]

{ #category : #running }
OBlSpaceFrame >> runCurrentPhaseOn: aSpace [

	self currentPhase runOn: aSpace
]

{ #category : #running }
OBlSpaceFrame >> runOn: aSpace [
	self incrementFrameId.
	self runCurrentPhaseOn: aSpace.

	[ self hasNextPhase ] whileTrue: [
		self switchToNextPhase.
		self runCurrentPhaseOn: aSpace ].

	"move back to the first phase"
	self switchToNextPhase
]

{ #category : #running }
OBlSpaceFrame >> switchToNextPhase [
	"Switch to the next phase"

	currentPhaseLink := self nextPhaseLink
]
