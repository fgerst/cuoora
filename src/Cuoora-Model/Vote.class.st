"
Clase que representa un voto a una publicacion (like o dislike)
"
Class {
	#name : #Vote,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'author'
	],
	#category : #'Cuoora-Model'
}

{ #category : #creation }
Vote class >> withAuthor: anUser [
	^ self new
		author: anUser;
		yourself
]

{ #category : #accesing }
Vote >> author [
	^ author
]

{ #category : #accesing }
Vote >> author: anUser [
	author := anUser
]

{ #category : #initialization }
Vote >> initialize [		
	timestamp := DateAndTime now.
]

{ #category : #accesing }
Vote >> timestamp [
	^ timestamp
]
