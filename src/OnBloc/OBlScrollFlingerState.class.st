Class {
	#name : #OBlScrollFlingerState,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'dX',
		'dY',
		'hResult',
		'vResult',
		'overscrollX',
		'overscrollY'
	],
	#category : #'OnBloc-Scrollable-Helpers'
}

{ #category : #accessing }
OBlScrollFlingerState >> dX [
	^ dX
]

{ #category : #accessing }
OBlScrollFlingerState >> dX: anObject [
	dX := anObject
]

{ #category : #accessing }
OBlScrollFlingerState >> dY [
	^ dY
]

{ #category : #accessing }
OBlScrollFlingerState >> dY: anObject [
	dY := anObject
]

{ #category : #testing }
OBlScrollFlingerState >> didScroll [
	^ hResult isZero not or: [ vResult isZero not ]
]

{ #category : #accessing }
OBlScrollFlingerState >> hResult [
	^ hResult
]

{ #category : #accessing }
OBlScrollFlingerState >> hResult: anObject [
	hResult := anObject
]

{ #category : #accessing }
OBlScrollFlingerState >> overscrollX [
	^ overscrollX
]

{ #category : #accessing }
OBlScrollFlingerState >> overscrollX: anObject [
	overscrollX := anObject
]

{ #category : #accessing }
OBlScrollFlingerState >> overscrollY [
	^ overscrollY
]

{ #category : #accessing }
OBlScrollFlingerState >> overscrollY: anObject [
	overscrollY := anObject
]

{ #category : #accessing }
OBlScrollFlingerState >> vResult [
	^ vResult
]

{ #category : #accessing }
OBlScrollFlingerState >> vResult: anObject [
	vResult := anObject
]

{ #category : #accessing }
OBlScrollFlingerState >> x [
	^ x
]

{ #category : #accessing }
OBlScrollFlingerState >> x: anObject [
	x := anObject
]

{ #category : #accessing }
OBlScrollFlingerState >> y [
	^ y
]

{ #category : #accessing }
OBlScrollFlingerState >> y: anObject [
	y := anObject
]
