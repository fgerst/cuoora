Class {
	#name : #QuestionTest,
	#superclass : #TestCase,
	#instVars : [
		'q1',
		'q2',
		'a1',
		'a2',
		'u1',
		'u2',
		't1',
		't2'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
QuestionTest >> setUp [	
	super setUp.
	
	"usuarios"
	u1 := User withUsername: 'Franco' password: '123'.
	u2 := User withUsername: 'Tomas' password: '123'.
		
	"topicos"
	t1 := Topic withName: 'Smalltalk' description: 'Lorem ipsum'.
	t2 := Topic withName: 'Python' description: 'Lorem ipsum'.
	
	"preguntas con topicos relacionados"
	q1 := Question withAuthor: u1 title: 'Titulo1' content: 'Sobre Smalltalk y Python' topics: { t1. t2 }.
	q2 := Question withAuthor: u2 title: 'Titulo2' content: 'Sobre Python' topics: { t2 }.

	"respuestas"
	a1 := Answer withAuthor: u1 content: 'contenido1'.
	a2 := Answer withAuthor: u2 content: 'contenido2'.

	"hizo una pregunta cada usuario, q1 tiene dos respuestas"
	u1 newQuestion: q1.
	u2 newQuestion: q2.
	q1 newAnswer: a1.
	q1 newAnswer: a2.
	
	
]

{ #category : #tests }
QuestionTest >> testAddToRelatedTopics [
	"se agregaron las referencias a los topicos correspondientes"

	self assert: (t1 topicQuestions includes: q1).
	self assert: (t2 topicQuestions includes: q1).
	self assert: (t2 topicQuestions includes: q2)
]

{ #category : #tests }
QuestionTest >> testAnswersSortedByScore [
	"sin likes/dislikes"
	self assert: q1 answersSortedByScore first equals: a2.
	
	"si le doy dislike a a2 ya no es primera"
	a2 dislikeFrom: u1.
	self deny: q1 answersSortedByScore first equals: a2.
	"vuelvo a 0"
	a2 dislikeFrom: u1.
	self assert: q1 answersSortedByScore first equals: a2.

	"luego de darle like a a1 se ordena primera"
	a1 likeFrom: u2.
	self assert: q1 answersSortedByScore first equals: a1.

	"al darle dislike a a1 se ordena segunda"
	a1 dislikeFrom: u1.
	self assert: q1 answersSortedByScore first equals: a2
]

{ #category : #tests }
QuestionTest >> testDelete [
	"antes de enviar delete() a las preguntas"
	self assert: ( q1 answersCount ) equals: 2.
	self assert: ( q2 answersCount ) equals: 0.	
	self assert: ( q1 answers includes: a1 ).
	self assert: ( u1 questions size ) equals: 1.
	self assert: ( u2 questions size ) equals: 1.
	self assert: ( u1 answers size ) equals: 1.
	self assert: ( u2 answers size ) equals: 1.
	self assert: (t1 topicQuestions size) equals: 1.
	self assert: (t2 topicQuestions size) equals: 2.
	
	"Question>>delete() elimina la pregunta de los topicos relacionados, y las referencias a las respuestas en el User. Pero
	la referencia a la pregunta en User se elimina desde deleteMyQuestion en User, que es el metodo que llama a este metodo."
	q1 delete.
	q2 delete.
	
	"las respuestas correspondientes ya no existen en la pregunta"
	self assert: ( q1 answersCount ) equals: 0.
	self assert: ( q2 answersCount ) equals: 0.
	
	"las preguntas siguen referenciadas en el User"
	self assert: ( u1 questions size ) equals: 1.
	self assert: ( u2 questions size ) equals: 1.
	
	"las respuestas correspondientes ya no existen en el User"
	self assert: ( u1 answers size ) equals: 0.
	self assert: ( u2 answers size ) equals: 0.
	
	"las referencias a las preguntas en ya no existen en los topicos correspondientes"
	self assert: (t1 topicQuestions size) equals: 0.
	self assert: (t2 topicQuestions size) equals: 0.
]

{ #category : #tests }
QuestionTest >> testNewAnswer [
	"Question>>newAnswer agrega la respuesta a la pregunta, y agrega la referencia al autor de la respuesta"
	
	"referencias a answers en preguntas y usuarios autores correspondientes"
	self assert: ( q1 answers size ) equals: 2.
	self assert: ( q2 answers size ) equals: 0.
	self assert: ( u1 answers size ) equals: 1.
	self assert: ( u2 answers size ) equals: 1.
	
	q1 newAnswer: a1.
	q1 newAnswer: a1.
	q1 newAnswer: a1.
	q2 newAnswer: a2.
	q2 newAnswer: a2.
	
	"referencias actualizadas para preguntas y usuarios"
	self assert: ( q1 answers size ) equals: 5.
	self assert: ( q2 answers size ) equals: 2.
	self assert: ( u1 answers size ) equals: 4.
	self assert: ( u2 answers size ) equals: 3.
]
