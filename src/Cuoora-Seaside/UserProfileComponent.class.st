"
Este componente se encarga de mostrar todas las preguntas de un usuario y permitir agregar al usuario del perfil a tus follows.

Se llama a este componente desde HomeComponent o desde QuestionReaderComponent.
"
Class {
	#name : #UserProfileComponent,
	#superclass : #HeaderComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #rendering }
UserProfileComponent >> renderContentOn: anHtmlCanvas [
	super renderContentOn: anHtmlCanvas.
	"Como sabemos a que usuario le pertenece este perfil?"
	"self renderTituloDePerfilOn: anHtmlCanvas"
	"Encontrar las preguntas del usuario de este perfil y reusar el metodo renderQuestions de Header"
]
