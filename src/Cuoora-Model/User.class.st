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
		username: anUsername;
		profileName: anUsername;
		password: aPassword;
		yourself
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
	answers remove: anAnswer ifAbsent: [ ^ nil ]
]

{ #category : #'adding/removing' }
User >> deleteMyQuestion: aQuestion [
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
	questions := Set new.
	answers := Set new.
	following := Set new.
	interests := Set new.
]

{ #category : #accessing }
User >> interests [
	^ interests
]

{ #category : #accessing }
User >> isFollowing: anUser [
	^ following includes: anUser
]

{ #category : #'adding/removing' }
User >> newQuestion: aQuestion [
	questions add: aQuestion.
	aQuestion	 addToRelatedTopics.
	^ aQuestion
]

{ #category : #accessing }
User >> password [
	^ password
]

{ #category : #accessing }
User >> password: aString [
	password := aString
]

{ #category : #accessing }
User >> profileName [
	^ profileName
]

{ #category : #accessing }
User >> profileName: anObject [
	profileName := anObject
]

{ #category : #accessing }
User >> questions [
	^ questions
]

{ #category : #listing }
User >> relevantQuestions [
	| relevantQuestions |
	relevantQuestions := Set new.
	following do: [ :user | relevantQuestions addAll: user questions ].
	interests do: [ :topic | relevantQuestions addAll: topic topicQuestions ].
	^ relevantQuestions
]

{ #category : #accessing }
User >> timestamp [
	^ timestamp
]

{ #category : #calculating }
User >> userScore [
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
	^ qScore + aScore + vScore
]

{ #category : #accessing }
User >> username [
	^ username
]

{ #category : #accessing }
User >> username: aString [
	username := aString.
	profileName := username.
]
