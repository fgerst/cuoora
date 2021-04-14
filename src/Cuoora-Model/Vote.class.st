"
Clase que representa un voto a una publicacion (like o dislike). Los usuarios pueden darle dislike/like a sus propias preguntas/respuestas.
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
	^ self new initializeWithAuthor: anUser yourself
]

{ #category : #accesing }
Vote >> author [
	^ author
]

{ #category : #initialization }
Vote >> initialize [		
	timestamp := DateAndTime now.
]

{ #category : #initialization }
Vote >> initializeWithAuthor: anUser [
	author := anUser
]

{ #category : #accesing }
Vote >> timestamp [
	^ timestamp
]
