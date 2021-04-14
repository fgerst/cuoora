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

{ #category : #accessing }
QuestionViewComponent >> question [
	^ question
]

{ #category : #accessing }
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
				callback: [ self viewProfile: anAnswer author ];
				with: anAnswer author profileName ]
]

{ #category : #'rendering-answers' }
QuestionViewComponent >> renderAnswers: answers on: html [
	html paragraph
		class: 'italic bold width-800';
		with: 'Respuestas:'.
	html
		orderedList: [ answers do: [ :answer | self renderAnswer: answer on: html ] ].
	html paragraph
		class: 'italic width-800';
		with: '...no hay mas respuestas'
]

{ #category : #rendering }
QuestionViewComponent >> renderNewAnswerButtonOn: html [
	html form
		class: 'newpost width-800 center';
		with: [ html submitButton
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

{ #category : #rendering }
QuestionViewComponent >> renderQuestionAnswersOn: html [
	question answers isEmpty
		ifTrue: [ html paragraph
				class: 'italic bold width-800';
				with: '...aún no hay respuestas' ]
		ifFalse: [ self renderAnswers: self sortedAnswers on: html ]
]

{ #category : #listing }
QuestionViewComponent >> sortedAnswers [
	^ question answersSortedByScore
]
