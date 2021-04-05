"
Clase abstracta que implementa comportamiento para el login de usuarios y eventualmente implementar registro de nuevos usuarios.
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

{ #category : #accesing }
AccessGrantingComponent >> fieldsEmpty [
	^ username isEmpty | password isEmpty
]

{ #category : #accesing }
AccessGrantingComponent >> model [
	^ CuooraPlatform soleInstance
]

{ #category : #accesing }
AccessGrantingComponent >> password [
	^ password
]

{ #category : #accesing }
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
	aCanvas
		form: [ self renderInputElementsOn: aCanvas.
			self renderButtonsOn: aCanvas ]
]

{ #category : #rendering }
AccessGrantingComponent >> renderInputElementsOn: aCanvas [
	aCanvas label: 'Username'.
	aCanvas paragraph: [ aCanvas textInput on: #username of: self ].
	aCanvas label: 'Password'.
	aCanvas paragraph: [ aCanvas passwordInput on: #password of: self ]
]

{ #category : #styles }
AccessGrantingComponent >> style [
	^ '
	
body { 
	font-family: sans-serif;
   padding: 8px;
	max-width: 920px;
   margin: auto; 
}

#title { 
	display: inline;
	color: #1fa3ff;
	font-weight: 400;
}

hr { opacity: 0.6; }

'
]

{ #category : #accesing }
AccessGrantingComponent >> username [
	^ username
]

{ #category : #accesing }
AccessGrantingComponent >> username: aString [
	username := aString
]
