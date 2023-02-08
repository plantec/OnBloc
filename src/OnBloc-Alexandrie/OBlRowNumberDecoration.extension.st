Extension { #name : #OBlRowNumberDecoration }

{ #category : #'*OnBloc-Alexandrie' }
OBlRowNumberDecoration >> aeCairoScaledFontOn: aeCanvas [

	| fontAndStyleBuilder freeTypeFont |
	fontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	freeTypeFont := fontAndStyleBuilder font asAeFTFace.
	^ aeCanvas scaledFontForFace: freeTypeFont size: 12
]

{ #category : #'*OnBloc-Alexandrie' }
OBlRowNumberDecoration >> aeDraw: anItemElement overOn: aeCanvas in: anInfiniteElement [

	| holder index cairoScaledFont cairoGlyphsArray fontExtents h |
	super aeDraw: anItemElement overOn: aeCanvas in: anInfiniteElement.
	aeCanvas restoreContextAfter: [ 
		holder := anInfiniteElement childHolderOf: anItemElement.
		index := holder layoutPosition.
		cairoScaledFont := self aeCairoScaledFontOn: aeCanvas.
		fontExtents := cairoScaledFont extents.
		h := self numberVerticalHeightIn: anItemElement fontHeight: fontExtents height.
		aeCanvas pathTranslate: 4 @ (anItemElement bounds inParent top +  fontExtents ascent + h).
		aeCanvas setSourceColor: Color gray darker.
		cairoGlyphsArray := cairoScaledFont glyphArrayForString: index asString.
		aeCanvas drawText: cairoGlyphsArray font: cairoScaledFont ]
]

{ #category : #'*OnBloc-Alexandrie' }
OBlRowNumberDecoration >> aeDrawBackgroundOn: aeCanvas in: anInfiniteElement [

	"draw the background beneath "

	aeCanvas pathFactory: [ :cairoContext | 
		cairoContext rectangle: self computedBounds ].
	aeCanvas
		setBackgroundWith: [ aeCanvas setSourceColor: Color veryLightGray ]
		alpha: 0.10.
	aeCanvas setBorderOff.
	aeCanvas drawFigure
]

{ #category : #'*OnBloc-Alexandrie' }
OBlRowNumberDecoration >> aeDrawBeneathOn: aeCanvas in: anInfiniteElement [

	"Update the actual width and draw the background beneath "

	self aeMeasureActualWidthOn: aeCanvas in: anInfiniteElement.
	aeCanvas restoreContextAfter: [ self aeDrawBackgroundOn: aeCanvas in: anInfiniteElement ].
	"super sent ensure drawing for item elements"
	super aeDrawBeneathOn: aeCanvas in: anInfiniteElement
]

{ #category : #'*OnBloc-Alexandrie' }
OBlRowNumberDecoration >> aeMeasureActualWidthFor: aNumber on: aeCanvas in: anInfiniteElement [

	"Draw the background beneath "

	| holder cairoScaledFont fontExtents cairoGlyphsArray |
	anInfiniteElement hasChildren ifFalse: [ ^self ].
	holder := anInfiniteElement childHolderOf: anInfiniteElement children last.
	cairoScaledFont := self aeCairoScaledFontOn: aeCanvas.
	fontExtents := cairoScaledFont extents.
	cairoGlyphsArray := cairoScaledFont glyphArrayForString: aNumber asString.
	aeCanvas textExtentsFor: cairoGlyphsArray scaledFont: cairoScaledFont do: [ :aTextExtents | 
		self onActualWidthChangeWith: aTextExtents width + 10 do: [ anInfiniteElement requestLayout ] ]
]

{ #category : #'*OnBloc-Alexandrie' }
OBlRowNumberDecoration >> aeMeasureActualWidthOn: aeCanvas in: anInfiniteElement [

	| nb |
	nb := anInfiniteElement hasChildren ifTrue: [ (anInfiniteElement childHolderOf: anInfiniteElement children last) layoutPosition ] ifFalse: [ 99 ].
	self aeMeasureActualWidthFor: nb asString on: aeCanvas in: anInfiniteElement
]
