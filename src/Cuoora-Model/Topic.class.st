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

{ #category : #removing }
Topic >> deleteQuestion: aQuestion [
	^ nil
]

{ #category : #accesing }
Topic >> getQuestions [
	^ topicQuestions
]

{ #category : #initialization }
Topic >> initialize [
	topicQuestions := OrderedCollection new
]
