Class {
	#name : #OBlInfiniteElementHolderFlags,
	#superclass : #BlBitflags,
	#classVars : [
		'AppearedInPreLayout',
		'BouncedFromHiddenList',
		'Bound',
		'DataSourceFullUpdate',
		'DataSourcePositionUnknown',
		'Ignore',
		'Invalid',
		'Moved',
		'NotRecyclable',
		'PendingAccessibilityStateNotSet',
		'Removed',
		'ReturnedFromScrap',
		'TmpDetached',
		'Update'
	],
	#category : #'OnBloc-Infinite-Flags'
}

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> AppearedInPreLayout [
	"This method was automatically generated"
	^ AppearedInPreLayout value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> BouncedFromHiddenList [
	"This method was automatically generated"
	^ BouncedFromHiddenList value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> Bound [
	"This method was automatically generated"
	^ Bound value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> DataSourceFullUpdate [
	"This method was automatically generated"
	^ DataSourceFullUpdate value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> DataSourcePositionUnknown [
	"This method was automatically generated"
	^ DataSourcePositionUnknown value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> Ignore [
	"This method was automatically generated"
	^ Ignore value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> Invalid [
	"This method was automatically generated"
	^ Invalid value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> Moved [
	"This method was automatically generated"
	^ Moved value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> NotRecyclable [
	"This method was automatically generated"
	^ NotRecyclable value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> PendingAccessibilityStateNotSet [
	"This method was automatically generated"
	^ PendingAccessibilityStateNotSet value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> Removed [
	"This method was automatically generated"
	^ Removed value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> ReturnedFromScrap [
	"This method was automatically generated"
	^ ReturnedFromScrap value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> TmpDetached [
	"This method was automatically generated"
	^ TmpDetached value
]

{ #category : #'accessing - flags' }
OBlInfiniteElementHolderFlags class >> Update [
	"This method was automatically generated"
	^ Update value
]

{ #category : #'flags declaration' }
OBlInfiniteElementHolderFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	^ {
		#BOUND.
		#UPDATE.
		#INVALID.
		#REMOVED.
		#NOT_RECYCLABLE.
		#RETURNED_FROM_SCRAP.
		#IGNORE.
		#TMP_DETACHED.
		#DATA_SOURCE_POSITION_UNKNOWN.
		#DATA_SOURCE_FULL_UPDATE.
		#MOVED.
		#APPEARED_IN_PRE_LAYOUT.
		#BOUNCED_FROM_HIDDEN_LIST.
		#PENDING_ACCESSIBILITY_STATE_NOT_SET -> (-1).
	}
]

{ #category : #initialization }
OBlInfiniteElementHolderFlags class >> initialize [
	super initialize
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addAppearedInPreLayout [
	"This method was automatically generated"
	value := value | AppearedInPreLayout value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addBouncedFromHiddenList [
	"This method was automatically generated"
	value := value | BouncedFromHiddenList value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addBound [
	"This method was automatically generated"
	value := value | Bound value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addDataSourceFullUpdate [
	"This method was automatically generated"
	value := value | DataSourceFullUpdate value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addDataSourcePositionUnknown [
	"This method was automatically generated"
	value := value | DataSourcePositionUnknown value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addIgnore [
	"This method was automatically generated"
	value := value | Ignore value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addInvalid [
	"This method was automatically generated"
	value := value | Invalid value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addMoved [
	"This method was automatically generated"
	value := value | Moved value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addNotRecyclable [
	"This method was automatically generated"
	value := value | NotRecyclable value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addPendingAccessibilityStateNotSet [
	"This method was automatically generated"
	value := value | PendingAccessibilityStateNotSet value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addRemoved [
	"This method was automatically generated"
	value := value | Removed value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addReturnedFromScrap [
	"This method was automatically generated"
	value := value | ReturnedFromScrap value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addTmpDetached [
	"This method was automatically generated"
	value := value | TmpDetached value
]

{ #category : #'flags - add' }
OBlInfiniteElementHolderFlags >> addUpdate [
	"This method was automatically generated"
	value := value | Update value
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearAppearedInPreLayout [
	"This method was automatically generated"
	value := value & (AppearedInPreLayout value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearBouncedFromHiddenList [
	"This method was automatically generated"
	value := value & (BouncedFromHiddenList value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearBound [
	"This method was automatically generated"
	value := value & (Bound value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearDataSourceFullUpdate [
	"This method was automatically generated"
	value := value & (DataSourceFullUpdate value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearDataSourcePositionUnknown [
	"This method was automatically generated"
	value := value & (DataSourcePositionUnknown value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearIgnore [
	"This method was automatically generated"
	value := value & (Ignore value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearInvalid [
	"This method was automatically generated"
	value := value & (Invalid value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearMoved [
	"This method was automatically generated"
	value := value & (Moved value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearNotRecyclable [
	"This method was automatically generated"
	value := value & (NotRecyclable value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearPendingAccessibilityStateNotSet [
	"This method was automatically generated"
	value := value & (PendingAccessibilityStateNotSet value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearRemoved [
	"This method was automatically generated"
	value := value & (Removed value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearReturnedFromScrap [
	"This method was automatically generated"
	value := value & (ReturnedFromScrap value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearTmpDetached [
	"This method was automatically generated"
	value := value & (TmpDetached value bitInvert)
]

{ #category : #'flags - clear' }
OBlInfiniteElementHolderFlags >> clearUpdate [
	"This method was automatically generated"
	value := value & (Update value bitInvert)
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasAppearedInPreLayout [
	"This method was automatically generated"
	^ (value & AppearedInPreLayout value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasBouncedFromHiddenList [
	"This method was automatically generated"
	^ (value & BouncedFromHiddenList value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasBound [
	"This method was automatically generated"
	^ (value & Bound value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasDataSourceFullUpdate [
	"This method was automatically generated"
	^ (value & DataSourceFullUpdate value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasDataSourcePositionUnknown [
	"This method was automatically generated"
	^ (value & DataSourcePositionUnknown value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasIgnore [
	"This method was automatically generated"
	^ (value & Ignore value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasInvalid [
	"This method was automatically generated"
	^ (value & Invalid value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasMoved [
	"This method was automatically generated"
	^ (value & Moved value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasNotRecyclable [
	"This method was automatically generated"
	^ (value & NotRecyclable value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasPendingAccessibilityStateNotSet [
	"This method was automatically generated"
	^ (value & PendingAccessibilityStateNotSet value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasRemoved [
	"This method was automatically generated"
	^ (value & Removed value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasReturnedFromScrap [
	"This method was automatically generated"
	^ (value & ReturnedFromScrap value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasTmpDetached [
	"This method was automatically generated"
	^ (value & TmpDetached value) ~= 0
]

{ #category : #'flags - testing' }
OBlInfiniteElementHolderFlags >> hasUpdate [
	"This method was automatically generated"
	^ (value & Update value) ~= 0
]
