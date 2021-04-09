Class {
	#name : #QuestionTest,
	#superclass : #TestCase,
	#instVars : [
		'aQuestion1',
		'aQuestion2',
		'a1',
		'a2',
		'u1',
		'u2'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
QuestionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	super setUp.
	u1 := User withUsername: 'name1' password: 'word1'.
	u2 := User withUsername: 'name2' password: 'word2'.
	aQuestion1 := Question withAuthor: u1 title: 'titulo1' content: 'contenido1' topics: { }.
	aQuestion2 := Question withAuthor: u2 title: 'titulo2' content: 'contenido2' topics: { }.
	a1 := Answer withAuthor: u1 content: 'contenido1'.
	a2 := Answer withAuthor: u2 content: 'contenido2'.
	u1 newQuestion: aQuestion1.
	u2 newQuestion: aQuestion2.
	u1 addAnswer: a1.
	u2 addAnswer: a2.
	
	
]

{ #category : #tests }
QuestionTest >> testDelete [
	"Este Delete solo elimina las preguntas correspondientes, el que elimina las preguntas es el metodo del usuario que luego llama a este"
			
	aQuestion1 newAnswer: a1.
	aQuestion2 newAnswer: a2.
	
	self assert: ( u1 questions size ) equals: 1.
	self assert: ( u2 questions size ) equals: 1.
	self assert: ( u1 answers size ) equals: 1.
	self assert: ( u2 answers size ) equals: 1.
	
	aQuestion1 delete.
	aQuestion2 delete.
	
	self assert: ( u1 questions size ) equals: 1.
	self assert: ( u2 questions size ) equals: 1.
	self assert: ( u1 answers size ) equals: 0.
	self assert: ( u2 answers size ) equals: 0.
	
]

{ #category : #tests }
QuestionTest >> testNewAnswer [
			
	self assert: ( aQuestion1 answers size ) equals: 0.
	self assert: ( aQuestion2 answers size ) equals: 0.
			
	aQuestion1 newAnswer: a1.
	aQuestion1 newAnswer: a1.
	aQuestion1 newAnswer: a1.
	aQuestion2 newAnswer: a1.
	aQuestion2 newAnswer: a2.
	self assert: ( aQuestion1 answers size ) equals: 1.
	self assert: ( aQuestion2 answers size ) equals: 2.
]

{ #category : #tests }
QuestionTest >> testSortedAnswers [
	self assert: ( aQuestion1 sortedAnswers size ) equals: 0.
	self assert: ( aQuestion2 sortedAnswers size ) equals: 0.

	a1 likeFrom: u1.
	a1 likeFrom: u2.
	a2 likeFrom: u1.

	aQuestion1 newAnswer: a1.
	aQuestion1 newAnswer: a2.
	aQuestion2 newAnswer: a2.
	self assert: ( aQuestion1 sortedAnswers size ) equals: 2.
	self assert: ( aQuestion2 sortedAnswers size ) equals: 1.
	aQuestion2 newAnswer: a1.
	self assert: ( aQuestion2 sortedAnswers at: 1 ) equals: ( aQuestion1 sortedAnswers at: 1 ).
	self assert: ( aQuestion2 sortedAnswers at: 2 ) equals: ( aQuestion1 sortedAnswers at: 2 ).

	self assert: ( aQuestion1 sortedAnswers at: 1 ) equals: (a1).
	self assert: ( aQuestion1 sortedAnswers at: 2 ) equals: (a2).

	a1 likeFrom: u1.
	a1 likeFrom: u2.
	a2 likeFrom: u2.

	self assert: ( aQuestion1 sortedAnswers at: 1 ) equals: (a2).
	self assert: ( aQuestion1 sortedAnswers at: 2 ) equals: (a1).
]
