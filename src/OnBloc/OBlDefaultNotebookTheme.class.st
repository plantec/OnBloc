Class {
	#name : #OBlDefaultNotebookTheme,
	#superclass : #OBlTheme,
	#instVars : [
		'deselectedPageTitleBackgroundColor',
		'selectedPageTitleBackgroundColor',
		'backgroundColor'
	],
	#category : #'OnBloc-Theme'
}

{ #category : #accessing }
OBlDefaultNotebookTheme >> backgroundColor [

	^ backgroundColor
]

{ #category : #accessing }
OBlDefaultNotebookTheme >> backgroundColor: aColor [

	backgroundColor := aColor
]

{ #category : #accessing }
OBlDefaultNotebookTheme >> deselectedPageTitleBackgroundColor [

	^ deselectedPageTitleBackgroundColor
]

{ #category : #accessing }
OBlDefaultNotebookTheme >> deselectedPageTitleBackgroundColor: aColor [

	deselectedPageTitleBackgroundColor := aColor
]

{ #category : #initialization }
OBlDefaultNotebookTheme >> initialize [

	super initialize.
	
	selectedPageTitleBackgroundColor := OBlDefaultColors textHighlightColor.
	deselectedPageTitleBackgroundColor := OBlDefaultColors defaultButtonBackgroundColor.
	backgroundColor := OBlDefaultColors neutralBackgroundColor
]

{ #category : #accessing }
OBlDefaultNotebookTheme >> selectedPageTitleBackgroundColor [

	^ selectedPageTitleBackgroundColor
]

{ #category : #accessing }
OBlDefaultNotebookTheme >> selectedPageTitleBackgroundColor: aColor [

	selectedPageTitleBackgroundColor := aColor
]
