Class {
	#name : #UserTest,
	#superclass : #TestCase,
	#instVars : [
		'anUser1',
		'anUser2',
		'q1',
		'q2',
		'a1',
		'a2',
		'f1',
		'f2',
		'i1',
		'i2'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
UserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	anUser1 withUsername: 'name1' password: 'word1'.
	anUser2 withUsername: 'name2' password: 'word2'.
	q1 := Question withAuthor: anUser1 title: 'Question 1' content: 'content 1'.
	q2 := Question withAuthor: anUser2 title: 'Question 2' content: 'content 2'.
	
]
