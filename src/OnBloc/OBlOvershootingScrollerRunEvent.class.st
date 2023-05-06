"
I am sent by an overshooting scroller when it is run

"
Class {
	#name : #OBlOvershootingScrollerRunEvent,
	#superclass : #BlEvent,
	#instVars : [
		'isFinished'
	],
	#category : #'OnBloc-Scrollable-Helpers'
}

{ #category : #accessing }
OBlOvershootingScrollerRunEvent >> isFinished [
	^ isFinished
]

{ #category : #accessing }
OBlOvershootingScrollerRunEvent >> isFinished: anObject [
	isFinished := anObject
]
