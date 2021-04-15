"
Componente que implementa la creación de nuevas respuestas.
	Es llamado desde NewQuestionComponent.
"
Class {
	#name : #NewAnswerComponent,
	#superclass : #CommonPageComponent,
	#instVars : [
		'question',
		'content'
	],
	#category : #'Cuoora-Seaside'
}

{ #category : #creation }
NewAnswerComponent class >> newWithQuestion: aQuestion [
	^ self new question: aQuestion yourself
]

{ #category : #callbacks }
NewAnswerComponent >> accept [
	self fieldsEmpty
		ifTrue: [ ^ nil ].
	question
		newAnswer: (Answer withAuthor: (self session user) content: content).
	self answer
]

{ #category : #callbacks }
NewAnswerComponent >> cancel [
	content := nil.
	self answer
]

{ #category : #accessing }
NewAnswerComponent >> content [
	^ content
]

{ #category : #accessing }
NewAnswerComponent >> content: anObject [
	content := anObject
]

{ #category : #accessing }
NewAnswerComponent >> fieldsEmpty [
	^ content isEmptyOrNil
]

{ #category : #accessing }
NewAnswerComponent >> question [
	^ question
]

{ #category : #accessing }
NewAnswerComponent >> question: anObject [
	question := anObject
]

{ #category : #rendering }
NewAnswerComponent >> renderAnswerFormOn: html [
	html form
		class: 'width-800';
		with: [ self renderInputElementsOn: html.
			html break.
			self renderButtonsOn: html ]
]

{ #category : #rendering }
NewAnswerComponent >> renderButtonsOn: html [
	html submitButton
		class: 'submit-button';
		callback: [ self accept ];
		with: 'Crear respuesta'.
	html space.
	html submitButton
		class: 'submit-button';
		callback: [ self cancel ];
		with: 'Cancelar'
]

{ #category : #rendering }
NewAnswerComponent >> renderInputElementsOn: html [
	html paragraph
		class: 'italic';
		with: 'Responder'.
	html textArea
		class: 'text-area';
		placeholder: 'Escriba aquí el desarrollo de su respuesta';
		on: #content of: self.

]

{ #category : #rendering }
NewAnswerComponent >> renderPageContentOn: aCanvas [
	"renderiza la pregunta a la que se responde y el formulario de la nueva respuesta"

	self renderQuestion: question on: aCanvas.
	self renderAnswerFormOn: aCanvas
]
