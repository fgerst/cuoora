Class {
	#name : #TopicTest,
	#superclass : #TestCase,
	#instVars : [
		'aTopic1',
		'q1',
		'q2',
		'q3'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
TopicTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	super setUp.
	aTopic1 := Topic withName: 'topic 1' description: 'description 1'.
	q1 := Question withAuthor: (User new) title: 'q1' content: 'c1' topics: { }.
	q2 := Question withAuthor: (User new) title: 'q2' content: 'c2' topics: { }.
	q3 := Question withAuthor: (User new) title: 'q3' content: 'c3' topics: { }.
]

{ #category : #tests }
TopicTest >> testAddTopicQuestions [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
		
	self assert: ( aTopic1 topicQuestions size ) equals: 0.
			
	self assert: ( aTopic1 addTopicQuestion: q1 ) equals: ( q1 ).
	self assert: ( aTopic1 addTopicQuestion: q2 ) equals: ( q2 ).
	self assert: ( aTopic1 addTopicQuestion: q3 ) equals: ( q3 ).
	self assert: ( aTopic1 topicQuestions size ) equals: 3.
	self assert: ( aTopic1 topicQuestions includes: q1 ).
	self assert: ( aTopic1 topicQuestions includes: q2 ).
	self assert: ( aTopic1 topicQuestions includes: q3 ).
]

{ #category : #tests }
TopicTest >> testDeleteTopicQuestion [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	aTopic1 addTopicQuestion: q1.
	aTopic1 addTopicQuestion: q2.
	aTopic1 addTopicQuestion: q3.
	aTopic1 deleteTopicQuestion: q1.
	
	self assert: ( ( aTopic1 topicQuestions includes: q1 ) not ).
	self assert: ( aTopic1 topicQuestions includes: q3 ).
	self assert: ( aTopic1 topicQuestions size ) equals: 2.
	
	aTopic1 deleteTopicQuestion: q2.
	aTopic1 deleteTopicQuestion: q3.
	self assert: ( aTopic1 topicQuestions size ) equals: 0.
	
	self assert: ( aTopic1 deleteTopicQuestion: q2 ) equals: ( nil).
]
