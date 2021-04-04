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
