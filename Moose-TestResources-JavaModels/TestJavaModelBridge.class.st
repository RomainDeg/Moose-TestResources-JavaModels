Class {
	#name : 'TestJavaModelBridge',
	#superclass : 'GitBridge',
	#category : 'Moose-TestResources-JavaModels',
	#package : 'Moose-TestResources-JavaModels'
}

{ #category : 'accessing' }
TestJavaModelBridge class >> sources [

	^ self root / 'Model-Sources'
]
