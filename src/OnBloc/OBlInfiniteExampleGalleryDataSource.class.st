Class {
	#name : #OBlInfiniteExampleGalleryDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'images'
	],
	#category : #'OnBloc-Infinite-Examples-Gallery'
}

{ #category : #accessing }
OBlInfiniteExampleGalleryDataSource >> images: anArray [
	images := anArray.

	"everything changed"
	self notifyChanged
]

{ #category : #initialization }
OBlInfiniteExampleGalleryDataSource >> initialize [
	super initialize.
	
	images := #().
	hasStableIds := false
]

{ #category : #accessing }
OBlInfiniteExampleGalleryDataSource >> itemCount [
	^ images size
]

{ #category : #'instance creation' }
OBlInfiniteExampleGalleryDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"

	anElementHolder image: (images at: aPosition)
]

{ #category : #'instance creation' }
OBlInfiniteExampleGalleryDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ OBlInfiniteExampleGalleryElementHolder new
]

{ #category : #requesting }
OBlInfiniteExampleGalleryDataSource >> requestImages [
	
	images
		ifNotEmpty: [ ^ self ].

	loader
		ifNotNil: [ ^ self ].

	loader := [
		| theImages |
		theImages := (STONJSON fromString: 'https://unsplash.it/list' asUrl retrieveContents)
			collect: [ :aDictionary | OBlInfiniteExampleGalleryImage fromDictionary: aDictionary ].
		theImages sort: [ :a :b | a id > b id ].
		self images: theImages ] fork
]
