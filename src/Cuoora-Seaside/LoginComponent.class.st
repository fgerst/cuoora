"
Componente para realizar el Login de User
"
Class {
	#name : #LoginComponent,
	#superclass : #AccessGrantingComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #utilities }
LoginComponent >> clearInstance [
	"metodo para borrar datos nuevos creados desde seaside"

	CuooraPlatform clearSoleInstance
]

{ #category : #callbacks }
LoginComponent >> login [
	self fieldsEmpty
		ifTrue: [ ^ nil ].
	(self model username: username protectedBy: password)
		ifNotNil: [ :it | self proceedWith: it ].
	username := nil.
	password := nil
]

{ #category : #rendering }
LoginComponent >> renderButtonsOn: aCanvas [
	self renderSignInButtonOn: aCanvas.
	aCanvas horizontalRule.
	aCanvas anchor
		callback: [ self clearInstance ];
		with: 'Clear instance'
]

{ #category : #rendering }
LoginComponent >> renderSignInButtonOn: aCanvas [
	aCanvas submitButton
		class: 'submit-button';
		callback: [ self login ];
		with: 'Sign In'
]
