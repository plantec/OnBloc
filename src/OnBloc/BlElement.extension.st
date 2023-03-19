Extension { #name : #BlElement }

{ #category : #'*OnBloc' }
BlElement >> applyStyles [
	self styles applyStylesForStates: self states allStates.
]

{ #category : #'*OnBloc' }
BlElement >> asStencil [
	^ self
]

{ #category : #'*OnBloc' }
BlElement >> openInOBlSpace [
	"Add self to a new BlSpace and show it. Answer such space."
	| sp |
	sp := OBlSpace new.
	sp root addChild: self.
	sp show.
	^ sp

]

{ #category : #'*OnBloc' }
BlElement >> theme [
	^ self userData
		at: #OBlTheme
		ifAbsent: [ self hasParent
				ifTrue: [ self parent theme ]
				ifFalse: [ OBlTheme default ] ]
]

{ #category : #'*OnBloc' }
BlElement >> theme: aTheme [
	self userData at: #OBlTheme put: aTheme.
	self properties
		addProperty:
			(OBlThemeElementProperty new
				theme: aTheme;
				yourself)
]
