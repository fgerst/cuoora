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
Topic >> deleteQuestion [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^nil
]

{ #category : #acccessing }
Topic >> getQuestions [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^topicQuestions 
]

{ #category : #initialization }
Topic >> initialize [
	"comment stating purpose of instance-side message"
	"'name description topicQuestions'"	
			
topicQuestions:= OrderedCollection new.

]
