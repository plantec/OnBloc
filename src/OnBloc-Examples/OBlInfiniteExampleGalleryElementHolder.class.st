Class {
	#name : #OBlInfiniteExampleGalleryElementHolder,
	#superclass : #OBlInfiniteHolder,
	#instVars : [
		'image'
	],
	#category : #'OnBloc-Examples-Infinite-Image-Gallery'
}

{ #category : #accessing }
OBlInfiniteExampleGalleryElementHolder >> image [
	^ image
]

{ #category : #accessing }
OBlInfiniteExampleGalleryElementHolder >> image: anImage [

	image = anImage
		ifTrue: [ ^ self ].

	image := anImage.
	itemElement image: anImage
]

{ #category : #initialization }
OBlInfiniteExampleGalleryElementHolder >> initialize [
	super initialize.
	itemElement := OBlInfiniteExampleGalleryImageElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent.
			c margin: (BlInsets top: 0 right: 0 bottom: 4 left: 0) ];
		yourself
]
