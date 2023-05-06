Class {
	#name : #OBlInfiniteLayoutStepFlags,
	#superclass : #BlBitflags,
	#classVars : [
		'Animations',
		'Layout',
		'Start'
	],
	#category : #'OnBloc-Infinite-Flags'
}

{ #category : #'accessing - flags' }
OBlInfiniteLayoutStepFlags class >> Animations [
	"This method was automatically generated"
	^ Animations value
]

{ #category : #'accessing - flags' }
OBlInfiniteLayoutStepFlags class >> Layout [
	"This method was automatically generated"
	^ Layout value
]

{ #category : #'accessing - flags' }
OBlInfiniteLayoutStepFlags class >> Start [
	"This method was automatically generated"
	^ Start value
]

{ #category : #'flags declaration' }
OBlInfiniteLayoutStepFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	^ {
		#START.
		#LAYOUT.
		#ANIMATIONS.
	}
]

{ #category : #initialization }
OBlInfiniteLayoutStepFlags class >> initialize [
	super initialize
]

{ #category : #'flags - add' }
OBlInfiniteLayoutStepFlags >> addAnimations [
	"This method was automatically generated"
	value := value | Animations value
]

{ #category : #'flags - add' }
OBlInfiniteLayoutStepFlags >> addLayout [
	"This method was automatically generated"
	value := value | Layout value
]

{ #category : #'flags - add' }
OBlInfiniteLayoutStepFlags >> addStart [
	"This method was automatically generated"
	value := value | Start value
]

{ #category : #'flags - clear' }
OBlInfiniteLayoutStepFlags >> clearAnimations [
	"This method was automatically generated"
	value := value & (Animations value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteLayoutStepFlags >> clearLayout [
	"This method was automatically generated"
	value := value & (Layout value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteLayoutStepFlags >> clearStart [
	"This method was automatically generated"
	value := value & (Start value bitInvert)
]

{ #category : #'flags - testing' }
OBlInfiniteLayoutStepFlags >> hasAnimations [
	"This method was automatically generated"
	^ (value & Animations value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteLayoutStepFlags >> hasLayout [
	"This method was automatically generated"
	^ (value & Layout value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteLayoutStepFlags >> hasStart [
	"This method was automatically generated"
	^ (value & Start value) ~= 0
]
