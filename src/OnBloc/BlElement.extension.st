Extension { #name : #BlElement }

{ #category : #'*OnBloc' }
BlElement >> openInOBlSpace [
	"Add self to a new BlSpace and show it. Answer such space."
	
	self 
		deprecated:  'Use #openInSpace instead' 
		transformWith: '`@receiver openInOBlSpace' -> '`@receiver openInSpace'.
	
	^ self openInSpace

]

{ #category : #'*OnBloc' }
BlElement >> openInSpace [
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
