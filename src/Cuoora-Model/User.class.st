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
User >> addFollowing: anUser [ 
	following add: anUser
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
User >> deleteAnswer: anAnswer [
	^ nil
]

{ #category : #'adding/removing' }
User >> deleteQuestion: aQuestion [
	^ nil
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

{ #category : #'adding/removing' }
User >> newAnswer: anAnswer [
	^ nil
]

{ #category : #'adding/removing' }
User >> newQuestion: aQuestion [
	^ nil
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
User >> timestamp [
	^ timestamp
]

{ #category : #accesing }
User >> username [
	^ username
]

{ #category : #accesing }
User >> username: aString [
	username := aString
]
