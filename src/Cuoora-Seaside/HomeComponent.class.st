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
	self session logout.
	self call: LoginComponent new.
]

{ #category : #rendering }
HomeComponent >> renderContentOn: anHtmlCanvas [
	"#TODO *content(relevant questions)"

	self renderHeaderOn: anHtmlCanvas
]

{ #category : #'rendering-elements' }
HomeComponent >> renderHeaderNavBar: html [
	html
		unorderedList: [ html listItem with: [ self renderSeparator: html ].
			html listItem
				with: [ html anchor class: 'link-alt';
						callback: [ self call: HomeComponent new ];
						with: self session loggedUsername ].
			html listItem
				with: [ html anchor
						callback: [ self call: HomeComponent new ];
						with: 'Home' ].
			html listItem
				with: [ html anchor
						callback: [ self call: HomeComponent new ];
						with: 'Questions' ].
			html listItem
				with: [ html anchor
						callback: [ self call: HomeComponent new ];
						with: 'Users' ].
			html listItem with: [ self renderSeparator: html ] ]
]

{ #category : #rendering }
HomeComponent >> renderHeaderOn: html [
	html div
		id: 'header';
		with: [ self renderHeaderTitle: html.
			self renderHeaderNavBar: html.
			self renderLogoutAnchor: html ].
	html horizontalRule
]

{ #category : #'rendering-elements' }
HomeComponent >> renderHeaderTitle: html [
	html heading
		id: 'title';
		level1;
		with: [ html span with: 'CuOOra' ]
]

{ #category : #'rendering-elements' }
HomeComponent >> renderLogoutAnchor: anHtmlCanvas [
	anHtmlCanvas anchor
		class: 'link-alt';
		callback: [ self logout.
			self answer ];
		with: 'Log out'
]

{ #category : #rendering }
HomeComponent >> renderPostsOn: html [
	"TODO"

	^ nil
]

{ #category : #'rendering-utilities' }
HomeComponent >> renderSeparator: anHtmlCanvas [
	anHtmlCanvas span
		id: 'title-separator';
		with: '|'
]

{ #category : #styles }
HomeComponent >> style [
	^ '
body { 
	font-family: sans-serif;
   padding: 8px;
	max-width: 920px;
   margin: auto; 
}

#title { 
	display: inline;
	color: #1fa3ff;
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

.link-alt { 
	font-weight: 600;
	color: black;
 }

a {  text-decoration: none; } 

a:hover { text-decoration: underline; }

hr { opacity: 0.4; }

'
]
