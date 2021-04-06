"
Componente que implementa la creación de nuevas preguntas.
	Es llamado desde HomeComponent, cuando se presione el boton ""+ Hacer nueva pregunta"".
"
Class {
	#name : #NewQuestionComponent,
	#superclass : #CommonPageComponent,
	#instVars : [
		'title',
		'content',
		'topics'
	],
	#category : #'Cuoora-Seaside'
}

{ #category : #callbacks }
NewQuestionComponent >> accept [
	"Aca comprobar que los topicos sean correctos
	Guardar pregunta en donde deberia de guardarse"

	self fieldsEmpty
		ifTrue: [ ^ nil ].
	self answer
]

{ #category : #callbacks }
NewQuestionComponent >> cancel [
	self answer
]

{ #category : #accessing }
NewQuestionComponent >> content [
	^ content
]

{ #category : #accessing }
NewQuestionComponent >> content: aString [
	content := aString
]

{ #category : #accessing }
NewQuestionComponent >> fieldsEmpty [
	^ title isEmptyOrNil | content isEmptyOrNil | topics isEmptyOrNil
]

{ #category : #rendering }
NewQuestionComponent >> renderButtonsOn: aCanvas [
	"El guardado todavia no guarda"

	aCanvas
		form: [ aCanvas space.
			aCanvas space.
			aCanvas submitButton
				class: 'submit-button';
				callback: [ self accept ];
				with: 'Crear pregunta'.
			aCanvas space.
			aCanvas space.
			aCanvas submitButton
				class: 'submit-button';
				callback: [ self cancel ];
				with: 'Cancelar' ]
]

{ #category : #rendering }
NewQuestionComponent >> renderInputTextOn: html [
	"#TODO refactorizar en distintos metodos"

	html
		paragraph: [ html space.
			html space.
			html text: 'Titulo:  '.
			html textInput
				placeholder: 'Escriba aqui el titulo de su pregunta';
				on: #title of: self ].
	html
		paragraph: [ html space.
			html space.
			html text: 'Desarrollo:'.
			html textInput
				placeholder: 'Escriba aqui el desarrollo de su pregunta';
				on: #content of: self ].
	html
		paragraph: [ html space.
			html space.
			html text: 'Topicos:  '.
			html textInput
				placeholder: 'Escriba aqui los topicos separados por coma';
				on: #topics of: self ]
]

{ #category : #rendering }
NewQuestionComponent >> renderPageContentOn: anHtmlCanvas [
	self renderPageTitleOn: anHtmlCanvas.
	anHtmlCanvas form
		with: [ anHtmlCanvas horizontalRule.
			self renderInputTextOn: anHtmlCanvas.
			anHtmlCanvas horizontalRule.
			self renderButtonsOn: anHtmlCanvas ]
]

{ #category : #rendering }
NewQuestionComponent >> renderPageTitleOn: html [
	html paragraph
		class: 'italic medium';
		with: [ html span with: 'Nueva Pregunta' ]
]

{ #category : #accessing }
NewQuestionComponent >> title [
	^ title
]

{ #category : #accessing }
NewQuestionComponent >> title: aString [
	title := aString
]

{ #category : #accessing }
NewQuestionComponent >> topics [
	^ topics
]

{ #category : #accessing }
NewQuestionComponent >> topics: anOrderedCollection [
	topics := anOrderedCollection
]
