Class {
	#name : #AnswerTest,
	#superclass : #TestCase,
	#instVars : [
		'a1',
		'a2',
		'u1',
		'u2',
		'q1'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
AnswerTest >> setUp [
	super setUp.
	
	"usuarios"
	u1 := User withUsername: 'Franco' password: '123'.
	u2 := User withUsername: 'Tomas' password: '123'.
	
	"pregunta"
	q1 := Question withAuthor: u1 title: 'Titulo1' content: 'Lorem ipsum' topics: { }.
	
	"respuestas"
	a1 := Answer withAuthor: u1 content: 'contenido1'.
	a2 := Answer withAuthor: u2 content: 'contenido2'.
	
	"newAnswer() va a agregar referencias a la respuesta en el User autor"
	q1 newAnswer: a1.
	q1 newAnswer: a2.
	


]

{ #category : #tests }
AnswerTest >> testAddToAuthor [
	"Answer>>addToAuthor() es llamado por Question>>newAnswer(), puede corroborarse que la referencia a la respuesta fue agregada al User autor"

	self assert: (u1 answers includes: a1).
	self assert: (u2 answers includes: a2)
]

{ #category : #tests }
AnswerTest >> testDelete [
	"Answer>>delete() solo elimina la referencia en User, ya que la relacion Question->Answer es unidireccional"

	self assert: u1 answers size equals: 1.
	self assert: u2 answers size equals: 1.

	"si llamamos a delete() de Answer, se elimina la referencia en User"
	a1 delete.
	self assert: u1 answers size equals: 0.
	self assert: u2 answers size equals: 1.

	"las referencias en Question sigen estando"
	self assert: q1 answersCount equals: 2.

	"si eliminamos la pregunta, se eliminan referencias a la respuesta tanto desde User como desde Question"
	q1 delete.
	self assert: u1 answers size equals: 0.
	self assert: u2 answers size equals: 0.
	self assert: q1 answersCount equals: 0
]
