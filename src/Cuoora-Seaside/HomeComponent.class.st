"
Componente que implementa el Home de la aplicacion
"
Class {
	#name : #HomeComponent,
	#superclass : #WAComponent,
	#category : #'Cuoora-Seaside'
}

{ #category : #rendering }
HomeComponent >> renderContentOn: aCanvas [
	aCanvas heading: 'Welcome ' , self session user username.
]
