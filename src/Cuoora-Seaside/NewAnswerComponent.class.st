"
Componente que implementa la creación de nuevas respuestas.
	Es llamado desde NewQuestionComponent
"
Class {
	#name : #NewAnswerComponent,
	#superclass : #CommonPageComponent,
	#instVars : [
		'titulo',
		'desarrollo',
		'topicos'
	],
	#category : #'Cuoora-Seaside'
}

{ #category : #rendering }
NewAnswerComponent >> renderPageContentOn: anHtmlCanvas [
	nil
]
