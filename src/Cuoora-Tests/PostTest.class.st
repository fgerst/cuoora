Class {
	#name : #PostTest,
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
PostTest >> setUp [
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
PostTest >> testDislikeFrom [
	a1 dislikeFrom: u1.
	a1 dislikeFrom: u2.
	self assert: a1 likes size equals: 0.
	self assert: a1 dislikes size equals: 2.
	
	"doble dislike del mismo usuario = quitar dislike"
	a1 dislikeFrom: u1.
	self assert: a1 likes size equals: 0.
	self assert: a1 dislikes size equals: 1
]

{ #category : #tests }
PostTest >> testLikeFrom [
	a1 likeFrom: u1.
	a1 likeFrom: u2.
	self assert: a1 likes size equals: 2.
	self assert: a2 likes size equals: 0.
	self assert: a1 dislikes size equals: 0.
	self assert: a2 dislikes size equals: 0.
	
	"doble like del mismo usuario = quitar like"
	a1 likeFrom: u1.
	self assert: a1 likes size equals: 1.
	self assert: a1 dislikes size equals: 0
]

{ #category : #tests }
PostTest >> testPostScore [

	self assert: a1 postScore equals: 0.
	self assert: a2 postScore equals: 0.
	
	a1 likeFrom: u1.
	a1 likeFrom: u2.
	a2 likeFrom: u1.
	a2 dislikeFrom: u2.
	self assert: a1 postScore equals: 2.
	self assert: a2 postScore equals: 0.
	
	a1 likeFrom: u1.
	a1 likeFrom: u2.
	a2 dislikeFrom: u2.
	self assert: a1 postScore equals: 0.
	self assert: a2 postScore equals: 1.
	
	a1 dislikeFrom: u1.
	a2 dislikeFrom: u1.
	a2 dislikeFrom: u2.
	self assert: a1 postScore equals: -1.
	self assert: a2 postScore equals: -2
]
