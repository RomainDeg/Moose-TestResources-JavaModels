Class {
	#name : 'BaselineOfMooseTestResourcesJavaModels',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMooseTestResourcesJavaModels',
	#package : 'BaselineOfMooseTestResourcesJavaModels'
}

{ #category : 'baselines' }
BaselineOfMooseTestResourcesJavaModels >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Dependencies"
			self gitBridge: spec.

			spec
				package: 'Moose-TestResources-JavaModels' with: [ spec requires: #( 'GitBridge' ) ] ]
]

{ #category : 'baselines' }
BaselineOfMooseTestResourcesJavaModels >> gitBridge: spec [

  spec baseline: 'GitBridge' with: [ spec repository: 'github://jecisc/GitBridge:v1.x.x/src' ]
]
