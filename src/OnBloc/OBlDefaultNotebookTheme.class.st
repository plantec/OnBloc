Class {
	#name : #OBlDefaultNotebookTheme,
	#superclass : #OBlTheme,
	#instVars : [
		'deselectedPageTitleBackgroundColor',
		'headerBackgroundColor',
		'selectedPageTitleBackgroundColor'
	],
	#category : #'OnBloc-Theme'
}

{ #category : #accessing }
OBlDefaultNotebookTheme >> backgroundColor [

	^ headerBackgroundColor
]

{ #category : #accessing }
OBlDefaultNotebookTheme >> deselectedPageTitleBackgroundColor [

	^ deselectedPageTitleBackgroundColor
]

{ #category : #accessing }
OBlDefaultNotebookTheme >> deselectedPageTitleBackgroundColor: aColor [

	deselectedPageTitleBackgroundColor := aColor
]

{ #category : #accessing }
OBlDefaultNotebookTheme >> headerBackgroundColor: aColor [

	headerBackgroundColor := aColor
]

{ #category : #initialization }
OBlDefaultNotebookTheme >> initialize [

	super initialize.
	
	selectedPageTitleBackgroundColor := OBlDefaultColors pressedButtonBackgroundColor.
	deselectedPageTitleBackgroundColor := OBlDefaultColors defaultButtonBackgroundColor.
	headerBackgroundColor := OBlDefaultColors neutralBackgroundColor
]

{ #category : #accessing }
OBlDefaultNotebookTheme >> selectedPageTitleBackgroundColor [

	^ selectedPageTitleBackgroundColor
]

{ #category : #accessing }
OBlDefaultNotebookTheme >> selectedPageTitleBackgroundColor: aColor [

	selectedPageTitleBackgroundColor := aColor
]
