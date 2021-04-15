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
	super setUp.
	anAuthor := User withUsername: 'name' password: 'word'.
	aVote := Vote withAuthor: anAuthor
]

{ #category : #tests }
VoteTest >> testInitialize [
	"corrobora que la instancia del Vote fue creada con autor y el DateAndTime del instante de la creacion"

	self assert: aVote author equals: anAuthor.
	self assert: (aVote timestamp isMemberOf: DateAndTime)
]
