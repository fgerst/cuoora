"
Componente para registrar nuevo User
"
Class {
	#name : #RegisterComponent,
	#superclass : #AccessGrantingComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #callbacks }
RegisterComponent >> registerAndLogin [
	| anUser |
	"chequea campos vacios o usuario ya existente"
	self fieldsEmpty | (self model usernameExists: username)
		ifTrue: [ ^ nil ].
	anUser := User withUsername: username password: password.
	self model newUser: anUser.
	self proceedWith: anUser
]

{ #category : #rendering }
RegisterComponent >> renderBackButtonOn: aCanvas [
	aCanvas button
		callback: [ self answer ];
		with: 'Back'
]

{ #category : #rendering }
RegisterComponent >> renderButtonsOn: aCanvas [
	self renderSignUpButtonOn: aCanvas.
	aCanvas space.
	self renderBackButtonOn: aCanvas
]

{ #category : #rendering }
RegisterComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton
		callback: [ self registerAndLogin ];
		with: 'Register'
]
