"
Componente para realizar el Login de User. Es el punto de entrada a la aplicación Seaside.

Expresión a evaluar para registrar aplicación:

""
| app |
app := WAAdmin register: LoginComponent asApplicationAt: 'cuoora'.
app sessionClass: UserSession.
""
"
Class {
	#name : #LoginComponent,
	#superclass : #AccessGrantingComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #callbacks }
LoginComponent >> login [
	"chequea que no haya campos vacios"
	self fieldsEmpty
		ifTrue: [ ^ nil ].
	"chequea las credenciales contra el modelo"
	(self model username: username protectedBy: password)
		ifNotNil: [ :it | self proceedWith: it ].
	username := nil.
	password := nil
]

{ #category : #rendering }
LoginComponent >> renderButtonsOn: aCanvas [
	self renderSignInButtonOn: aCanvas.
]

{ #category : #rendering }
LoginComponent >> renderSignInButtonOn: aCanvas [
	aCanvas submitButton
		class: 'submit-button';
		callback: [ self login ];
		with: 'Sign In'
]
