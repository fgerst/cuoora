"
Clase principal de la aplicacion
"
Class {
	#name : #CuooraPlatform,
	#superclass : #Object,
	#instVars : [
		'users',
		'topics'
	],
	#category : #'Cuoora-Model'
}

{ #category : #'adding/removing' }
CuooraPlatform >> deleteQuestion: aQuestion [
	"#TODO *eliminar de topicos
			 *eliminar de usuarios"

	^ nil
]

{ #category : #initialization }
CuooraPlatform >> initialize [
	users := OrderedCollection new.
	topics := OrderedCollection new
]

{ #category : #'adding/removing' }
CuooraPlatform >> newQuestion: aQuestion withTopics: topicList [
	topicList do: [ :each | each addTopicQuestion: aQuestion ].
	aQuestion author addQuestion: aQuestion.
	^ aQuestion
]

{ #category : #'adding/removing' }
CuooraPlatform >> newTopic: aTopic [
	topics add: aTopic.
	^ aTopic
]

{ #category : #'adding/removing' }
CuooraPlatform >> newUser: anUser [
	users add: anUser.
	^ anUser
]

{ #category : #accesing }
CuooraPlatform >> topics [
	^ topics
]

{ #category : #accesing }
CuooraPlatform >> users [
	^ users
]
