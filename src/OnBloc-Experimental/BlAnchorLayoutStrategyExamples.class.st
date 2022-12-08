Class {
	#name : #BlAnchorLayoutStrategyExamples,
	#superclass : #Object,
	#category : #'OnBloc-Experimental-Core-Examples'
}

{ #category : #examples }
BlAnchorLayoutStrategyExamples class >> example1 [
	"The following example produces two morphs: one (white) nested into another one (red). 
	When the root morph changes its size, the white will update its size accordingly."
	<example>
	
	| redRoot whiteSub1  |
	redRoot := BlMorph new.
	redRoot layoutStrategy: BlAnchorLayoutStrategy new.
	redRoot withRectangleViewDo: [ :v | v color: Color red ].
	whiteSub1 := BlMorph new withRectangleViewDo: [ :v | v color: Color white].
	redRoot addMorph: whiteSub1.
	whiteSub1 anchorLeft: redRoot leftAnchor + 4.
	redRoot openInWorld.
	^ redRoot
]

{ #category : #examples }
BlAnchorLayoutStrategyExamples class >> example2 [
	"The following example produces two morphs: one (white) nested into another one (red). 
	When the root morph changes its size, the white will update its size accordingly."
	<example>
	
	| redRoot whiteSub1  |
	redRoot := BlMorph new.
	redRoot layoutStrategy: BlAnchorLayoutStrategy new.
	redRoot withRectangleViewDo: [ :v | v color: Color red ].
	whiteSub1 := BlMorph new withRectangleViewDo: [ :v | v color: Color white].
	redRoot addMorph: whiteSub1.
	whiteSub1 anchorLeft: redRoot leftAnchor + 4.
	whiteSub1 anchorTop: redRoot topAnchor + 4.
	whiteSub1 anchorBottom: redRoot bottomAnchor - 4.
	whiteSub1 anchorRight: redRoot rightAnchor - 4.
	redRoot openInWorld.
	^ redRoot
]

{ #category : #examples }
BlAnchorLayoutStrategyExamples class >> example3 [
	"The following example produces two morphs: one (white) nested into another one (red). 
	When the root morph changes its size, the white will update its size accordingly."
	<example>
	"self example2"
	| root1 root2 root sub1 sub2 |
	root := BlMorph new.
	root layoutStrategy: BlAnchorLayoutStrategy new.
	root withRectangleViewDo: [ :v | v color: Color red].
	sub1 := BlMorph new withRectangleViewDo: [ :s | s color: Color white ].
	sub2 := BlMorph new withRectangleViewDo: [ :s | s color: Color black ].
	sub1 anchorLeft: root leftAnchor.
	sub1 anchorTop: root topAnchor.
	sub1 anchorBottom: root topAnchor + 20.
	sub1 anchorRight: root rightAnchor.
	sub2 anchorRight: root rightAnchor - 10.
	sub2 anchorLeft: root leftAnchor + 10.
	sub2 anchorTop: sub1 bottomAnchor + 3.
	sub2 anchorBottom: root bottomAnchor - 3.
	root addMorph: sub1.
	root addMorph: sub2.
	root1 := BlMorph new withRectangleViewDo: [ :s | s color: Color yellow ].
	root1 layoutStrategy: BlAnchorLayoutStrategy new.
	root anchorRight: root1 rightAnchor - 10.
	root anchorLeft: root1 leftAnchor + 10.
	root anchorTop: root1 topAnchor + 3.
	root anchorBottom: root1 bottomAnchor - 3.
	root1 addMorph: root.
	root2 := BlMorph new withRectangleViewDo: [ :s | s color: Color pink ].
	root2 layoutStrategy: BlAnchorLayoutStrategy new.
	root1 anchorRight: root2 rightAnchor - 10.
	root1 anchorLeft: root2 leftAnchor + 10.
	root1 anchorTop: root2 topAnchor + 3.
	root2 addMorph: root1.
	root2 extent: 400 @ 200.
	root2
		withRectangleViewDo: [ :s | s borderStyle: (BlSolidRectangleBorder new width: 4; color: Color red; yourself) ].
	root2 openInWorld.
	^ root2
]

{ #category : #examples }
BlAnchorLayoutStrategyExamples class >> example_1 [

 	| middle left right space bnds container |
	container := ToElement new background: Color yellow; size: 200@200.
	middle := ToElement new background: Color red.
	left := ToElement new
		        background: Color gray;
		        size: 40 @ 40;
		        relocate: 10 @ 100.
	right := ToElement new
		         background: Color gray;
		         size: 40 @ 40;
		         relocate: 100 @ 100.
	middle anchorLeft: left rightAnchor + 10.
	middle anchorRight: right leftAnchor - 10.
	space := OBlSpace new.
	container addChild: left.
	container addChild: right.
	container addChild: middle.
	space root addChild: container.
	container forceLayout.
	space show.
	space root computeLayout.
	bnds := (middle globalBoundsToLocal: (BlBounds fromRectangle: (middle anchoredBoundsIn: (container bounds bounds)))).
	middle relocate: bnds topLeft.
	middle size: bnds extent.


]
