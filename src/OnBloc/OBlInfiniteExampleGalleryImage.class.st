Class {
	#name : #OBlInfiniteExampleGalleryImage,
	#superclass : #Object,
	#instVars : [
		'format',
		'filename',
		'author',
		'authorUrl',
		'height',
		'width',
		'postUrl',
		'id',
		'form'
	],
	#category : #'OnBloc-Infinite-Examples-Gallery'
}

{ #category : #'instance creation' }
OBlInfiniteExampleGalleryImage class >> fromDictionary: aDictionary [
	^ self new
		format: (aDictionary at: #format);
		filename: (aDictionary at: #filename);
		author: (aDictionary at: #author);
		authorUrl: (aDictionary at: #author_url);
		height: (aDictionary at: #height);
		postUrl: (aDictionary at: #post_url);
		id: (aDictionary at: #id);
		width: (aDictionary at: #width);
		yourself
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> author [
	^ author
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> author: anObject [
	author := anObject
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> authorUrl [
	^ authorUrl
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> authorUrl: anObject [
	authorUrl := anObject
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> filename [
	^ filename
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> filename: anObject [
	filename := anObject
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> form [
	^ form
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> form: aForm [
	form := aForm
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> format [
	^ format
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> format: anObject [
	format := anObject
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> height [
	^ height
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> height: anObject [
	height := anObject
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> id [
	^ id
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> id: anObject [
	id := anObject
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> loadUrl: anExtent [
	^ 'https://unsplash.it/', (anExtent x min: 4096) asString, '/', (anExtent y min: 4096) asString,'?image=', self id asString
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> postUrl [
	^ postUrl
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> postUrl: anObject [
	postUrl := anObject
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> width [
	^ width
]

{ #category : #accessing }
OBlInfiniteExampleGalleryImage >> width: anObject [
	width := anObject
]
