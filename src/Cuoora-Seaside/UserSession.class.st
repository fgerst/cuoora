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
