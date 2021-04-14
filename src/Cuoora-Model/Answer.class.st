"
Clase que representa una respuesta a una pregunta. Los usuarios pueden responder sus propias preguntas.
"
Class {
	#name : #Answer,
	#superclass : #Post,
	#category : #'Cuoora-Model'
}

{ #category : #creation }
Answer class >> withAuthor: anUser content: aContent [
	^ self new initializeWithAuthor: anUser content: aContent yourself
]

{ #category : #'initialization-actions' }
Answer >> addToAuthor [
	author addAnswer: self
]

{ #category : #removing }
Answer >> delete [
	author deleteMyAnswer: self
]

{ #category : #initialization }
Answer >> initialize [
	super initialize
]

{ #category : #initialization }
Answer >> initializeWithAuthor: anUser content: aContent [
	author := anUser.
	content := aContent
]
