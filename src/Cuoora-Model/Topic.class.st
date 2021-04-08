"
Clase que representa a los topicos
"
Class {
	#name : #Topic,
	#superclass : #Object,
	#instVars : [
		'name',
		'description'
	],
	#category : #'Cuoora-Model'
}

{ #category : #creation }
Topic class >> withName: aName description: aDesc [
	^ self new
		name: aName;
		description: aDesc;
		yourself
]

{ #category : #accesing }
Topic >> description [
	^ description
]

{ #category : #accesing }
Topic >> description: aString [
	description := aString
]

{ #category : #initialization }
Topic >> initialize [
	
]

{ #category : #accesing }
Topic >> name [
	^ name
]

{ #category : #accesing }
Topic >> name: aString [
	name := aString
]
