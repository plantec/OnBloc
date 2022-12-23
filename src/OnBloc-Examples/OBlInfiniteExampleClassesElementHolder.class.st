Class {
	#name : #OBlInfiniteExampleClassesElementHolder,
	#superclass : #OBlInfiniteHolder,
	#instVars : [
		'class'
	],
	#category : #'OnBloc-Examples-infinite-class-list'
}

{ #category : #accessing }
OBlInfiniteExampleClassesElementHolder >> class: aClass [
	| aText |

	class := aClass.
	aText := class name asRopedText fontSize: 13.
	itemElement text: aText
]

{ #category : #initialization }
OBlInfiniteExampleClassesElementHolder >> initialize [
	super initialize.

	itemElement := ToLabel new.
]
