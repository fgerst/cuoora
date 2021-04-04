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
		'interests'
	],
	#category : #'Cuoora-Model'
}

{ #category : #creation }
User class >> withUsername: anUsername password: aPassword [
	^ self new
		username: anUsername;
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

{ #category : #'adding/removing' }
User >> addQuestion: aQuestion [
	questions add: aQuestion
]

{ #category : #accesing }
User >> answers [
	^ answers
]

{ #category : #'adding/removing' }
User >> deleteMyAnswer: anAnswer [
	answers remove: anAnswer
]

{ #category : #'adding/removing' }
User >> deleteMyQuestion: aQuestion [
	aQuestion delete.
	questions remove: aQuestion

]

{ #category : #accesing }
User >> following [
	^ following
]

{ #category : #initialization }
User >> initialize [
	timestamp := DateAndTime now.
	questions := OrderedCollection new.
	answers := OrderedCollection new.
	following := OrderedCollection new.
	interests := OrderedCollection new
]

{ #category : #accesing }
User >> interests [
	^ interests
]

{ #category : #accesing }
User >> password [
	^ password
]

{ #category : #accesing }
User >> password: aString [
	password := aString
]

{ #category : #accesing }
User >> questions [
	^ questions
]

{ #category : #listing }
User >> relevantQuestions [
	| relevantQuestions |
	relevantQuestions := Set new.
	following do: [ :user | relevantQuestions addAll: user questions ].
	interests do: [ :topic | relevantQuestions addAll: topic questions ].
	^ relevantQuestions
]

{ #category : #listing }
User >> sortedAnswers [
	^ ( answers sort: [ :a :b | ( a postScore ) < ( b postScore ) ] )
]

{ #category : #listing }
User >> sortedQuestions [
	^ ( questions sort: [ :a :b | ( a postScore ) < ( b postScore ) ] )
]

{ #category : #accesing }
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

{ #category : #accesing }
User >> username [
	^ username
]

{ #category : #accesing }
User >> username: aString [
	username := aString
]
