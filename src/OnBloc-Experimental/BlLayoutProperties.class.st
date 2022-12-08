"
Each view owns a ==BlLayoutProperties== instance to store data that are useful for the morph layout strategy. 

Internal Representation and Key Implementation Points.

    Instance Variables
	anchors:		<OrderedCollection of BlViewAnchor | nil>
	extentRestriction:		<BlExtentRestriction>
	secondAxisProperties:		<BlSecondAxisLayoutProperties>


    Implementation Points
"
Class {
	#name : #BlLayoutProperties,
	#superclass : #BlAxisLayoutProperties,
	#instVars : [
		'anchors',
		'extentRestriction',
		'secondAxisProperties'
	],
	#category : #'OnBloc-Experimental-LayoutStrategy'
}

{ #category : #'anchor layout' }
BlLayoutProperties >> anchors [
	^ anchors ifNil: [ anchors := IdentityDictionary new ]
]

{ #category : #common }
BlLayoutProperties >> cellPositioning [
	^ self positioning 
]

{ #category : #'initialize-release' }
BlLayoutProperties >> defaultExtentRestriction [

	^ BlExtentRestriction new
]

{ #category : #'box layout' }
BlLayoutProperties >> defaultSecondAxisProperties [
	^ BlSecondAxisLayoutProperties new beAtCenter; beFlexible; yourself
]

{ #category : #common }
BlLayoutProperties >> extentRestriction [

	^ extentRestriction ifNil: [ extentRestriction := self defaultExtentRestriction ]
]

{ #category : #'initialize-release' }
BlLayoutProperties >> initialize [
	super initialize.
	self beFlexible.
	self beAtCenter
]

{ #category : #common }
BlLayoutProperties >> secondAxisDo: aBlock [ 
	aBlock value: self secondAxisProperties 
]

{ #category : #common }
BlLayoutProperties >> secondAxisProperties [
	^ secondAxisProperties ifNil: [ secondAxisProperties := self defaultSecondAxisProperties ]
]
