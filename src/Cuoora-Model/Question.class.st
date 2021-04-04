"
Clase que representa a una pregunta
"
Class {
	#name : #Question,
	#superclass : #Post,
	#instVars : [
		'title',
		'answers'
	],
	#category : #'Cuoora-Model'
}

{ #category : #creation }
Question class >> withAuthor: anUser title: aTitle content: aContent [
	^ self new
		author: anUser;
		title: aTitle;
		content: aContent;
		yourself
]

{ #category : #accesing }
Question >> answers [
	^ answers
]

{ #category : #'adding/removing' }
Question >> delete [
	"TODO le va a pedir amablemente a sus respuestas que se eliminen"
	
	answers do: [ :each | each delete ].
]

{ #category : #initialization }
Question >> initialize [
	answers := OrderedCollection new.
	super initialize
]

{ #category : #'adding/removing' }
Question >> newAnswer: anAnswer [
	answers add: anAnswer.
	anAnswer author addAnswer: anAnswer.
	^ anAnswer
]

{ #category : #accesing }
Question >> sortedAnswers [
	^ answers asSortedCollection: [ :a :b | a postScore < b postScore ]
]

{ #category : #accesing }
Question >> title [
	^ title
]

{ #category : #accesing }
Question >> title: aString [
	title := aString
]
