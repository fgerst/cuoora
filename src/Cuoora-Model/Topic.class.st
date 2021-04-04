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

{ #category : #'adding/removing' }
Topic >> addTopicQuestion: aQuestion [
	topicQuestions add: aQuestion
]

{ #category : #'adding/removing' }
Topic >> deleteTopicQuestion: aQuestion [
	"podes agregar ifAbsent si es necesario"
	topicQuestions remove: aQuestion ifAbsent: [ ^nil ].
	^nil
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
	topicQuestions := OrderedCollection new
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
Topic >> sortedTopicQuestions [
	^ ( topicQuestions sort: [ :a :b | ( a postScore ) < ( b postScore ) ] )
]

{ #category : #accesing }
Topic >> topicQuestions [
	^ topicQuestions
]
