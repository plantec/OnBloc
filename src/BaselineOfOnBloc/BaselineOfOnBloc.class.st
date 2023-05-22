Class {
	#name : #BaselineOfOnBloc,
	#superclass : #BaselineOf,
	#category : #BaselineOfOnBloc
}

{ #category : #baselines }
BaselineOfOnBloc >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Bloc'
			with: [ 
				spec repository: 'github://pharo-graphics/bloc:dev-1.0/src' ]";
			baseline: 'BlocPac'
			with: [ 
				spec repository: 'github://pharo-graphics/bloc-pac:dev-1.0/src' ]".

		spec package: 'OnBloc' with: [ 
			spec repository: 'github://plantec/OnBloc/src'.
			spec requires: #( #Bloc "#BlocPac" ) ].
		spec package: 'OnBloc-Alexandrie'.
		spec package: 'OnBloc-Tests' with: [ 
			spec requires: #( OnBloc ) ] ]
]
