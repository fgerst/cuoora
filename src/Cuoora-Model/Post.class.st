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
Post >> author: anUser [
	author := anUser
]

{ #category : #accesing }
Post >> content [
	^ content
]

{ #category : #accesing }
Post >> content: aString [
	content := aString
]

{ #category : #removing }
Post >> delete [
	^ self subclassResponsibility
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
Post >> likes [
	^ likes
]

{ #category : #accesing }
Post >> timestamp [
	^ timestamp
]
