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
	| text |
	text := answers isEmpty
		ifTrue: [ '...aún no hay respuestas' ]
		ifFalse: [ 'Respuestas:' ].
	html paragraph
		class: 'italic bold width-800';
		with: text.
	html
		orderedList: [ answers do: [ :answer | self renderAnswer: answer on: html ] ]
]

{ #category : #rendering }
QuestionViewComponent >> renderPageContentOn: aCanvas [
	self renderQuestion: question on: aCanvas.
	self renderQuestionAnswersOn: aCanvas.
]

{ #category : #'rendering-answers' }
QuestionViewComponent >> renderQuestionAnswersOn: html [
	self renderAnswers: question answers on: html
]

{ #category : #rendering }
QuestionViewComponent >> renderQuestionContentOn: html [
	"preguntar si es opcional"

	html div
		with: [ html paragraph
				class: 'italic';
				with: 'Contenido:'.
			html paragraph with: question content.
			html horizontalRule ]
]
