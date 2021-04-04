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
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	self assert: ( aVote author ) equals: ( anAuthor )
]

{ #category : #tests }
VoteTest >> testTimestamp [ 

	self assert: ( aVote timestamp isMemberOf: DateAndTime )
]
