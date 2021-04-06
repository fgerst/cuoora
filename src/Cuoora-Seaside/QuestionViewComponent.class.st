"
Este componente se encarga de mostrar una pregunta con todas sus respuestas, permitir que den likes, dislikes, agregar nuevas respuestas y entrar a los perfiles de los usuarios autores.
"
Class {
	#name : #QuestionViewComponent,
	#superclass : #CommonPageComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #rendering }
QuestionViewComponent >> renderPageContentOn: anHtmlCanvas [
	nil
	"En que forma puede mandar la pregunta que quiere ver? la secion?"
	"self renderQuestionOn: anHtmlCanvas (Este metodo esta en HeaderComponent"
	"Podesmos tener un metodo render que muestre o el boton o el formulario y cambie"
	"Podriamos reusar el metodo de listar preguntas para listar respuestas, tambie en HeaderComponent"
]
