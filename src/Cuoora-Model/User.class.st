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

{ #category : #access }
User >> checkPassword: aString [
	^ aString = password
]

{ #category : #'adding/removing' }
User >> deleteMyAnswer: anAnswer [
	answers remove: anAnswer
]

{ #category : #'adding/removing' }
User >> deleteMyQuestion: aQuestion [
	questions remove: aQuestion.
	aQuestion delete.
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
User >> password: aString [
	password := aString
]

{ #category : #accesing }
User >> questions [
	^ questions
]

{ #category : #accesing }
User >> relevantQuestions [

	| rQuestions |
	
	rQuestions := OrderedCollection new.
	rQuestions add: ( interests topicQuestions ).
	rQuestions add: ( following questions ).
	
	^rQuestions 
]

{ #category : #accesing }
User >> sortedAnswers [
	^ ( answers sort: [ :a :b | ( a postScore ) < ( b postScore ) ] )
]

{ #category : #accesing }
User >> sortedQuestions [
	^ ( questions sort: [ :a :b | ( a postScore ) < ( b postScore ) ] )
]

{ #category : #accesing }
User >> timestamp [
	^ timestamp
]

{ #category : #calculating }
User >> userScore [
	"#TODO"

	^ nil
]

{ #category : #accesing }
User >> username [
	^ username
]

{ #category : #accesing }
User >> username: aString [
	username := aString
]
