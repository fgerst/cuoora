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
	^ self new
		name: aName;
		description: aDesc;
		yourself
]

{ #category : #adding }
Topic >> addTopicQuestion: aQuestion [ 

topicQuestions add: aQuestion 


]

{ #category : #adding }
Topic >> addTopicQuestions: aQuestion [ 

topicQuestions add: aQuestion 


]

{ #category : #adding }
Topic >> deleteTopicQuestion: aQuestion [ 

topicQuestions remove: aQuestion ifAbsent: [ ^nil ]
]

{ #category : #accesing }
Topic >> description [
	^ description
]

{ #category : #accesing }
Topic >> description: aString [
	description := aString
]

{ #category : #initialization }
Topic >> initialize [
	
topicQuestions := Set new.
]

{ #category : #accesing }
Topic >> name [
	^ name
]

{ #category : #accesing }
Topic >> name: aString [
	name := aString
]

{ #category : #accesing }
Topic >> topicQuestions [

^topicQuestions 
]
