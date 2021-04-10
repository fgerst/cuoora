"
Componente que implementa el Home de la aplicacion, donde se pueden ver las Preguntas Relevantes para el Usuario, y crear nuevas preguntas.
"
Class {
	#name : #HomeComponent,
	#superclass : #CommonPageComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #'rendering-questions' }
HomeComponent >> renderNewQuestionButtonOn: html [
	html form
		class: 'newpost-p';
		with: [ html button
				class: 'newpost-button';
				callback: [ self call: NewQuestionComponent new ];
				with: '+'.
			html span: 'Hacer una nueva pregunta' ]
]

{ #category : #rendering }
HomeComponent >> renderPageContentOn: aCanvas [
	self renderNewQuestionButtonOn: aCanvas.
	self renderRelevantQuestionsOn: aCanvas
]

{ #category : #rendering }
HomeComponent >> renderRelevantQuestionsOn: html [
	| rQuestions |
	(rQuestions := self userRelevantQuestions)
		ifEmpty: [ html paragraph
				class: 'italic';
				with:
					'...no hay preguntas relevantes. Añada tópicos de interés, o siga a otros usuarios.' ]
		ifNotEmpty: [ html heading
				level: 2;
				class: 'h2-alt';
				with: 'Preguntas relevantes'.
			self renderQuestions: rQuestions on: html ]
]

{ #category : #'accesing-session' }
HomeComponent >> userRelevantQuestions [
	^ self session user relevantQuestions
		asSortedCollection: [ :a :b | a timestamp < b timestamp ]
]
