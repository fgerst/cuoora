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
	self session logoutUser.
	self session unregister.
	self requestContext redirectTo: self application url
]

{ #category : #'rendering-header' }
CommonPageComponent >> renderBackAnchor: html [
	html anchor
		callback: [ self answer ];
		with: '🡠 Back'
]

{ #category : #rendering }
CommonPageComponent >> renderContentOn: aCanvas [
	"renderContentOn de CommonPageComponent renderiza el header y luego delega el contenido de la página a la subclase que fue instanciada"
	self renderHeaderOn: aCanvas.
	self renderPageContentOn: aCanvas
]

{ #category : #'rendering-posts' }
CommonPageComponent >> renderDislikeAnchor: aPost on: html [
	html anchor
		callback: [ aPost dislikeFrom: self session user ];
		with: 'dislike'
]

{ #category : #'rendering-posts' }
CommonPageComponent >> renderDislikeCount: count on: html [
	html span
		class: 'red-text';
		with: count.
	html span with: ' dislikes'
]

{ #category : #'rendering-header' }
CommonPageComponent >> renderHeaderNavBar: html [
	html
		unorderedList: [ 
			html listItem with: [ self renderSeparator: html ].
			html listItem with: [ self renderUserAnchor: self session user on: html ].
			html listItem with: [ self renderHomeAnchor: html ].
			html listItem with: [ self renderBackAnchor: html ].
			html listItem with: [ self renderSeparator: html ] ]
]

{ #category : #rendering }
CommonPageComponent >> renderHeaderOn: aCanvas [
	"renderiza el header, se divide en 3 metodos para legibilidad"

	aCanvas div
		id: 'header';
		with: [ self renderHeaderTitle: aCanvas.
			self renderHeaderNavBar: aCanvas.
			self renderLogoutAnchor: aCanvas ].
	aCanvas horizontalRule
]

{ #category : #'rendering-header' }
CommonPageComponent >> renderHeaderTitle: html [
	html heading
		id: 'title';
		level1;
		with: [ html span with: 'CuOOra' ]
]

{ #category : #'rendering-header' }
CommonPageComponent >> renderHomeAnchor: html [
	html anchor
		callback: [ self call: HomeComponent new ];
		with: 'Home'
]

{ #category : #'rendering-posts' }
CommonPageComponent >> renderLikeAnchor: aPost on: html [
	html anchor
		callback: [ aPost likeFrom: self session user ];
		with: 'like'
]

{ #category : #'rendering-posts' }
CommonPageComponent >> renderLikeCount: count on: html [
	html span
		class: 'green-text';
		with: count.
	html span with: ' likes | '
]

{ #category : #'rendering-header' }
CommonPageComponent >> renderLogoutAnchor: html [
	html anchor
		callback: [ self logout ];
		with: 'Log out'
]

{ #category : #rendering }
CommonPageComponent >> renderPageContentOn: aCanvas [
	self subclassResponsibility
]

{ #category : #'rendering-posts' }
CommonPageComponent >> renderPostReactionAnchors: aPost on: html [
	html paragraph
		with: [ self renderLikeAnchor: aPost on: html.
			html span with: ' | '.
			self renderDislikeAnchor: aPost on: html ]
]

{ #category : #'rendering-posts' }
CommonPageComponent >> renderPostVotes: aPost on: html [
	html paragraph
		with: [ self renderLikeCount: aPost likeCount on: html.
			self renderDislikeCount: aPost dislikeCount on: html ]
]

{ #category : #'rendering-questions' }
CommonPageComponent >> renderQuestion: aQuestion on: html [
	"renderiza una pregunta, se divide en metodos para legibildiad"

	html div
		class: 'post-div';
		with: [ self renderQuestionTitleAnchor: aQuestion on: html.
			self renderQuestionInfo: aQuestion on: html.
			self renderPostVotes: aQuestion on: html.
			self renderPostReactionAnchors: aQuestion on: html.
			html horizontalRule ]
]

{ #category : #'rendering-questions' }
CommonPageComponent >> renderQuestionAnswerCount: answerCount on: html [
			html span: ' | '.
			html span: answerCount.
			html span: ' respuestas'
]

{ #category : #'rendering-questions' }
CommonPageComponent >> renderQuestionAuthor: anUser on: html [
	html span: 'Realizada por '.
	self renderUserAnchor: anUser on: html
]

{ #category : #'rendering-questions' }
CommonPageComponent >> renderQuestionInfo: aQuestion on: html [
	self renderQuestionTopics: (aQuestion relatedTopics) on: html.
	html paragraph
		with: [ self renderQuestionAuthor: (aQuestion author) on: html.
			self renderQuestionAnswerCount: (aQuestion answersCount) on: html ]
]

{ #category : #'rendering-questions' }
CommonPageComponent >> renderQuestionTitleAnchor: aQuestion on: html [
	html anchor
		class: 'link-alt italic bold';
		callback: [ self viewQuestion: aQuestion ];
		with: aQuestion title
]

{ #category : #'rendering-questions' }
CommonPageComponent >> renderQuestionTopics: topics on: html [
	html paragraph
		class: 'italic grey';
		with: 'Tópicos: ', (self topicNames: topics).
]

{ #category : #'rendering-questions' }
CommonPageComponent >> renderQuestions: questions on: html [
	"renderiza una lista de preguntas"

	html
		orderedList:
			[ questions do: [ :question | self renderQuestion: question on: html ] ]
]

{ #category : #'rendering-header' }
CommonPageComponent >> renderSeparator: html [
	html span
		id: 'title-separator';
		with: '|'
]

{ #category : #'rendering-elements' }
CommonPageComponent >> renderUserAnchor: anUser on: html [
	html anchor
		class: 'bold link-alt';
		callback: [ self viewProfile: anUser ];
		with: anUser profileName
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

.newpost { 
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
	margin: 4px 0 15px 0;
}

.text-area { 
	height: 250px;
	width: 75%;
	font-family: sans-serif;
}

.post-div { 
	padding: 6px;
	max-width: 800px;
	margin: auto;
}

.text-input { width: 75%; }

.link-alt { color: black; }

.h2-alt { margin: 0 12px 6px 12px; }

.bold { font-weight: 600; }

.grey { color: gray; }

.italic { font-style: italic; }

.medium { font-size: 20px; } 

.small { font-size: 16px; }

.width-800 { max-width: 800px; margin: auto; }

.center { text-align: center; }

.green-text { color: green;}

.red-text { color: #9e0000; }

a { text-decoration: none; color: #0f61bf; } 

a:hover { text-decoration: underline; }

hr { opacity: 0.6; }

'
]

{ #category : #utilities }
CommonPageComponent >> topicNames: topics [
	"recibe una coleccion de topicos y los formatea en un String separados por coma"

	| names |
	names := String
		streamContents: [ :str | 
			topics
				do: [ :topic | 
					str
						nextPutAll: topic name asString;
						nextPutAll: ', ' ] ].
	"elimina ultimo separador (coma y espacio)"
	^ names truncateTo: names size - 2
]

{ #category : #callbacks }
CommonPageComponent >> viewProfile: anUser [
	self call: (UserProfileComponent newWithUserProfile: anUser)
]

{ #category : #callbacks }
CommonPageComponent >> viewQuestion: aQuestion [
	self call: (QuestionViewComponent newWithQuestion: aQuestion)
]
