Trait {
	#name : #TOBlScrollable,
	#category : #'OnBloc-Scrollable-Core'
}

{ #category : #'api - scrolling overscroll' }
TOBlScrollable >> absorbGlows: aVelocityPoint [
]

{ #category : #'api - scrolling overscroll' }
TOBlScrollable >> awakenScrollBars [
	"Trigger the scrollbars to draw. When invoked this method starts an animation to fade the scrollbars out after a default delay.
	If scrolling is animated, the start delay should equal the duration of the scrolling animation
	Return true if the animation is played, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - scrolling testing' }
TOBlScrollable >> canScrollHorizontally [
	"Return true if I can scroll the current contents horizontally, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - scrolling testing' }
TOBlScrollable >> canScrollVertically [
	"Return true if I can scroll the current contents vertically, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - scrolling thumb' }
TOBlScrollable >> computeHorizontalScrollExtent [
	"Compute the horizontal extent of the horizontal scrollbar's thumb within the horizontal range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollRange and #computeHorizontalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	^ 0
]

{ #category : #'api - scrolling thumb' }
TOBlScrollable >> computeHorizontalScrollOffset [
	"Compute the horizontal offset of the horizontal scrollbar's thumb within the horizontal range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollRange.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	^ 0
]

{ #category : #'api - scrolling thumb' }
TOBlScrollable >> computeHorizontalScrollRange [
	"Compute the horizontal range that the horizontal scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	^ 0
]

{ #category : #'api - scrolling thumb' }
TOBlScrollable >> computeVerticalScrollExtent [
	"Compute the vertical extent of the vertical scrollbar's thumb within the vertical range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollRange and #computeVerticalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	^ 0
]

{ #category : #'api - scrolling thumb' }
TOBlScrollable >> computeVerticalScrollOffset [
	"Compute the vertical offset of the vertical scrollbar's thumb within the vertical range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollExtent and #computeVerticalScrollRange.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	^ 0
]

{ #category : #'api - scrolling thumb' }
TOBlScrollable >> computeVerticalScrollRange [
	"Compute the vertical range that the vertical scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollExtent and #computeVerticalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	^ 0
]

{ #category : #'api - scrolling overscroll' }
TOBlScrollable >> considerReleasingGlowsOnScroll: aDeltaPoint [
]

{ #category : #'api - scrolling notifying' }
TOBlScrollable >> dispatchOnScrolled: aPoint [
	
	self onScrolled: aPoint.
	self notifyScrolled: aPoint
]

{ #category : #'api - scrolling notifying' }
TOBlScrollable >> notifyScrolled: aPoint [
	"Notify all event handlers that InfiniteElemnet scrolled by a delta point"

	self eventDispatcher dispatchScrolled: aPoint
]

{ #category : #'hooks - scrolling' }
TOBlScrollable >> onScrolled: aPoint [
	"Sent when the scroll position of this InfiniteElement changes. Subclasses should use
	this method to respond to scrolling within the datasource's data set instead of an explicit event handler.
	I will always be invoked before event handlers. If a subclass needs to perform any additional upkeep
	or bookkeeping after scrolling but before events fired, this is a good place to do so"
]

{ #category : #'api - scrolling accessing' }
TOBlScrollable >> overScrollMode [
	^ OBlOverScrollMode never
]

{ #category : #'api - scrolling accessing' }
TOBlScrollable >> overScrollMode: aOBlOverScrollMode [
	self explicitRequirement
]

{ #category : #'api - scrolling accessing' }
TOBlScrollable >> scrollFlinger [
	<return: #OBlScrollFlinger>

	^ self explicitRequirement
]

{ #category : #'api - scrolling' }
TOBlScrollable >> scrollHorizontallyBy: aNumber [
	"Scroll horizontally by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>

	^ 0
]

{ #category : #'api - scrolling geometry' }
TOBlScrollable >> scrollMaximum [
	<return: #Point>
	
	^ Float infinity @ Float infinity
]

{ #category : #'api - scrolling geometry' }
TOBlScrollable >> scrollMinimum [
	<return: #Point>
	
	^ Float negativeInfinity @ Float negativeInfinity
]

{ #category : #'api - scrolling geometry' }
TOBlScrollable >> scrollOvershot [
	<return: #Point>
	
	^ 0@0
]

{ #category : #'api - scrolling geometry' }
TOBlScrollable >> scrollPosition [
	<return: #Point>
	
	^ self explicitRequirement
]

{ #category : #'private - scrolling accessing' }
TOBlScrollable >> scrollState [
	"Return the current scrolling state"
	<return: #Symbol>
	
	^ self explicitRequirement
]

{ #category : #'private - scrolling accessing' }
TOBlScrollable >> scrollState: aScrollState [
	"Internal! Never set me directly"
	
	self explicitRequirement
]

{ #category : #'api - scrolling' }
TOBlScrollable >> scrollVerticallyBy: aNumber [
	"Scroll vertically by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>

	^ 0
]

{ #category : #'api - scrolling accessing' }
TOBlScrollable >> smoothScroller [
	"Return currently used smooth scroller or nil if I am not in a smooth scrolling state"
	<return: #OBlSmoothScroller or: nil>

	^ nil
]
