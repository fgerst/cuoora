"
Este componente se encarga de mostrar todas las preguntas de un usuario y permitir agregar al usuario del perfil a tus follows.
"
Class {
	#name : #UserProfileComponent,
	#superclass : #CommonPageComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #rendering }
UserProfileComponent >> renderPageContentOn: aCanvas [
	nil
	"Como sabemos a que usuario le pertenece este perfil?"
	"self renderTituloDePerfilOn: anHtmlCanvas"
	"Encontrar las preguntas del usuario de este perfil y reusar el metodo renderQuestions de Header"
]
