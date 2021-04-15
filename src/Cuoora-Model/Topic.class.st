"
Clase que representa a los topicos
"
Class {
	#name : #Topic,
	#superclass : #Object,
	#instVars : [
		'name',
		'description',
		'topicQuestions'
	],
	#category : #'Cuoora-Model'
}

{ #category : #creation }
Topic class >> withName: aName description: aDesc [
	^ self new initializeWithName: aName description: aDesc yourself
]

{ #category : #'adding/removing' }
Topic >> addTopicQuestion: aQuestion [
	"añade una pregunta a la coleccion de preguntas relacionadas al tópico"

	topicQuestions add: aQuestion.
	^ aQuestion
]

{ #category : #'adding/removing' }
Topic >> deleteTopicQuestion: aQuestion [
	"elimina una pregunta de la coleccion de preguntas relacionadas al tópico"

	topicQuestions remove: aQuestion ifAbsent: [ ^ nil ]
]

{ #category : #accesing }
Topic >> description [
	^ description
]

{ #category : #initialization }
Topic >> initialize [
	topicQuestions := OrderedCollection new
]

{ #category : #initialization }
Topic >> initializeWithName: aName description: aDesc [
	name := aName.
	description := aDesc
]

{ #category : #accesing }
Topic >> name [
	^ name
]

{ #category : #accesing }
Topic >> topicQuestions [
	^ topicQuestions
]
