Class {
	#name : #AnswerTest,
	#superclass : #TestCase,
	#instVars : [
		'anAnswer1',
		'anAnswer2',
		'u1',
		'u2'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
AnswerTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	super setUp.
	u1 := User withUsername: 'name1' password: 'word1'.
	u2 := User withUsername: 'name2' password: 'word2'.
	anAnswer1 := Answer withAuthor: u1 content: 'contenido1'.
	anAnswer2 := Answer withAuthor: u2 content: 'contenido2'.
	u1 addAnswer: anAnswer1.
	u2 addAnswer: anAnswer2 
	
	
]

{ #category : #tests }
AnswerTest >> testDelete [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	anAnswer1 delete.
	
	self assert: ( u1 answers size ) equals: 0.
]

{ #category : #tests }
AnswerTest >> testLikes [

	anAnswer1 likeFrom: u1.
	anAnswer1 likeFrom: u2.
	self assert: ( anAnswer1 likes size ) equals: 2.
	self assert: ( anAnswer2 likes size ) equals: 0.
	self assert: ( anAnswer1 dislikes size ) equals: 0.
	self assert: ( anAnswer2 dislikes size ) equals: 0.
	
	anAnswer1 likeFrom: u1.
	self assert: ( anAnswer1 likes size ) equals: 1.
	self assert: ( anAnswer1 dislikes size ) equals: 0.
	
	anAnswer1 dislikeFrom: u2.
	self assert: ( anAnswer1 likes size ) equals: 0.
	self assert: ( anAnswer1 dislikes size ) equals: 1.
	
	anAnswer1 dislikeFrom: u2.
	self assert: ( anAnswer1 likes size ) equals: 0.
	self assert: ( anAnswer1 dislikes size ) equals: 0.
	
]

{ #category : #tests }
AnswerTest >> testPostScore [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
		
	self assert: ( anAnswer1 postScore ) equals: 0.
	self assert: ( anAnswer2 postScore ) equals: 0.
			
	anAnswer1 likeFrom: u1.
	anAnswer1 likeFrom: u2.
	anAnswer2 likeFrom: u1.
	anAnswer2 dislikeFrom: u2.
	self assert: ( anAnswer1 postScore ) equals: 2.
	self assert: ( anAnswer2 postScore ) equals: 0.
	
	anAnswer1 likeFrom: u1.
	anAnswer1 likeFrom: u2.
	anAnswer2 dislikeFrom: u2.
	self assert: ( anAnswer1 postScore ) equals: 0.
	self assert: ( anAnswer2 postScore ) equals: 1.
	
	anAnswer1 dislikeFrom: u1.
	anAnswer2 dislikeFrom: u1.
	anAnswer2 dislikeFrom: u2.
	self assert: ( anAnswer1 postScore ) equals: ( -1 ).
	self assert: ( anAnswer2 postScore ) equals: ( -2 ).
]
