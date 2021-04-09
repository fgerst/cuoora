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
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"
	anUser1 addInterest: i1. anUser1 addInterest: i2. anUser1 addInterest: i2.  
	anUser2 addInterest: i1.
			
	self assert: ( anUser1 interests size ) equals: 2.
	self assert: ( anUser2 interests size ) equals: 1.
	self assert: ( anUser3 interests size ) equals: 0.
	
	self assert: ( anUser1 questions size ) equals: 1.
	self assert: ( anUser2 questions size ) equals: 1.
	self assert: ( anUser3 questions size ) equals: 0.
	
	self assert: ( anUser1 answers size ) equals: 1.
	self assert: ( anUser2 answers size ) equals: 2.
	self assert: ( anUser3 answers size ) equals: 1.
	
	anUser1 addFollowing: anUser2.
	anUser1 addFollowing: anUser3.
	anUser2 addFollowing: anUser3.
	
	self assert: ( anUser1 following size ) equals: 2.
	self assert: ( anUser2 following size ) equals: 1.
	self assert: ( anUser3 following size ) equals: 0.
	
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
	"anUser1 tien una respuesta a su propia pregunta que no se cuenta, excepto para likes"
	"scope: class-variables  &  instance-variables"	
			
	self assert: ( anUser1 userScore ) equals: 20.
	self assert: ( anUser2 userScore ) equals: 70.
	self assert: ( anUser3 userScore ) equals: 50.
	q1 likeFrom: anUser2.
	q1 likeFrom: anUser3.
	self assert: ( anUser1 userScore ) equals: 22.
	q1 dislikeFrom: anUser2.
	a1 dislikeFrom: anUser2.
	a1 dislikeFrom: anUser3.
	self assert: ( anUser1 userScore ) equals: 18.
	a1 dislikeFrom: anUser2.
	a1 likeFrom: anUser3.
	self assert: ( anUser1 userScore ) equals: 21.
]
