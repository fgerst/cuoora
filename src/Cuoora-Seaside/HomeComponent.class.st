"
Componente que implementa el Home de la aplicacion, donde se pueden ver las Preguntas Relevantes para el Usuario, y crear nuevas preguntas.

Expresión a evaluar para registrar aplicación:

""
| app |
app := WAAdmin register: LoginComponent asApplicationAt: 'cuoora'.
app sessionClass: UserSession.
""
"
Class {
	#name : #HomeComponent,
	#superclass : #CommonPageComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #callbacks }
HomeComponent >> newQuestion [
	self call: NewQuestionComponent new
]

{ #category : #'rendering-elements' }
HomeComponent >> renderEmptyPageTitle: html [
	html paragraph
		class: 'italic';
		with:
			'...no hay preguntas relevantes. Añada tópicos de interés, o siga a otros usuarios.'
]

{ #category : #rendering }
HomeComponent >> renderNewQuestionButtonOn: html [
	html form
		class: 'newpost';
		with: [ html button
				class: 'newpost-button';
				callback: [ self newQuestion ];
				with: '+'.
			html span: 'Hacer una nueva pregunta' ]
]

{ #category : #rendering }
HomeComponent >> renderPageContentOn: aCanvas [
	"renderiza el botón para crear una pregunta, y la lista de preguntas relevantes para el usuario logeado"

	self renderNewQuestionButtonOn: aCanvas.
	self renderRelevantQuestionsOn: aCanvas
]

{ #category : #'rendering-elements' }
HomeComponent >> renderPageTitle: html [
	html heading
		level: 2;
		class: 'h2-alt';
		with: 'Preguntas relevantes'
]

{ #category : #rendering }
HomeComponent >> renderRelevantQuestionsOn: html [
	| rQuestions |
	(rQuestions := self userRelevantQuestions takeFirst: 5)
		ifEmpty: [ self renderEmptyPageTitle: html ]
		ifNotEmpty: [ self renderPageTitle: html.
			self renderQuestions: rQuestions on: html ]
]

{ #category : #'accessing-session' }
HomeComponent >> userRelevantQuestions [
	^ self session user relevantQuestions
		asSortedCollection: [ :a :b | a timestamp < b timestamp ]
]
