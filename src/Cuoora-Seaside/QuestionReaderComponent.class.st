"
Este componente se encargara de mostrar una pregunta con todas sus respuestas, permitir que den likes, dislikes, agregar nuevas preguntas y que se pueda entrar a los perfiles de los usuarios autores.

Se llama a este componente desde HomeComponent ( ¿o desde userProfileComponent? ).
"
Class {
	#name : #QuestionReaderComponent,
	#superclass : #HeaderComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #rendering }
QuestionReaderComponent >> renderContentOn: anHtmlCanvas [
	super renderContentOn: anHtmlCanvas.
	"En que forma puede mandar la pregunta que quiere ver? la secion?"
	"self renderQuestionOn: anHtmlCanvas (Este metodo esta en HeaderComponent"
	"Podesmos tener un metodo render que muestre o el boton o el formulario y cambie"
	"Podriamos reusar el metodo de listar preguntas para listar respuestas, tambie en HeaderComponent"
]