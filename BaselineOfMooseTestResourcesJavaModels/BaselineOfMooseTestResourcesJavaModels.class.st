Class {
	#name : 'BaselineOfMooseTestResourcesJavaModels',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMooseTestResourcesJavaModels',
	#package : 'BaselineOfMooseTestResourcesJavaModels'
}

{ #category : 'baselines' }
BaselineOfMooseTestResourcesJavaModels >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'Moose-TestResources-JavaModels' ]
]
