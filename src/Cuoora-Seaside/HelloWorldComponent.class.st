"
Clase de testing para Seaside
"
Class {
	#name : #HelloWorldComponent,
	#superclass : #WAComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #rendering }
HelloWorldComponent >> renderContentOn: anHtmlCanvas [
	anHtmlCanvas heading
		level: 1;
		with: 'Hello World!'
]
