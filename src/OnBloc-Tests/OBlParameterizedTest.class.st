Class {
	#name : #OBlParameterizedTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'testingSpaces',
		'hostClass'
	],
	#category : #'OnBloc-Tests'
}

{ #category : #testing }
OBlParameterizedTest class >> isAbstract [

	^ self == OBlParameterizedTest
]

{ #category : #tests }
OBlParameterizedTest class >> testParameters [

	^ ParametrizedTestMatrix new
		forSelector: #hostClass
		addOptions: {
			BlOSWindowSDL2Host.
		   BlMockedHost.
			BlMorphicWindowHost }
]

{ #category : #accessing }
OBlParameterizedTest >> hostClass [

	^ hostClass
]

{ #category : #accessing }
OBlParameterizedTest >> hostClass: aClass [

	hostClass := aClass
]

{ #category : #'instance creation' }
OBlParameterizedTest >> newTestingSpace [

	| aSpace |
	aSpace := OBlSpace new.
	aSpace host: hostClass new.
	testingSpaces add: aSpace.
	^ aSpace
]

{ #category : #running }
OBlParameterizedTest >> setUp [
	super setUp.

	testingSpaces := OrderedCollection new.
]

{ #category : #running }
OBlParameterizedTest >> tearDown [

	self waitTestingSpaces.
	testingSpaces do: [ :each | each close ].
	self waitTestingSpaces.
	
	super tearDown.

]

{ #category : #tests }
OBlParameterizedTest >> waitTestingSpaces [

	testingSpaces do: [ :each |
		self assert: (OBlSpace
			pulseUntilEmptyTaskQueue: each
			timeout: 200 milliSeconds) ]
]
