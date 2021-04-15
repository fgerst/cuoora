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
	"agrega la referencia a la respuesta al autor de la misma"

	author addAnswer: self
]

{ #category : #removing }
Answer >> delete [
	"elimina la referencia a la respuesta en el User, es llamado desde Question"

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
