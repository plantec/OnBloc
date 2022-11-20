Class {
	#name : #OBlStuffs,
	#superclass : #Object,
	#category : #'OnBloc-Examples'
}

{ #category : #'as yet unclassified' }
OBlStuffs class >> example_fitContentLimited [
| subChildren red brown blue green parent |
	subChildren := 4
		timesCollect: [ BlElement new
				background: (Color red alpha: 0.5);
				margin: (BlInsets all: 20);
				size: 100 @ 100 ].
	red := BlElement new.
	red layout: BlLinearLayout vertical.
	red background: (Color red alpha: 0.3).
	red border: (BlBorder paint: Color red width: 2).
	red
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContentLimited ].
	red addChildren: subChildren.
	brown := BlElement new.
	brown background: (Color brown alpha: 0.3).
	brown border: (BlBorder paint: Color brown width: 2).
	brown size: 100 @ 75.
	blue := BlElement new.
	blue background: (Color blue alpha: 0.3).
	blue border: (BlBorder paint: Color blue width: 2).
	blue size: 75 @ 50.
	green := BlElement new.
	green background: (Color green darker alpha: 0.3).
	green border: (BlBorder paint: Color green muchDarker width: 2).
	green
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	parent := BlElement new.
	parent layout: (BlLinearLayout vertical cellSpacing: 20).
	parent background: (Color gray alpha: 0.3).
	parent
		constraintsDo: [ :c | 
			c horizontal exact: 300.
			c vertical matchParent ].
	parent
		addChildren:
			{blue.
			red.
			brown.
			green}.
	parent padding: (BlInsets left: 20 right: 20).
	parent openInOBlSpace 
]
