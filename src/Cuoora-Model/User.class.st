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

{ #category : #accesing }
User >> addFollowing: newUser [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	following add: newUser
]

{ #category : #accesing }
User >> checkPassword: word [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
  ^( word = password )
]

{ #category : #removing }
User >> deleteAnswerFromList: anAnswer [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^nil
]

{ #category : #removing }
User >> deleteQuestionFromList: aQuestion [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^nil
]

{ #category : #accesing }
User >> following [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^following 
]

{ #category : #initialization }
User >> initialize [
	"username password timestamp following questions answers interests"
	"scope: class-variables  &  instance-variables"	
			
	timestamp:= DateAndTime now.
	following:= OrderedCollection new.
	questions:= OrderedCollection new.
	answers:= OrderedCollection new.
	interests:= OrderedCollection new.
]

{ #category : #initialization }
User >> initialize: anUsername password: aPassword [
	"username password timestamp following questions answers interests"
	"scope: class-variables  &  instance-variables"	
			
	timestamp:= DateAndTime now.
	following:= OrderedCollection new.
	questions:= OrderedCollection new.
	answers:= OrderedCollection new.
	interests:= OrderedCollection new.
	
	username := anUsername.
	password := aPassword 
]

{ #category : #accesing }
User >> timestamp [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^timestamp 
]

{ #category : #accesing }
User >> username [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^username 
]

{ #category : #accesing }
User >> username: newName [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	username:= newName
]
