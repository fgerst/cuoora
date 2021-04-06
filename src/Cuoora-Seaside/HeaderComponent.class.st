"
Esta clase se encargara de tener los procesos comunes a HomeComponent, NewQuestionComponent, QuestionReaderComponent y UserProfileComponent. El principal siendo el render del Header.
"
Class {
	#name : #HeaderComponent,
	#superclass : #WAComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #callbacks }
HeaderComponent >> logout [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^SubclassResponsibility 
]

{ #category : #rendering }
HeaderComponent >> renderContentOn: anHtmlCanvas [
	self renderHeaderOn: anHtmlCanvas.
]

{ #category : #'rendering-header' }
HeaderComponent >> renderHeaderNavBar: html [
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

{ #category : #'rendering-header' }
HeaderComponent >> renderHeaderOn: aCanvas [
	aCanvas div
		id: 'header';
		with: [ self renderHeaderTitle: aCanvas.
			self renderHeaderNavBar: aCanvas.
			self renderLogoutAnchor: aCanvas ].
	aCanvas horizontalRule
]

{ #category : #'rendering-header' }
HeaderComponent >> renderHeaderTitle: html [
	html heading
		id: 'title';
		level1;
		with: [ html span with: 'CuOOra' ]
]

{ #category : #'rendering-header' }
HeaderComponent >> renderLogoutAnchor: html [
	html anchor
		callback: [ self logout ];
		with: 'Log out'
]

{ #category : #'rendering-questions' }
HeaderComponent >> renderPostReactionAnchors: aPost on: html [
	html paragraph
		with: [ html anchor
				callback: [ aPost likeFrom: self session user ];
				with: 'like'.
			html span with: ' | '.
			html anchor
				callback: [ aPost dislikeFrom: self session user ];
				with: 'dislike' ]
]

{ #category : #'rendering-questions' }
HeaderComponent >> renderPostVotes: aPost on: html [
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
HeaderComponent >> renderQuestion: aQuestion on: html [
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
HeaderComponent >> renderQuestionInfo: aQuestion on: html [
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
HeaderComponent >> renderQuestions: questions on: html [
	html
		orderedList: [ questions
				do: [ :question | self renderQuestion: question on: html ] ]
]

{ #category : #rendering }
HeaderComponent >> renderSeparator: html [
	html span
		id: 'title-separator';
		with: '|'
]

{ #category : #hooks }
HeaderComponent >> style [ 

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

.link-alt { color: black; }

.h2-alt { margin: 0 12px 0 12px; }

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
