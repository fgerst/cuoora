"
Componente que implementa el Home de la aplicacion
"
Class {
	#name : #HomeComponent,
	#superclass : #WAComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #callbacks }
HomeComponent >> logout [
	self session logoutUser.
	self answer
]

{ #category : #rendering }
HomeComponent >> renderContentOn: anHtmlCanvas [
	self renderHeaderOn: anHtmlCanvas.
	self renderNewQuestionButtonOn: anHtmlCanvas.
	self renderRelevantQuestionsOn: anHtmlCanvas
]

{ #category : #'rendering-topbar' }
HomeComponent >> renderHeaderNavBar: html [
	html
		unorderedList: [ html listItem with: [ self renderSeparator: html ].
			html listItem
				with: [ html anchor
						class: 'link-alt bold';
						callback: [ nil ];
						with: self session loggedUsername ].
			html listItem
				with: [ html anchor
						callback: [ nil ];
						with: 'Home' ].
			html listItem with: [ self renderSeparator: html ] ]
]

{ #category : #rendering }
HomeComponent >> renderHeaderOn: aCanvas [
	aCanvas div
		id: 'header';
		with: [ self renderHeaderTitle: aCanvas.
			self renderHeaderNavBar: aCanvas.
			self renderLogoutAnchor: aCanvas ].
	aCanvas horizontalRule
]

{ #category : #'rendering-topbar' }
HomeComponent >> renderHeaderTitle: html [
	html heading
		id: 'title';
		level1;
		with: [ html span with: 'CuOOra' ]
]

{ #category : #'rendering-topbar' }
HomeComponent >> renderLogoutAnchor: html [
	html anchor
		callback: [ self logout ];
		with: 'Log out'
]

{ #category : #'rendering-questions' }
HomeComponent >> renderNewQuestionButtonOn: html [
	html paragraph
		class: 'newpost-p';
		with: [ html button
				class: 'newpost-button';
				callback: [ nil ];
				with: '+'.
			html space.
			html span: 'Hacer una nueva pregunta' ]
]

{ #category : #'rendering-posts' }
HomeComponent >> renderPostReactionAnchors: aPost on: html [
	html paragraph
		with: [ html anchor
				callback: [ aPost likeFrom: self session user ];
				with: 'like'.
			html span with: ' | '.
			html anchor
				callback: [ aPost dislikeFrom: self session user ];
				with: 'dislike' ]
]

{ #category : #'rendering-posts' }
HomeComponent >> renderPostVotes: aPost on: html [
	html paragraph
		with: [ html span
				class: 'green-text';
				with: aPost likeCount.
			html span with: ' likes'.
			html span with: ' | '.
			html span
				class: 'red-text';
				with: aPost dislikeCount.
			html span with: ' dislikes' ]
]

{ #category : #'rendering-questions' }
HomeComponent >> renderQuestion: aQuestion on: html [
	html div
		class: 'question-div';
		with: [ html paragraph
				class: 'italic bold';
				with: aQuestion title.
			self renderQuestionInfo: aQuestion on: html.
			self renderPostVotes: aQuestion on: html.
			self renderPostReactionAnchors: aQuestion on: html.
			html horizontalRule ]
]

{ #category : #'rendering-questions' }
HomeComponent >> renderQuestionInfo: aQuestion on: html [
	html paragraph
		with: [ html span: 'Realizada por '.
			html anchor
				class: 'bold link-alt';
				callback: [ nil ];
				with: aQuestion author username.
			html span: ' | '.
			html span: aQuestion answersCount.
			html span: ' respuestas' ]
]

{ #category : #'rendering-questions' }
HomeComponent >> renderQuestions: questions on: html [
	html
		orderedList: [ questions
				do: [ :question | self renderQuestion: question on: html ] ]
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

{ #category : #'rendering-topbar' }
HomeComponent >> renderSeparator: html [
	html span
		id: 'title-separator';
		with: '|'
]

{ #category : #styles }
HomeComponent >> style [
	^ '
	
body { 
	font-family: sans-serif;
   padding: 8px;
	max-width: 900px;
   margin: auto; 
	font-size: 15px;
}

#title { 
	display: inline;
	color: #2ea1ff;
	font-weight: 400;
}

#title-separator { 
	color: black;
	font-weight: 400;
	font-size: 30px;
	padding: 6px;
}

ul { 
	display: inline;
	padding: 6px;
 }

li { 
	display: inline;
	padding: 6px;
}

ol { 
	padding: 0;
	margin: 0;
}

p { 
	margin-top: 6px;
	margin-bottom: 6px;
}

.newpost-button { 
	background-color: #2bad5d;
	color: white;
   text-align: center;
	font-size: 18px;
	padding: 1px 8px 1px 8px;
	box-shadow: 2px 4px 4px #888888;
	border-radius: 10px;
	border: none;
	margin-right: 0;
	margin-left: auto;
	cursor: pointer;
}

.newpost-p { 
	text-align: right;
	padding: 6px 0 0 0;
	margin: 0;
}

.link-alt { color: black; }

.h2-alt { margin: 12px; }

.bold { font-weight: 600; }

.italic { font-style: italic; }

.question-div { 
	padding: 6px;
	max-width: 800px;
	margin: auto;
}

.green-text { color: green;}

.red-text { color: #9e0000; }

a {  
	text-decoration: none;
	color: #0f61bf;
} 

a:hover { text-decoration: underline; }

hr { opacity: 0.6; }

'
]
