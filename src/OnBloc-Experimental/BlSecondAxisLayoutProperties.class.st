Class {
	#name : #BlSecondAxisLayoutProperties,
	#superclass : #BlAxisLayoutProperties,
	#category : #'OnBloc-Experimental-LayoutStrategy'
}

{ #category : #common }
BlSecondAxisLayoutProperties >> beAtBottom [
	self resizing: #rigid.
	self positioning: #bottom
]

{ #category : #common }
BlSecondAxisLayoutProperties >> beAtBottomLeft [
	self resizing: #rigid.
	self positioning: #bottomLeft
]

{ #category : #common }
BlSecondAxisLayoutProperties >> beAtBottomRight [
	self resizing: #rigid.
	self positioning: #bottomRight
]

{ #category : #common }
BlSecondAxisLayoutProperties >> beAtCenter [
	self resizing: #rigid.
	self positioning: #center
]

{ #category : #common }
BlSecondAxisLayoutProperties >> beAtLeft [
	self resizing: #rigid.
	self positioning: #left
]

{ #category : #common }
BlSecondAxisLayoutProperties >> beAtRight [
	self resizing: #rigid.
	self positioning: #right
]

{ #category : #common }
BlSecondAxisLayoutProperties >> beAtTop [
	self resizing: #rigid.
	self positioning: #top
]

{ #category : #common }
BlSecondAxisLayoutProperties >> beAtTopLeft [
	self resizing: #rigid.
	self positioning: #topLeft
]

{ #category : #common }
BlSecondAxisLayoutProperties >> beAtTopRight [
	self resizing: #rigid.
	self positioning: #topRight
]
