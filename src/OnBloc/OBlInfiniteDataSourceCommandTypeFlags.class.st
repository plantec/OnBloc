Class {
	#name : #OBlInfiniteDataSourceCommandTypeFlags,
	#superclass : #BlBitflags,
	#classVars : [
		'Add',
		'Move',
		'Remove',
		'Update'
	],
	#category : #'OnBloc-Infinite-Flags'
}

{ #category : #'accessing - flags' }
OBlInfiniteDataSourceCommandTypeFlags class >> Add [
	"This method was automatically generated"
	^ Add value
]

{ #category : #'accessing - flags' }
OBlInfiniteDataSourceCommandTypeFlags class >> Move [
	"This method was automatically generated"
	^ Move value
]

{ #category : #'accessing - flags' }
OBlInfiniteDataSourceCommandTypeFlags class >> Remove [
	"This method was automatically generated"
	^ Remove value
]

{ #category : #'accessing - flags' }
OBlInfiniteDataSourceCommandTypeFlags class >> Update [
	"This method was automatically generated"
	^ Update value
]

{ #category : #'flags declaration' }
OBlInfiniteDataSourceCommandTypeFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	^ {
		#ADD.
		#REMOVE.
		#UPDATE.	
		#MOVE.
	}
]

{ #category : #initialization }
OBlInfiniteDataSourceCommandTypeFlags class >> initialize [
	super initialize
]

{ #category : #'flags - add' }
OBlInfiniteDataSourceCommandTypeFlags >> addAdd [
	"This method was automatically generated"
	value := value | Add value
]

{ #category : #'flags - add' }
OBlInfiniteDataSourceCommandTypeFlags >> addMove [
	"This method was automatically generated"
	value := value | Move value
]

{ #category : #'flags - add' }
OBlInfiniteDataSourceCommandTypeFlags >> addRemove [
	"This method was automatically generated"
	value := value | Remove value
]

{ #category : #'flags - add' }
OBlInfiniteDataSourceCommandTypeFlags >> addUpdate [
	"This method was automatically generated"
	value := value | Update value
]

{ #category : #'flags - clear' }
OBlInfiniteDataSourceCommandTypeFlags >> clearAdd [
	"This method was automatically generated"
	value := value & (Add value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteDataSourceCommandTypeFlags >> clearMove [
	"This method was automatically generated"
	value := value & (Move value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteDataSourceCommandTypeFlags >> clearRemove [
	"This method was automatically generated"
	value := value & (Remove value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteDataSourceCommandTypeFlags >> clearUpdate [
	"This method was automatically generated"
	value := value & (Update value bitInvert)
]

{ #category : #'flags - testing' }
OBlInfiniteDataSourceCommandTypeFlags >> hasAdd [
	"This method was automatically generated"
	^ (value & Add value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteDataSourceCommandTypeFlags >> hasMove [
	"This method was automatically generated"
	^ (value & Move value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteDataSourceCommandTypeFlags >> hasRemove [
	"This method was automatically generated"
	^ (value & Remove value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteDataSourceCommandTypeFlags >> hasUpdate [
	"This method was automatically generated"
	^ (value & Update value) ~= 0
]
