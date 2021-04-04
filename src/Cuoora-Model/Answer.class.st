"
Clase que representa a una respuesta
"
Class {
	#name : #Answer,
	#superclass : #Post,
	#category : #'Cuoora-Model'
}

{ #category : #creation }
Answer class >> withAuthor: anUser content: aContent [
	^ self new
		author: anUser;
		content: aContent;
		yourself
]

{ #category : #removing }
Answer >> delete [
	author deleteMyAnswer: self
]

{ #category : #initialization }
Answer >> initialize [
	super initialize
]
