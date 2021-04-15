"
Clase abstracta, representa una publicacion (pregunta o respuesta)
"
Class {
	#name : #Post,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'author',
		'content',
		'likes',
		'dislikes'
	],
	#category : #'Cuoora-Model'
}

{ #category : #accesing }
Post >> author [
	^ author
]

{ #category : #accesing }
Post >> content [
	^ content
]

{ #category : #removing }
Post >> delete [
	^ self subclassResponsibility
]

{ #category : #actions }
Post >> deleteOrAddVoteFrom: anUser in: votes [
	votes
		detect: [ :each | each author = anUser ]
		ifFound: [ :element | votes remove: element ]
		ifNone: [ votes add: (Vote withAuthor: anUser) ]
]

{ #category : #actions }
Post >> deleteVoteFrom: anUser in: votes [
	votes
		detect: [ :each | each author = anUser ]
		ifFound: [ :element | votes remove: element ]
]

{ #category : #accesing }
Post >> dislikeCount [
	^ dislikes size
]

{ #category : #actions }
Post >> dislikeFrom: anUser [
	"registra un dislike de un usuario"

	"primero elimina el like que haya podido realizar el usuario en el Post"
	self deleteVoteFrom: anUser in: likes.
	"luego, si ya hay un dislike propio lo elimina, si no lo hay lo agrega"
	self deleteOrAddVoteFrom: anUser in: dislikes
]

{ #category : #accesing }
Post >> dislikes [
	^ dislikes
]

{ #category : #initialization }
Post >> initialize [
	timestamp := DateAndTime now.
	likes := OrderedCollection new.
	dislikes := OrderedCollection new
]

{ #category : #accesing }
Post >> likeCount [
	^ likes size
]

{ #category : #actions }
Post >> likeFrom: anUser [
	"registra un like de un usuario en un Post"

	"primero elimina el dislike que haya podido realizar el usuario en el Post"
	self deleteVoteFrom: anUser in: dislikes.
	"luego, si ya hay un like propio lo elimina, si no lo hay lo agrega"
	self deleteOrAddVoteFrom: anUser in: likes
]

{ #category : #accesing }
Post >> likes [
	^ likes
]

{ #category : #calculating }
Post >> postScore [
	^ likes size - dislikes size
]

{ #category : #accesing }
Post >> timestamp [
	^ timestamp
]
