"
Componente que implementa el Home de la aplicacion
"
Class {
	#name : #HomeComponent,
	#superclass : #HeaderComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #callbacks }
HomeComponent >> logout [
	self session logoutUser.
	self answer
]

{ #category : #rendering }
HomeComponent >> renderContentOn: anHtmlCanvas [
	super renderContentOn: anHtmlCanvas.
	self renderNewQuestionButtonOn: anHtmlCanvas.
	self renderRelevantQuestionsOn: anHtmlCanvas
]

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
HomeComponent >> renderRelevantQuestionsOn: aCanvas [
	| rQuestions |
	(rQuestions := self session user relevantQuestions
		asSortedCollection: [ :a :b | a timestamp < b timestamp ])
		ifEmpty: [ aCanvas paragraph
				class: 'italic';
				with:
					'...no hay preguntas relevantes. Añada tópicos de interés, o siga a otros usuarios.' ]
		ifNotEmpty: [ aCanvas heading
				level: 2;
				class: 'h2-alt';
				with: 'Preguntas relevantes'.
			self renderQuestions: rQuestions on: aCanvas ]
]
