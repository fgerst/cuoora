"
Este componente agrega a la session de seaside variables que mantienen informacion importante en la sesion, en este caso el usuario.
"
Class {
	#name : #SessionWithUser,
	#superclass : #WASession,
	#instVars : [
		'user'
	],
	#category : #'Cuoora-Seaside'
}

{ #category : #accesing }
SessionWithUser >> user [
	^ user
]

{ #category : #accesing }
SessionWithUser >> user: anUser [
	user := anUser
]
