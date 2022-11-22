Extension { #name : #BlHost }

{ #category : #'*OnBloc' }
BlHost >> oblWorld [

	^ self universe spaces
		  detect: [ :sp | sp title = self oblWorldTitle ]
		  ifNone: [ | w |
			  w := OBlSpace new
				  host: self;
				  title: self oblWorldTitle;
				  yourself.
				self universe attachSpace: w.
				w ]
]

{ #category : #'*OnBloc' }
BlHost >> oblWorldTitle [

	^ 'OnBloc World' 
]
