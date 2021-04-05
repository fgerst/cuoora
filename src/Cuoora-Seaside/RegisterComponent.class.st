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
	"Chequea que se hayan llenado los campos"
	username isNotEmpty & password isNotEmpty
		ifFalse: [ ^ nil ].
	"Chequea con el model que el username no este ya registrado"
	(self model usernameExists: username)
		ifTrue: [ ^ nil ].
	anUser := User withUsername: username password: password.
	self model newUser: anUser.
	self proceedWith: anUser
]

{ #category : #rendering }
RegisterComponent >> renderButtonsOn: aCanvas [
	self renderSignUpButtonOn: aCanvas
]

{ #category : #rendering }
RegisterComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton
		callback: [ self registerAndLogin ];
		with: 'Register'
]
