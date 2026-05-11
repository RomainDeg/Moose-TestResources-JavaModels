Class {
	#name : 'TestJavaModelBuilder',
	#superclass : 'Object',
	#classInstVars : [
		'mainModel',
		'libraryModel',
		'libraryModelClone'
	],
	#category : 'Moose-TestResources-JavaModels',
	#package : 'Moose-TestResources-JavaModels'
}

{ #category : 'accessing' }
TestJavaModelBuilder class >> generateAndLoadSimpleModelAt: sourceFolder named: aString [
	"Simple model == a model without classpath needed for JDT to have accurate bindings"

	(self pathToModelForSourceAt: sourceFolder) ifExists: [
		^ self loadModelAt: sourceFolder withName: aString ].

	self generateDependencyFreeJsonOf: sourceFolder.

	^ self loadModelAt: sourceFolder withName: aString
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> generateDependencyFreeJsonOf: sourceFolder [

	| importer |
	importer := FamixJavaFoldersImporter new
		            folders: { sourceFolder };
		            yourself.

	importer ensureVerveineJ.
	importer generateJsonOfProjects
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> generateLibraryJAR [

	LibC runCommand: ('mvn package -f {1}' format:
			 { (TestJavaModelBridge sources / 'library_project') pathString
				 asComment })
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> libraryModel [

	^ libraryModel ifNil: [ self loadLibraryModel ]
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> libraryModelClone [

	^ libraryModelClone ifNil: [ self loadLibraryModelClone ]
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> loadLibraryModel [

	| sourceFolder |
	sourceFolder := TestJavaModelBridge sources / 'library_project'.

	^ self
		  generateAndLoadSimpleModelAt: sourceFolder
		  named: 'library_model'
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> loadLibraryModelClone [

	| sourceFolder |
	sourceFolder := TestJavaModelBridge sources / 'library_project'.

	^ self
		  generateAndLoadSimpleModelAt: sourceFolder
		  named: 'library_model_clone'
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> loadMainModel [

	| importer sourceFolder |
	sourceFolder := (TestJavaModelBridge sources / 'main_project').
	
	(self pathToModelForSourceAt: sourceFolder) ifExists: [
		^ self loadModelAt: sourceFolder withName: 'main_model' ].
	
	self generateLibraryJAR.

	importer := FamixJavaFoldersImporter new
		            autoClasspath:
			            TestJavaModelBridge sources / 'library_project'
			            / 'target';
		            folders:
			            { sourceFolder };
		            yourself.

	importer ensureVerveineJ.
	importer generateJsonOfProjects.

	^ self loadModelAt: sourceFolder withName: 'main_model'
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> loadModelAt: sourceFolder withName: aString [

	| model |
	model := (self pathToModelForSourceAt: sourceFolder) readStreamDo: [ :st |
		FamixJavaModel new importFromJSONStream: st ].
	
	model name: aString.
	^ model
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> mainModel [

	^ mainModel ifNil: [ self loadMainModel ]
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> pathToModelForSourceAt: sourceFolder [

	| importer |
	importer := FamixJavaFoldersImporter new
		            folders: { sourceFolder };
		            yourself.
	^ (importer jsonForFolder: importer folders anyOne) asFileReference
]

{ #category : 'as yet unclassified' }
TestJavaModelBuilder class >> reloadModels [
	"setting models to nil means that accessing them will be loading them again, and only the ones we do access"

	mainModel := nil.
	libraryModel := nil.
	libraryModelClone := nil
]

{ #category : 'accessing' }
TestJavaModelBuilder >> interfaceImplementorInLibraryProject [

	^ self libraryModel entityNamed:
		  'library.blabla.LibraryInterfaceUser'
]

{ #category : 'accessing' }
TestJavaModelBuilder >> interfaceImplementorInMainProject [

	^ self mainModel entityNamed:
		  'some.thing.whatever.MainClass'
]

{ #category : 'accessing' }
TestJavaModelBuilder >> interfaceInLibraryProject [

	^ self libraryModel entityNamed:
		  'library.blabla.LibraryInterface'
]

{ #category : 'accessing' }
TestJavaModelBuilder >> libraryModel [

	^ self class libraryModel
]

{ #category : 'accessing' }
TestJavaModelBuilder >> libraryModelClone [

	^ self class libraryModelClone
]

{ #category : 'accessing' }
TestJavaModelBuilder >> mainClassInMainProject [

	^ self mainModel entityNamed:
		  'some.thing.whatever.MainClass'
]

{ #category : 'accessing' }
TestJavaModelBuilder >> mainModel [

	^ self class mainModel
]

{ #category : 'accessing' }
TestJavaModelBuilder >> resourceMethodInLibraryCloneProject [

	^ self libraryModelClone entityNamed:
		  'library.blabla.LibraryClass.doSomethingElse(String)'
]

{ #category : 'accessing' }
TestJavaModelBuilder >> resourceMethodInLibraryProject [

	^ self libraryModel entityNamed:
		  'library.blabla.LibraryClass.doSomethingElse(String)'
]

{ #category : 'accessing' }
TestJavaModelBuilder >> stubMethodInMainProject [

	^ self mainModel entityNamed:
		  'library.blabla.LibraryClass.doSomethingElse(String)'
]

{ #category : 'accessing' }
TestJavaModelBuilder >> stubSuperclassInMainProject [

	^ self mainModel entityNamed:
		  'library.blabla.LibrarySuperclass'
]

{ #category : 'accessing' }
TestJavaModelBuilder >> superclassInLibraryProject [

	^ self libraryModel entityNamed:
		  'library.blabla.LibrarySuperclass'
]
