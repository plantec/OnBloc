Class {
	#name : #'OBlExample_ImageGallery',
	#superclass : #Object,
	#category : #'OnBloc-Examples-Infinite-Image-Gallery'
}

{ #category : #examples }
OBlExample_ImageGallery class >> exampleGallery [
	| space list container header headerText |
	space := OBlSpace new
		extent: 400 @ 650;
		title: 'Gallery'.

	container := BlElement new
		layout: BlFrameLayout new;
		background: Color veryDarkGray;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			"will take 100% of the parent"
			c linear weight: 1 ];
		yourself.	

	header := BlElement new
		layout: BlLinearLayout vertical;
		"effect: (BlBlurBelowEffect radius: 4);"
		background: (Color black alpha: 0.6);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent.
			c frame vertical alignTop.
			c padding: (BlInsets top: 15 right: 0 bottom: 15 left: 0) ];
		yourself.

	headerText := BlTextElement new
		text: ('bloc gallery' asRopedText
			foreground: (Color white alpha: 0.8);
			fontSize: 20;
			weight: 50;
			fontName: 'Helvetica Neue');
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c linear horizontal alignCenter.
			c linear vertical alignCenter ];
		yourself.
		
	header addChild: headerText.
	
	list := OBlInfiniteExampleGalleryListElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
list inspect.
	container addChildren: { header. list }.
	space root addChild: container.
	space root background: Color veryVeryDarkGray.
	space root layout: BlLinearLayout horizontal.
	space root layout weightSum: 1.
	space show
]
