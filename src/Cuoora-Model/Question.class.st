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
		initializeWithAuthor: anUser
		title: aTitle
		content: aContent
		topics: aTopicList yourself
]

{ #category : #'initialization - actions' }
Question >> addToRelatedTopics [
	"agrega referencias a la pregunta en todos los topicos relacionados a la misma"

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
	"retorna las respuestas ordenadas por su puntaje"

	^ answers asSortedCollection: [ :a :b | a postScore > b postScore ]
]

{ #category : #'adding/removing' }
Question >> delete [
	"elimina todas sus respuestas, y limpia las referencias en los topicos relacionados, es llamado desde User>>deleteMyQuestion()"

	relatedTopics do: [ :topic | topic deleteTopicQuestion: self ].
	answers do: [ :each | each delete ].
	answers := OrderedCollection new
]

{ #category : #initialization }
Question >> initialize [
	super initialize.
	answers := OrderedCollection new
]

{ #category : #initialization }
Question >> initializeWithAuthor: anUser title: aTitle content: aContent topics: aTopicList [
	author := anUser.
	title := aTitle.
	content := aContent.
	relatedTopics := aTopicList
]

{ #category : #'adding/removing' }
Question >> newAnswer: anAnswer [
	"crea una nueva respuesta a la pregunta, agrega la referencia en la pregunta y ene el autor"

	answers add: anAnswer.
	anAnswer addToAuthor.
	^ anAnswer
]

{ #category : #accesing }
Question >> relatedTopics [
	^ relatedTopics
]

{ #category : #accesing }
Question >> title [
	^ title
]
