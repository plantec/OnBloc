Extension { #name : #BlElement }

{ #category : #'*OnBloc' }
BlElement >> asStencil [
	^ self
]

{ #category : #'*OnBloc' }
BlElement >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'*OnBloc' }
BlElement >> dresser: aDresser [
	| installed |
	
	self dresserDo: [ :currDresser |
		currDresser onUninstalledIn: self.
		self userData at: #dresser put: nil ].

	installed := aDresser asLook.

	self userData at: #dresser put: installed.
	installed onInstalledIn: self
]

{ #category : #'*OnBloc' }
BlElement >> dresserDo: aBlock [
	self dresser ifNotNil: aBlock
]

{ #category : #'*OnBloc' }
BlElement >> theme [
	^ self userData
		at: #OblTheme
		ifAbsent: [ self hasParent
				ifTrue: [ self parent theme ]
				ifFalse: [ OblTheme default ] ]
]

{ #category : #'*OnBloc' }
BlElement >> theme: aTheme [
	self userData at: #OblTheme put: aTheme.
	self properties
		addProperty:
			(OblThemeElementProperty new
				theme: aTheme;
				yourself)
]

{ #category : #'*OnBloc' }
BlElement >> viewModel [
	^ self userData at: #oblViewModel ifAbsent: nil
]

{ #category : #'*OnBloc' }
BlElement >> viewModel: aViewModel [

	self viewModelDo: [ :aCurrentModel |
		aCurrentModel onUninstalledIn: self.
		self userData at: #oblViewModel put: nil ].

	self userData at: #oblViewModel put: aViewModel.
	aViewModel onInstalledIn: self
]

{ #category : #'*OnBloc' }
BlElement >> viewModelDo: aBlock [
	self userData at: #oblViewModel ifPresent: aBlock
]

{ #category : #'*OnBloc' }
BlElement >> widgetContent [

	^ self
		  directChildNamed: #content
		  ifFound: [ :anElement | anElement ]
		  ifNone: [ self ]
]
