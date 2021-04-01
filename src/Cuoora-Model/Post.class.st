"
Clase abstracta, representa una publicacion (pregunta o respuesta)
"
Class {
	#name : #Post,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'author',
		'likes',
		'dislikes'
	],
	#category : #'Cuoora-Model'
}

{ #category : #removing }
Post >> delete [
	^ self subclassResponsibility
]
