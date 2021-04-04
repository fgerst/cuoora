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
	"#TODO"

	self answer
]

{ #category : #rendering }
HomeComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas
]

{ #category : #rendering }
HomeComponent >> renderHeaderOn: html [
	html div
		id: 'header';
		with: [ html heading
				id: 'title';
				level1;
				with: [ html span with: 'CuOOra '.
					html span
						id: 'title-separator';
						with: '|' ].
			html strong with: self session loggedUsername.
			html space.
			html space.
			self renderLogoutAnchor: html ].
	html horizontalRule
]

{ #category : #rendering }
HomeComponent >> renderLogoutAnchor: anHtmlCanvas [
	anHtmlCanvas anchor
		callback: [ self logout.
			self answer ];
		with: 'Log out' 
]

{ #category : #rendering }
HomeComponent >> renderPostsOn: aCanvas [
	"TODO"

	^ nil
]

{ #category : #styles }
HomeComponent >> style [
	^ '
body { 
	font-family: sans-serif;
	margin: 12px;
   padding: 8px;
}

#title-separator { color: black; }

#title { 
	display: inline;
	padding: 8px;
	color: #1fa3ff;
	font-weight: 400;
}

a { text-decoration: none; } 

a:hover { text-decoration: underline; }

'
]
