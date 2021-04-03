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
Topic >> deleteTopicQuestion: aQuestion [
	topicQuestions remove: aQuestion.
]

{ #category : #initialization }
Topic >> initialize [
	topicQuestions := OrderedCollection new
]

{ #category : #accesing }
Topic >> topicQuestions [
	^ topicQuestions
]
