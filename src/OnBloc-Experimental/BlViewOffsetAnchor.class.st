Class {
	#name : #BlViewOffsetAnchor,
	#superclass : #BlViewAnchor,
	#instVars : [
		'baseAnchor',
		'offsetBlock'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy-Anchor-Support'
}

{ #category : #accessing }
BlViewOffsetAnchor >> baseAnchor [

	^ baseAnchor
]

{ #category : #accessing }
BlViewOffsetAnchor >> baseAnchor: anObject [

	baseAnchor := anObject
]

{ #category : #accessing }
BlViewOffsetAnchor >> offsetBlock [

	^ offsetBlock
]

{ #category : #accessing }
BlViewOffsetAnchor >> offsetBlock: anObject [

	offsetBlock := anObject
]

{ #category : #evaluating }
BlViewOffsetAnchor >> value [
	^ offsetBlock value: baseAnchor value
]

{ #category : #accessing }
BlViewOffsetAnchor >> view [
	^ baseAnchor view
]
