Class {
	#name : #OBlSmoothScroller,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'isRunning',
		'pendingInitialRun'
	],
	#category : #'OnBloc-Scrollable-Core'
}

{ #category : #initialization }
OBlSmoothScroller >> initialize [
	super initialize.
	
	isRunning := false.
	pendingInitialRun := true
]

{ #category : #'api - testing' }
OBlSmoothScroller >> isPendingInitialRun [
	^ pendingInitialRun
]

{ #category : #'api - testing' }
OBlSmoothScroller >> isRunning [
	^ isRunning
]

{ #category : #'api - scrolling' }
OBlSmoothScroller >> scrollBy: aPoint [
	self subclassResponsibility
]
