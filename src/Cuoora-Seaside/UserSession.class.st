"
Este componente extiende la WASession de Seaside agregando variables que mantienen informacion importante en la sesion, en este caso la instancia User del usuario logeado.
"
Class {
	#name : #UserSession,
	#superclass : #WASession,
	#instVars : [
		'user'
	],
	#category : #'Cuoora-Seaside'
}

{ #category : #accessing }
UserSession >> loginUser: anUser [
	user := anUser
]

{ #category : #accessing }
UserSession >> logoutUser [
	user := nil
]

{ #category : #accessing }
UserSession >> user [
	^ user
]
