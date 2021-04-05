"
Este componente agrega a la session de seaside variables que mantienen informacion importante en la sesion, en este caso el usuario.
"
Class {
	#name : #UserSession,
	#superclass : #WASession,
	#instVars : [
		'user'
	],
	#category : #'Cuoora-Seaside'
}

{ #category : #accesing }
UserSession >> loggedUsername [
	^ user username
]

{ #category : #accesing }
UserSession >> loginUser: anUser [
	user := anUser
]

{ #category : #accesing }
UserSession >> logoutUser [
	user := nil
]

{ #category : #accesing }
UserSession >> user [
	^ user
]
