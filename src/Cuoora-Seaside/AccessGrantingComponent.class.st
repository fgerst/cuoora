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

{ #category : #'accessing model' }
AccessGrantingComponent >> model [
 ^ CuooraPlatform soleInstance.
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
	self session user: anUser.
	self call: HomeComponent new 
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
