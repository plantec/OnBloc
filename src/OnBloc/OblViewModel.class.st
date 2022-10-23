Class {
	#name : #OBlViewModel,
	#superclass : #OBlElementCompanion,
	#category : #'OnBloc-element compagnion'
}

{ #category : #initialization }
OBlViewModel >> initialize [ 

	super initialize.
	self startPostponedActionsStorage.

]

{ #category : #'api - hooks' }
OBlViewModel >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self stopPostponedActionsStorageFor: anElement.

]

{ #category : #'api - hooks' }
OBlViewModel >> onUninstalledIn: anElement [

	"Is sent when I am removed from an element "

	super onUninstalledIn: anElement.
	self unsubscribe: anElement
]

{ #category : #'private-postponed actions' }
OBlViewModel >> postponedActions [

	^ self userData at: #postponedActions ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #'private-postponed actions' }
OBlViewModel >> removePostponedActions [

	self userData removeKey: #postponedActions ifAbsent: [  ]
]

{ #category : #'private-postponed actions' }
OBlViewModel >> runPostponedAction [

	self postponedActions do: [ :announcement | self announce: announcement ].
	self removePostponedActions
]

{ #category : #'private-postponed actions' }
OBlViewModel >> startPostponedActionsStorage [

	self when: ToActionRequiredInWidget send: #whenActionRequiredInWidget: to: self
]

{ #category : #'private-postponed actions' }
OBlViewModel >> stopPostponedActionsStorageFor: anElement [

	self unsubscribe: self.
	self when: ToActionRequiredInWidget send: #whenActionRequired: to: anElement

]

{ #category : #'accessing - widget' }
OBlViewModel >> whenActionRequiredInWidget: anActionRequired [

	self postponedActions add: anActionRequired.
]

{ #category : #'accessing - widget' }
OBlViewModel >> widgetDo: aBlock [

	self announce: (ToActionRequiredInWidget new
			 valuable: aBlock;
			 yourself)
]
