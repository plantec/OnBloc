Class {
	#name : #OBlViewModel,
	#superclass : #OBlElementCompanion,
	#category : #'OnBloc-element compagnion'
}

{ #category : #initialization }
OBlViewModel >> defaultDresser [

	^ nil

]

{ #category : #'accessing - dresser' }
OBlViewModel >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'accessing - dresser' }
OBlViewModel >> dresser: aDresser [

	self dresserDo: [ :currDresser | 
		self widgetDo: [ :widget | 
			currDresser onUninstalledIn: widget.
			self userData at: #dresser put: nil ] ].

	self userData at: #dresser put: aDresser.

	self dresserDo: [ :currDresser | 
		self widgetDo: [ :widget | 
			currDresser onInstalledIn: widget.
			self userData at: #dresser put: currDresser ] ]
]

{ #category : #'accessing - dresser' }
OBlViewModel >> dresserDo: aBlock [
	self dresser ifNotNil: aBlock
]

{ #category : #initialization }
OBlViewModel >> initialize [ 

	super initialize.
	self startPostponedActionsStorage.
	self dresser: self defaultDresser

]

{ #category : #'api - hooks' }
OBlViewModel >> managePostponedActionsIn: anElement while: aBlock [

	self stopPostponedActionsStorageFor: anElement.
	aBlock value.
	self runPostponedActions
]

{ #category : #'api - hooks' }
OBlViewModel >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self managePostponedActionsIn: anElement while: [ 
		self onInstalledOnlyMeIn: anElement ]
]

{ #category : #'api - hooks' }
OBlViewModel >> onInstalledOnlyMeIn: anElement [


]

{ #category : #'api - hooks' }
OBlViewModel >> onUninstalledIn: anElement [

	"Is sent when I am removed from an element "

	super onUninstalledIn: anElement.
	self unsubscribe: anElement.
	self onUninstalledOnlyMeIn: anElement
]

{ #category : #'api - hooks' }
OBlViewModel >> onUninstalledOnlyMeIn: anElement [


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
OBlViewModel >> runPostponedActions [

	self postponedActions do: [ :announcement | self announce: announcement ].
	self removePostponedActions
]

{ #category : #'private-postponed actions' }
OBlViewModel >> startPostponedActionsStorage [

	self whenAnnouncement: ToActionRequiredInWidget send: #whenActionRequiredInWidget: to: self
]

{ #category : #'private-postponed actions' }
OBlViewModel >> stopPostponedActionsStorageFor: anElement [

	self unsubscribe: self.
	self whenAnnouncement: ToActionRequiredInWidget send: #whenActionRequired: to: anElement

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
