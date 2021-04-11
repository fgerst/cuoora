"
Este componente se encarga de mostrar una pregunta con todas sus respuestas, permitir que den likes, dislikes, agregar nuevas respuestas y entrar a los perfiles de los usuarios autores.
"
Class {
	#name : #QuestionViewComponent,
	#superclass : #CommonPageComponent,
	#instVars : [
		'question'
	],
	#category : #'Cuoora-Seaside'
}

{ #category : #creation }
QuestionViewComponent class >> newWith: anObject [
	^ self new question: anObject yourself
]

{ #category : #callbacks }
QuestionViewComponent >> newAnswer [
	self call: (NewAnswerComponent newWith: question)
]

{ #category : #accesing }
QuestionViewComponent >> question [
	^ question
]

{ #category : #accesing }
QuestionViewComponent >> question: aQuestion [
	question := aQuestion
]

{ #category : #'rendering-answers' }
QuestionViewComponent >> renderAnswer: anAnswer on: html [
	html div
		class: 'post-div';
		with: [
			self renderAnswerAuthor: anAnswer on: html.
			html paragraph: anAnswer content.
			self renderPostVotes: anAnswer on: html.
			self renderPostReactionAnchors: anAnswer on: html.
			html horizontalRule ]
]

{ #category : #'rendering-answers' }
QuestionViewComponent >> renderAnswerAuthor: anAnswer on: html [
	html paragraph
		with: [ html span
				class: 'italic';
				with: 'Respuesta de '.
			html anchor
				class: 'link-alt italic';
				callback: [ nil ];
				with: anAnswer author username ]
]

{ #category : #'rendering-answers' }
QuestionViewComponent >> renderAnswers: answers on: html [
	answers isEmpty
		ifTrue: [ html paragraph
				class: 'italic bold width-800';
				with: '...aún no hay respuestas' ]
		ifFalse: [ html paragraph
				class: 'italic bold width-800';
				with: 'Respuestas:'.
			html
				orderedList: [ answers do: [ :answer | self renderAnswer: answer on: html ] ].
			html paragraph
				class: 'italic width-800';
				with: '...no hay mas respuestas' ]
]

{ #category : #'rendering-answers' }
QuestionViewComponent >> renderNewAnswerButtonOn: html [
	html form
		class: 'newpost post-div center';
		with: [ html button
				class: 'newpost-button';
				callback: [ self newAnswer ];
				with: '+'.
			html span: 'Agregar respuesta' ]
]

{ #category : #rendering }
QuestionViewComponent >> renderPageContentOn: aCanvas [
	self renderQuestion: question on: aCanvas.
	self renderQuestionAnswersOn: aCanvas.
	self renderNewAnswerButtonOn: aCanvas
]

{ #category : #'rendering-answers' }
QuestionViewComponent >> renderQuestionAnswersOn: html [
	self renderAnswers: question answers on: html
]

{ #category : #rendering }
QuestionViewComponent >> renderQuestionContentOn: html [
	"preguntar si es opcional mostrar content"

	html div
		with: [ html paragraph
				class: 'italic';
				with: 'Contenido:'.
			html paragraph with: question content.
			html horizontalRule ]
]
