"
Clase que representa a una pregunta
"
Class {
	#name : #Question,
	#superclass : #Post,
	#instVars : [
		'title',
		'answers',
		'topics'
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

{ #category : #accesing }
Question >> answersCount [
	^ answers size
]

{ #category : #'adding/removing' }
Question >> delete [
	answers do: [ :each | each delete ].
]

{ #category : #accesing }
Question >> includesTopic: aTopic [ 

^( topics includes: aTopic )
]

{ #category : #initialization }
Question >> initialize [
	super initialize.
	answers := Set new
]

{ #category : #'adding/removing' }
Question >> newAnswer: anAnswer [
	answers add: anAnswer.
	anAnswer author addAnswer: anAnswer.
	^ anAnswer
]

{ #category : #accesing }
Question >> sortedAnswers [
	^ answers asSortedCollection: [ :a :b | a postScore > b postScore ]
]

{ #category : #accesing }
Question >> title [
	^ title
]

{ #category : #accesing }
Question >> title: aString [
	title := aString
]

{ #category : #accesing }
Question >> topics [ 

^topics
]
