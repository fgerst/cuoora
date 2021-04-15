"
Clase que representa al usuario
"
Class {
	#name : #User,
	#superclass : #Object,
	#instVars : [
		'username',
		'password',
		'timestamp',
		'following',
		'questions',
		'answers',
		'interests',
		'profileName'
	],
	#category : #'Cuoora-Model'
}

{ #category : #creation }
User class >> withUsername: anUsername password: aPassword [
	^ self new
		initializeWithUsername: anUsername
		profileName: anUsername
		password: aPassword yourself
]

{ #category : #'adding/removing' }
User >> addAnswer: anAnswer [
	answers add: anAnswer
]

{ #category : #'adding/removing' }
User >> addFollowing: anUser [ 
	following add: anUser
]

{ #category : #'adding/removing' }
User >> addInterest: aTopic [
	interests add: aTopic
]

{ #category : #accessing }
User >> answers [
	^ answers
]

{ #category : #'adding/removing' }
User >> deleteMyAnswer: anAnswer [
	"limpia la referencia a una respuesta propia de una pregunta que está siendo eliminada"

	answers remove: anAnswer ifAbsent: [ ^ nil ]
]

{ #category : #'adding/removing' }
User >> deleteMyQuestion: aQuestion [
	"elimina una pregunta propia de mi coleccion, y envia el mensaje delete a la pregunta para que limpie referencias a respuestas y topicos."

	questions remove: aQuestion ifAbsent: [ ^ nil ].
	aQuestion delete
]

{ #category : #accessing }
User >> following [
	^ following
]

{ #category : #initialization }
User >> initialize [
	timestamp := DateAndTime now.
	questions := OrderedCollection new.
	answers := OrderedCollection new.
	following := OrderedCollection new.
	interests := OrderedCollection new.
]

{ #category : #initialization }
User >> initializeWithUsername: anUsername profileName: aProfileName password: aPassword [
	username := anUsername.
	profileName := aProfileName.
	password := aPassword
]

{ #category : #accessing }
User >> interests [
	^ interests
]

{ #category : #accessing }
User >> isFollowing: anUser [
	"chequea si un usuario sigue a otro"

	^ following includes: anUser
]

{ #category : #'adding/removing' }
User >> newQuestion: aQuestion [
	"crea una nueva pregunta"

	questions add: aQuestion.
	aQuestion addToRelatedTopics.
	^ aQuestion
]

{ #category : #accessing }
User >> password [
	^ password
]

{ #category : #accessing }
User >> profileName [
	^ profileName
]

{ #category : #accessing }
User >> profileName: aProfileName [
	profileName := aProfileName
]

{ #category : #accessing }
User >> questions [
	^ questions
]

{ #category : #listing }
User >> relevantQuestions [
	"lista las preguntas relevantes, se utiliza un Set para que no se repitan"

	| relevantQuestions |
	relevantQuestions := Set new.
	following do: [ :user | relevantQuestions addAll: user questions ].
	interests
		do: [ :topic | relevantQuestions addAll: topic topicQuestions ].
	^ relevantQuestions
]

{ #category : #accessing }
User >> timestamp [
	^ timestamp
]

{ #category : #calculating }
User >> userScore [
	"calcula el puntaje del usuario"

	| qScore aScore vScore |
	"puntaje por cantidad de preguntas"
	qScore := questions size * 20.
	"puntaje por cantidad de respuestas a preguntas de otros usuarios"
	aScore := (answers
		difference: (questions flatCollect: [ :each | each answers ])) size
		* 50.
	"balance de likes/dislikes en todas las participaciones del usuario"
	vScore := (answers sumNumbers: [ :each | each postScore ])
		+ (questions sumNumbers: [ :each | each postScore ]).
	"devuelve el total"
	^ qScore + aScore + vScore
]

{ #category : #accessing }
User >> username [
	^ username
]
