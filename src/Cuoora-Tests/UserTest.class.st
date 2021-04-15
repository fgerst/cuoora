Class {
	#name : #UserTest,
	#superclass : #TestCase,
	#instVars : [
		'anUser1',
		'anUser2',
		'anUser3',
		'q1',
		'q2',
		'a1',
		'a2',
		'i1',
		'i2'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
UserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	anUser1 := User withUsername: 'name1' password: 'word1'.
	anUser2 := User withUsername: 'name2' password: 'word2'.
	anUser3 := User withUsername: 'name3' password: 'word3'.
	q1 := Question withAuthor: anUser1 title: 'Question 1' content: 'content 1' topics: { }.
	q2 := Question withAuthor: anUser2 title: 'Question 2' content: 'content 2' topics: { }.
	a1 := Answer withAuthor: anUser1 content: 'content 1'.
	a2 := Answer withAuthor: anUser3 content: 'content 3'.
	q1 newAnswer: a1. q2 newAnswer: a2.
	anUser1 newQuestion: q1. anUser2 newQuestion: q2.
	anUser2 addAnswer: a1. anUser2 addAnswer: a2.
	i1 := Topic withName: 'Python' description: 'contenido Python'.
	i2 := Topic withName: 'C' description: 'contenido C'
	
	
	
	
]

{ #category : #tests }
UserTest >> testAdd [
	anUser1 addInterest: i1.
	anUser1 addInterest: i2.
	anUser1 addInterest: i2.
	anUser2 addInterest: i1.
	self assert: anUser1 interests size equals: 3.
	self assert: anUser2 interests size equals: 1.
	self assert: anUser3 interests size equals: 0.
	self assert: anUser1 questions size equals: 1.
	self assert: anUser2 questions size equals: 1.
	self assert: anUser3 questions size equals: 0.
	self assert: anUser1 answers size equals: 1.
	self assert: anUser2 answers size equals: 2.
	self assert: anUser3 answers size equals: 1.
	anUser1 addFollowing: anUser2.
	anUser1 addFollowing: anUser3.
	anUser2 addFollowing: anUser3.
	self assert: anUser1 following size equals: 2.
	self assert: anUser2 following size equals: 1.
	self assert: anUser3 following size equals: 0
]

{ #category : #tests }
UserTest >> testDeleteAnswer [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	self assert: ( anUser1 answers includes: a1 ).
	anUser1 deleteMyAnswer: a1.
	self assert: (( anUser1 answers includes: a1 ) not).
	
	
]

{ #category : #tests }
UserTest >> testDeleteQuestion [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	self assert: ( anUser1 questions includes: q1 ).
	anUser1 deleteMyQuestion: q1.
	self assert: (( anUser1 questions includes: q1 ) not).
]

{ #category : #tests }
UserTest >> testRelevantQuestions [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
		
	| q3 |
	q3 := Question withAuthor: anUser3 title: 'Question 3' content: 'content 3' topics: { }.
			
	i1 addTopicQuestion: q1.
	i2 addTopicQuestion: q2.
	
	anUser1 addFollowing: anUser2.
	
	self assert: ( anUser1 relevantQuestions includes: q2).
	self assert: ( (anUser1 relevantQuestions includes: q1 ) not ).
	
	anUser1 addInterest: ( i1 ).
	self assert: ( anUser1 relevantQuestions includes: q1).
	self assert: ( (anUser1 relevantQuestions includes: q3 ) not ).
	self assert: ( anUser1 relevantQuestions size) equals: 2.
]

{ #category : #tests }
UserTest >> testUserScore [
	"User>>userScore() es un metodo que recibe un usuario, y se retorna un puntaje que se
calcula en función de su actividad en la red social. Por cada pregunta realizada, suma 20
puntos, y por cada respuesta a una pregunta que realizó otro usuario, suma 50 puntos.
Además, se suma puntaje determinado por la diferencia entre likes y dislikes de todas
sus participaciones, que de tener mas dislikes que likes, puede ser negativo."
	"anUser1 tien una respuesta a su propia pregunta que no se cuenta, excepto para likes"
			
	"En el setup se declara que anUser1 hizo una pregunta (+20) y tiene una respuesta a su propia pregunta por lo que no cuenta para el +50 puntos, aunque sus likes y dislikes si se cuentan. anUser2 tiene una respuesta a otro usuario (+50) e hizo una pregunta (+20). Y anUser3 hizo una pregunta y n"
	self assert: ( anUser1 userScore ) equals: 20.
	self assert: ( anUser2 userScore ) equals: 70.
	self assert: ( anUser3 userScore ) equals: 50.
	
	"Si ahora se le dan 2 likes a la pregunta que hizo anUser1, entonces su userScore sumara 2 puntos"
	q1 likeFrom: anUser2.
	q1 likeFrom: anUser3.
	self assert: ( anUser1 userScore ) equals: 22.
	"Si ahora q1 recibe un dislike del mismo usuario que le dio like entonces se deshara el like previo y se agregara un dislike, quitando 2 puntos. Si ademas le damos dos dislikes de ususarios que antes no tenian like o dislike a la respuesta del usuario 1, esto quitara otros 2 puntos."
	q1 dislikeFrom: anUser2.
	a1 dislikeFrom: anUser2.
	a1 dislikeFrom: anUser3.
	self assert: ( anUser1 userScore ) equals: 18.
	"Otro dislike a la respuesta del usuario 1 de un usuario que ya habia dado dislike deshara el sidlike y agregara un punto a la user score del usuario 1. Un like del usuario 3 que antes tenia un dislike en la respuesta 1, deshara el dislike y agregara un like, sumando 2 puntos a la user Score del usuario 1"
	a1 dislikeFrom: anUser2.
	a1 likeFrom: anUser3.
	self assert: ( anUser1 userScore ) equals: 21.
]
