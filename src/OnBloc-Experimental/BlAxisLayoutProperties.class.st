"
==BlAxisLayoutProperties== is the root of the hierarchy of layout properties. A just stores data or flags that are used by a morph layout strategy. 
Internal Representation and Key Implementation Points.

    Instance Variables
	positioning:		<Symbol>
	resizing:		<Symbol>


    Implementation Points
positioning and resizing are simple symbols but they should not be used directly by layout strategies. Instead, messages such as #beAtCenter or #isAtCenter should be sent.
"
Class {
	#name : #BlAxisLayoutProperties,
	#superclass : #Object,
	#instVars : [
		'positioning',
		'resizing'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy'
}

{ #category : #common }
BlAxisLayoutProperties >> beAnywhere [
	self positioning: #nop
]

{ #category : #common }
BlAxisLayoutProperties >> beAtBottom [
	self positioning: #bottom
]

{ #category : #common }
BlAxisLayoutProperties >> beAtBottomCenter [
	self positioning: #bottomCenter
]

{ #category : #common }
BlAxisLayoutProperties >> beAtBottomLeft [
	self positioning: #bottomLeft
]

{ #category : #common }
BlAxisLayoutProperties >> beAtBottomRight [
	self positioning: #bottomRight
]

{ #category : #common }
BlAxisLayoutProperties >> beAtCenter [
	self positioning: #center
]

{ #category : #common }
BlAxisLayoutProperties >> beAtLeft [
	self positioning: #left
]

{ #category : #common }
BlAxisLayoutProperties >> beAtLeftCenter [
	self positioning: #leftCenter
]

{ #category : #common }
BlAxisLayoutProperties >> beAtRight [
	self positioning: #right
]

{ #category : #common }
BlAxisLayoutProperties >> beAtRightCenter [
	self positioning: #rightCenter
]

{ #category : #common }
BlAxisLayoutProperties >> beAtTop [
	self positioning: #top
]

{ #category : #common }
BlAxisLayoutProperties >> beAtTopCenter [
	self positioning: #topCenter
]

{ #category : #common }
BlAxisLayoutProperties >> beAtTopLeft [
	self positioning: #topLeft
]

{ #category : #common }
BlAxisLayoutProperties >> beAtTopRight [
	self positioning: #topRight
]

{ #category : #common }
BlAxisLayoutProperties >> beFlexible [
	self positioning: #nop.
	self resizing: #flexible
]

{ #category : #common }
BlAxisLayoutProperties >> beRigid [
	self positioning: #top.
	self resizing: #rigid
]

{ #category : #testing }
BlAxisLayoutProperties >> canBeAnywhere [
	^ self positioning = #nop
]

{ #category : #testing }
BlAxisLayoutProperties >> canNotBeAnywhere [
	^ self positioning ~= #nop
]

{ #category : #testing }
BlAxisLayoutProperties >> isAtBottom [
	^ self positioning = #bottom
]

{ #category : #testing }
BlAxisLayoutProperties >> isAtBottomLeft [
	^ self positioning = #bottomLeft
]

{ #category : #testing }
BlAxisLayoutProperties >> isAtBottomRight [
	^ self positioning = #bottomRight
]

{ #category : #testing }
BlAxisLayoutProperties >> isAtCenter [
	^ self positioning = #center
]

{ #category : #testing }
BlAxisLayoutProperties >> isAtLeft [
	^ self positioning = #left
]

{ #category : #testing }
BlAxisLayoutProperties >> isAtRight [
	^ self positioning = #right
]

{ #category : #testing }
BlAxisLayoutProperties >> isAtTop [
	^ self positioning = #top
]

{ #category : #testing }
BlAxisLayoutProperties >> isAtTopLeft [
	^ self positioning = #topLeft
]

{ #category : #testing }
BlAxisLayoutProperties >> isAtTopRight [
	^ self positioning = #topRight
]

{ #category : #testing }
BlAxisLayoutProperties >> isFlexible [
	^ self resizing = #flexible
]

{ #category : #testing }
BlAxisLayoutProperties >> isRigid [
	^ self resizing = #rigid
]

{ #category : #accessing }
BlAxisLayoutProperties >> positioning [
	^ positioning ifNil: [ positioning := #nop ]
]

{ #category : #accessing }
BlAxisLayoutProperties >> positioning: aSymbol [
	"This property describes how the receiver should be layed out in its owner when 
	the bounds of the cell assigned to the receiver do not exactly match its bounds. Possible values are:
	#top, #right, #left, #bottom, #center, #topLeft, #topRight, #bottomLeft, #bottomRight 
	which align the receiver's bounds with the cell at the given point."
	positioning := aSymbol
]

{ #category : #accessing }
BlAxisLayoutProperties >> resizing [
	^ resizing ifNil: [ resizing := #rigid ]
]

{ #category : #accessing }
BlAxisLayoutProperties >> resizing: aSymbol [
	"#flexible or #rigid"
	resizing := aSymbol
]
