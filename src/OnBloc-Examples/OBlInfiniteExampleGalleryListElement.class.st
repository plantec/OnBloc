Class {
	#name : #OBlInfiniteExampleGalleryListElement,
	#superclass : #OBlInfiniteElement,
	#category : #'OnBloc-Examples-Infinite-Image-Gallery'
}

{ #category : #initialization }
OBlInfiniteExampleGalleryListElement >> defaultDataSource [

	^ OBlInfiniteExampleGalleryDataSource new
]

{ #category : #initialization }
OBlInfiniteExampleGalleryListElement >> defaultLayout [
	^ OBlInfiniteLinearLayout vertical
]

{ #category : #'children hooks' }
OBlInfiniteExampleGalleryListElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	dataSource requestImages
]
