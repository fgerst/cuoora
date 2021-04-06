"
Esta clase contiene el comportamiento e interfaz gráfica comunes a los diferentes componentes de la aplicación.
	El principal siendo el render del Header que es utilizado por todos los componentes, y por otro lado el rendering de Posts (Questions/Answers) que se reutiliza en HomeComponent, NewAnswerComponent, QuestionViewComponent y UserProfileComponent.
	También se logra tener una sola stylesheet que afectará a todos los componentes subclase.
"
Class {
	#name : #CommonPageComponent,
	#superclass : #WAComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #callbacks }
CommonPageComponent >> logout [
	self session unregister.
	self requestContext redirectTo: self application url
]

{ #category : #rendering }
CommonPageComponent >> renderContentOn: anHtmlCanvas [
	self renderHeaderOn: anHtmlCanvas.
	self renderPageContentOn: anHtmlCanvas
]

{ #category : #'rendering-header' }
CommonPageComponent >> renderHeaderNavBar: html [
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
CommonPageComponent >> renderHeaderOn: html [
	html div
		id: 'header';
		with: [ self renderHeaderTitle: html.
			self renderHeaderNavBar: html.
			self renderLogoutAnchor: html ].
	html horizontalRule
]

{ #category : #'rendering-header' }
CommonPageComponent >> renderHeaderTitle: html [
	html heading
		id: 'title';
		level1;
		with: [ html span with: 'CuOOra' ]
]

{ #category : #'rendering-header' }
CommonPageComponent >> renderLogoutAnchor: html [
	html anchor
		callback: [ self logout ];
		with: 'Log out'
]

{ #category : #rendering }
CommonPageComponent >> renderPageContentOn: anHtmlCanvas [
	self subclassResponsibility
]

{ #category : #'rendering-posts' }
CommonPageComponent >> renderPostReactionAnchors: aPost on: html [
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
CommonPageComponent >> renderPostVotes: aPost on: html [
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

{ #category : #'rendering-posts' }
CommonPageComponent >> renderQuestion: aQuestion on: html [
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

{ #category : #'rendering-posts' }
CommonPageComponent >> renderQuestionInfo: aQuestion on: html [
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

{ #category : #'rendering-posts' }
CommonPageComponent >> renderQuestions: questions on: html [
	html
		orderedList: [ questions
				do: [ :question | self renderQuestion: question on: html ] ]
]

{ #category : #'rendering-header' }
CommonPageComponent >> renderSeparator: html [
	html span
		id: 'title-separator';
		with: '|'
]

{ #category : #styles }
CommonPageComponent >> style [ 

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
	background-color: #60b327;
	color: white;
   text-align: center;
	font-size: 18px;
	padding: 1px 8px 1px 8px;
	box-shadow: 1px 2px 4px #888888;
	border-radius: 12px;
	border: none;
	margin-right: 6px;
	cursor: pointer;
}

.newpost-p { 
	text-align: right;
	padding: 6px 0 0 0;
	margin: 0;
}

.submit-button { 
	color: white;
	background-color: #1fa3ff;
	border-radius: 8px;
	border: none;
	cursor: pointer;
	padding: 4px 6px 4px 6px;
	margin: 0 0 15px 0;
}

.link-alt { color: black; }

.h2-alt { margin: 0 12px 0 12px; }

.bold { font-weight: 600; }

.italic { font-style: italic; }

.medium { font-size: 20px; } 

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
