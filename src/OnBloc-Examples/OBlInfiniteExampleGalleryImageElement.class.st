Class {
	#name : #OBlInfiniteExampleGalleryImageElement,
	#superclass : #BlElement,
	#instVars : [
		'image',
		'loader',
		'form',
		'itemElement',
		'bitmap'
	],
	#category : #'OnBloc-Examples-Infinite-Image-Gallery'
}

{ #category : #nil }
OBlInfiniteExampleGalleryImageElement >> aeDrawOn: aeCanvas [

	| aScale |
	form ifNil: [ ^ super aeDrawOn: aeCanvas ].
	aeCanvas restoreContextAfter: [ 
		aScale := (self extent / form extent) asFloatPoint.
		aeCanvas pathScale: aScale.
		super aeDrawOn: aeCanvas ]
]

{ #category : #layout }
OBlInfiniteExampleGalleryImageElement >> applyLayoutIn: aBounds context: aBlElementBoundsUpdateContext [
	super applyLayoutIn: aBounds context: aBlElementBoundsUpdateContext.
	self loadImage
]

{ #category : #initialization }
OBlInfiniteExampleGalleryImageElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
OBlInfiniteExampleGalleryImageElement >> defaultWidth [
	^ 500
]

{ #category : #drawing }
OBlInfiniteExampleGalleryImageElement >> drawOnSpartaCanvas: aCanvas [
	| aScale |
	super drawOnSpartaCanvas: aCanvas.
	
	form
		ifNil: [ ^ self ].

	bitmap ifNil: [ bitmap := aCanvas bitmap fromForm: form ].
	
	aScale := (self extent / form extent) asFloatPoint.

	aCanvas transform
		by: [ :t | t scaleBy: aScale ]
		during: [
			aCanvas fill
				path: (0@0 extent: form extent);
				paint: bitmap;
				draw ]
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImageElement >> form: aForm [
	
	image form == aForm
		ifFalse: [ ^ self ].
	form := aForm.
	bitmap := nil.
	self background: (BlBackground image: form).
	self requestLayout.
	self invalidate
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImageElement >> image: aGalleryImage [

	image = aGalleryImage
		ifTrue: [ ^ self ].
	form := nil.
	image := aGalleryImage.
	itemElement text: (('Image:: ', aGalleryImage id asString) asRopedText
		foreground: Color white;
		fontSize: 14).
	
	self loadImage
]

{ #category : #initialization }
OBlInfiniteExampleGalleryImageElement >> initialize [
	super initialize.

	self background: Color veryVeryDarkGray lighter.
	
	itemElement := BlTextElement new
		geometry: BlEllipseGeometry new;
		background: (Color gray alpha: 0.4);
		border: (BlBorder paint: (Color white alpha: 0.2) width: 1);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c frame vertical alignCenter.
			c padding: (BlInsets all: 10) ];
		yourself.
	
	self padding: (BlInsets left: 20).
	self addChild: itemElement
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImageElement >> loadImage [
	| anImage aForm |
	
	loader ifNotNil: #terminate.
	anImage := image.
	aForm := form.
	
	(anImage form isNotNil and: [ anImage form extent = self extent asIntegerPoint ])
		ifTrue: [
			aForm = anImage form
				ifFalse: [ self form: anImage form ].
			^ self ].

	loader := [
		| aNewForm timesRetry aByteArray |
		timesRetry := 0.
		[ (aByteArray := ([(image loadUrl: self extent asIntegerPoint) asUrl retrieveContents] on: Error do: [] )) isNil and: [ 
			timesRetry < 5 ] ] whileTrue: [ timesRetry := timesRetry + 1 ].
		aByteArray ifNotNil: [
			aNewForm := Form fromBinaryStream: aByteArray readStream.
			anImage form: aNewForm.
			image = anImage
				ifTrue: [
					self enqueueTask: (BlTaskAction new action: [ self form: aNewForm ]) ] ] ] fork
]

{ #category : #layout }
OBlInfiniteExampleGalleryImageElement >> onMeasure: anExtentMeasurementSpec [
	| aWidth aHeight aWidthSpec aHeightSpec |
	super onMeasure: anExtentMeasurementSpec.
	
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	
	aWidth := aWidthSpec isUnspecified
		ifTrue: [ self defaultWidth ]
		ifFalse: [ aWidthSpec size ].
		"Unspecified means that layout may take as much space horizontally as it wishes"
	aHeight := aHeightSpec isUnspecified
		ifTrue: [ (aWidth / 16 * 9) ]
		ifFalse: [ aHeightSpec size ].

	self measuredExtent: aWidth @ aHeight
]
