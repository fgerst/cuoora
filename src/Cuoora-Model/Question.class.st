"
Clase que representa a una pregunta
"
Class {
	#name : #Question,
	#superclass : #Post,
	#instVars : [
		'title',
		'answers',
		'relatedTopics'
	],
	#category : #'Cuoora-Model'
}

{ #category : #creation }
Question class >> withAuthor: anUser title: aTitle content: aContent topics: aTopicList [
	^ self new
		author: anUser;
		title: aTitle;
		content: aContent;
		relatedTopics: aTopicList;
		yourself
]

{ #category : #'initialization - actions' }
Question >> addToRelatedTopics [
	relatedTopics do: [ :each | each addTopicQuestion: self ]
]

{ #category : #accesing }
Question >> answers [
	^ answers
]

{ #category : #accesing }
Question >> answersCount [
	^ answers size
]

{ #category : #listing }
Question >> answersSortedByScore [
	^ answers asSortedCollection: [ :a :b | a postScore > b postScore ]
]

{ #category : #'adding/removing' }
Question >> delete [
	relatedTopics do: [ :topic | topic deleteTopicQuestion: self ].
	answers do: [ :each | each delete ].
	answers := Set new.
]

{ #category : #initialization }
Question >> initialize [
	super initialize.
	answers := Set new
]

{ #category : #'adding/removing' }
Question >> newAnswer: anAnswer [
	answers add: anAnswer.
	anAnswer addToAuthor.
	^ anAnswer
]

{ #category : #accesing }
Question >> relatedTopics [
	^ relatedTopics
]

{ #category : #accesing }
Question >> relatedTopics: aTopicList [
	relatedTopics := aTopicList
]

{ #category : #accesing }
Question >> title [
	^ title
]

{ #category : #accesing }
Question >> title: aString [
	title := aString
]
