Class {
	#name : #VoteTest,
	#superclass : #TestCase,
	#instVars : [
		'aVote',
		'anAuthor'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
VoteTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	super setUp.
	anAuthor := User withUsername: 'name' password: 'word'.
	aVote := Vote withAuthor: anAuthor

]

{ #category : #tests }
VoteTest >> testAuthor [
	"Esto tambien es un test de un Get.... Deberiamos sacarlo creo"
			
	self assert: ( aVote author ) equals: ( anAuthor )
]

{ #category : #tests }
VoteTest >> testInitialization [
	"Deberiamos de hacer un test de esto??"
	"Vote>>initialize inicia la instancia del voto con autor y el DateAndTime del momento cuando paso"
			
	self assert: ( aVote author ) equals: ( anAuthor ).
	self assert: ( aVote timestamp isMemberOf: DateAndTime )
]

{ #category : #tests }
VoteTest >> testTimestamp [ 
	"Est test es inutil ELIMINAR"
	self assert: ( aVote timestamp isMemberOf: DateAndTime )
]
