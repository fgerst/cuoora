"
Clase abstracta que implementa comportamiento para el login de usuarios y eventualmente implementar registro de nuevos usuarios.

Expresión a evaluar para registrar aplicación:

| app |

app := WAAdmin register: LoginComponent asApplicationAt: 'cuoora'.
app sessionClass: UserSession.
"
Class {
	#name : #AccessGrantingComponent,
	#superclass : #WAComponent,
	#instVars : [
		'username',
		'password'
	],
	#category : #'Cuoora-Seaside'
}

{ #category : #utilities }
AccessGrantingComponent >> clearInstance [
	"metodo para borrar datos nuevos creados desde seaside"

	CuooraPlatform clearSoleInstance
]

{ #category : #accessing }
AccessGrantingComponent >> fieldsEmpty [
	^ username isEmptyOrNil | password isEmptyOrNil
]

{ #category : #accessing }
AccessGrantingComponent >> model [
	^ CuooraPlatform soleInstance
]

{ #category : #accessing }
AccessGrantingComponent >> password [
	^ password
]

{ #category : #accessing }
AccessGrantingComponent >> password: aString [
	password := aString
]

{ #category : #control }
AccessGrantingComponent >> proceedWith: anUser [
	self session loginUser: anUser.
	self call: HomeComponent new 
]

{ #category : #rendering }
AccessGrantingComponent >> renderButtonsOn: aCanvas [
	self subclassResponsibility
]

{ #category : #rendering }
AccessGrantingComponent >> renderContentOn: aCanvas [
	aCanvas heading
		id: 'title';
		level1;
		with: [ aCanvas span with: 'CuOOra' ].
	aCanvas horizontalRule.
	aCanvas form
		class: 'login-form';
		with: [ self renderInputElementsOn: aCanvas.
			self renderButtonsOn: aCanvas ].
	aCanvas horizontalRule.
	"testing"
	aCanvas anchor
		callback: [ self clearInstance ];
		with: 'Clear instance'
]

{ #category : #rendering }
AccessGrantingComponent >> renderInputElementsOn: aCanvas [
	aCanvas
		paragraph: [ aCanvas textInput
				placeholder: 'Username';
				on: #username of: self ].
	aCanvas
		paragraph: [ aCanvas passwordInput
				placeholder: 'Password';
				on: #password of: self ]
]

{ #category : #styles }
AccessGrantingComponent >> style [
	^ '
	
body { 
	font-family: sans-serif;
   padding: 8px;
	max-width: 900px;
   margin: auto;
	font-size: 15px;
}

#title { 
	display: inline;
	color: #2ea1ff;
	font-weight: 400;
}

.submit-button { 
	color: white;
	background-color: #1fa3ff;
	border-radius: 8px;
	border: none;
	cursor: pointer;
	padding: 4px 6px 4px 6px;
	margin: 0 0 15px 0;
}

hr { opacity: 0.6; }

.login-form { 
	margin-left: 30px;
	padding: 6px;
}

'
]

{ #category : #accessing }
AccessGrantingComponent >> username [
	^ username
]

{ #category : #accessing }
AccessGrantingComponent >> username: aString [
	username := aString
]
