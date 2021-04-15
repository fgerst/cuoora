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
	"Topic>>addTopicQuestion() debe agregar las preguntas correspondientes a un topico a la OrderedCollection del topico"
		
	"Se asegura de que la OrderedCollection se inicialize vacia"
	self assert: ( aTopic1 topicQuestions size ) equals: 0.
			
	"Si agregamos una pregunta con Topic>>addTopicQuestion() devuelve la pregunta que se le envio"
	self assert: ( aTopic1 addTopicQuestion: q1 ) equals: ( q1 ).
	self assert: ( aTopic1 addTopicQuestion: q2 ) equals: ( q2 ).
	self assert: ( aTopic1 addTopicQuestion: q3 ) equals: ( q3 ).
	
	"Si agregamos 3 preguntas el size ahora deberia ser 3 y la OrderedCollection deberia incluir todas las preguntas enviadas"
	self assert: ( aTopic1 topicQuestions size ) equals: 3.
	self assert: ( aTopic1 topicQuestions includes: q1 ).
	self assert: ( aTopic1 topicQuestions includes: q2 ).
	self assert: ( aTopic1 topicQuestions includes: q3 ).
]

{ #category : #tests }
TopicTest >> testDeleteTopicQuestion [
	"Topic>>deleteTopicQuestion() se encarga de eliminar la pregunta que le mandes de la OrderedCollection que son las preguntas del topico, si no encuentra la pregunta devuelve nil."	
	
	"Si se manda a eliminar una pregunta que no existe devulve nil"
	self deny: ( aTopic1 topicQuestions includes: q1 ).
	self assert: ( aTopic1 deleteTopicQuestion: q1 ) equals: ( nil ). 	
	
	"Si se elimina una pregunta deja de estar en la ordereCollection que devuelve Topic>>topicQuestions"
	aTopic1 addTopicQuestion: q2.
	aTopic1 addTopicQuestion: q3.
	self assert: ( aTopic1 topicQuestions includes: q3 ).
	self assert: ( aTopic1 topicQuestions size ) equals: 2.
	
	aTopic1 deleteTopicQuestion: q2.
	aTopic1 deleteTopicQuestion: q3.
	self deny: ( aTopic1 topicQuestions includes: q3 ).
	self assert: ( aTopic1 topicQuestions size ) equals: 0.
]
