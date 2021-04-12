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
	self fieldsEmpty
		ifTrue: [ ^ nil ].
	(topics := self model parseTopics: topics)
		ifEmpty: [ 
			topics := nil.
			^ nil ].
	self session user
		newQuestion:
			(Question
				withAuthor: self session user
				title: title
				content: content
				topics: topics).
	self answer
]

{ #category : #callbacks }
NewQuestionComponent >> cancel [
	self clearFields.
	self answer
]

{ #category : #accessing }
NewQuestionComponent >> clearFields [
	title := nil.
	content := nil.
	topics := nil
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

{ #category : #accessing }
NewQuestionComponent >> model [
^CuooraPlatform soleInstance
]

{ #category : #'rendering-elements' }
NewQuestionComponent >> renderButtonsOn: html [
	html submitButton
		class: 'submit-button';
		callback: [ self accept ];
		with: 'Crear pregunta'.
	html space.
	html submitButton
		class: 'submit-button';
		callback: [ self cancel ];
		with: 'Cancelar'
]

{ #category : #'rendering-elements' }
NewQuestionComponent >> renderContentInput: html [
	html paragraph
		class: 'italic';
		with: 'Desarrollo:'.
	html textArea
		class: 'text-area';
		placeholder: 'Escriba aquí el desarrollo de su pregunta';
		on: #content of: self
]

{ #category : #rendering }
NewQuestionComponent >> renderInputElementsOn: html [
	self renderTitleInput: html.
	self renderContentInput: html.
	self renderTopicInput: html
]

{ #category : #rendering }
NewQuestionComponent >> renderPageContentOn: aCanvas [
	self renderPageTitleOn: aCanvas.
	self renderQuestionFormOn: aCanvas.

]

{ #category : #rendering }
NewQuestionComponent >> renderPageTitleOn: html [
	html paragraph
		class: 'italic medium';
		with: [ html span with: 'Nueva Pregunta' ]
]

{ #category : #rendering }
NewQuestionComponent >> renderQuestionFormOn: html [
	html form
		with: [ html horizontalRule.
			self renderInputElementsOn: html.
			html horizontalRule.
			self renderButtonsOn: html ]
]

{ #category : #'rendering-elements' }
NewQuestionComponent >> renderTitleInput: html [
	html paragraph
		class: 'italic';
		with: 'Titulo:'.
	html textInput
		class: 'text-input';
		placeholder: 'Escriba aquí el titulo de su pregunta';
		on: #title of: self
]

{ #category : #'rendering-elements' }
NewQuestionComponent >> renderTopicInput: html [
	html paragraph
		class: 'italic';
		with: 'Topicos:'.
	html textInput
		class: 'text-input';
		placeholder: 'Tópicos separados por coma, ejemplo: "java,Test de unidad,Python"';
		on: #topics of: self
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
