"
Componente para realizar el Login de User
"
Class {
	#name : #LoginComponent,
	#superclass : #AccessGrantingComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #utilities }
LoginComponent >> clearCache [
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

{ #category : #callbacks }
LoginComponent >> registerNewUser [
	self call: RegisterComponent new
]

{ #category : #rendering }
LoginComponent >> renderButtonsOn: aCanvas [
	self renderSignInButtonOn: aCanvas.
	aCanvas horizontalRule.
	aCanvas paragraph: 'Don''t have an account?'.
	self renderSignUpButtonOn: aCanvas.
	aCanvas horizontalRule.
	aCanvas anchor callback: [self clearCache]; with: 'Clear cache'. 
]

{ #category : #rendering }
LoginComponent >> renderSignInButtonOn: aCanvas [
	aCanvas submitButton
		callback: [ self login ];
		with: 'Sign In'
]

{ #category : #rendering }
LoginComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton
		callback: [ self registerNewUser ];
		with: 'Sign Up'
]
