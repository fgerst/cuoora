"
Clase abstracta que implementa comportamiento para Login y Register.
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
AccessGrantingComponent >> password [
	^ password
]

{ #category : #accesing }
AccessGrantingComponent >> password: aString [
	password := aString
]

{ #category : #rendering }
AccessGrantingComponent >> renderButtonsOn: aCanvas [
	self subclassResponsibility
]

{ #category : #rendering }
AccessGrantingComponent >> renderContentOn: aCanvas [
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

{ #category : #accesing }
AccessGrantingComponent >> username [
	^ username
]

{ #category : #accesing }
AccessGrantingComponent >> username: aString [
	username := aString
]
