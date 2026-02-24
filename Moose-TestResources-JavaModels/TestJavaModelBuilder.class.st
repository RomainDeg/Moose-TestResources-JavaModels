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

	libraryModel := (FamixJavaFoldersImporter importFolders: { TestJavaModelBridge sources / 'library_project' }) anyOne.
	libraryModel name: 'library_model'.
	^ libraryModel 
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> loadLibraryModelClone [ 

	libraryModelClone := (FamixJavaFoldersImporter importFolders: { TestJavaModelBridge sources / 'library_project' }) anyOne.
	libraryModelClone name: 'library_model_clone'.
	^ libraryModelClone 
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> loadMainModel [

	| importer |
	self generateLibraryJAR.
	importer := FamixJavaFoldersImporter new
		            autoClasspath:
			            (TestJavaModelBridge sources / 'library_project' / 'target');
		            folders:
			            { (TestJavaModelBridge sources / 'main_project') };
		            yourself.
	mainModel := importer import anyOne.
	mainModel name: 'main_model'.
	^ mainModel
]

{ #category : 'accessing' }
TestJavaModelBuilder class >> mainModel [

	^ mainModel ifNil: [ self loadMainModel ]
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
