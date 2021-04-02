"
Clase que representa un voto a una publicacion (like o dislike)
"
Class {
	#name : #Vote,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'author',
		'isLike'
	],
	#category : #'Cuoora-Model'
}

{ #category : #accessing }
Vote >> author [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^author
]

{ #category : #accessing }
Vote >> author: anUser [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	author:= anUser
]

{ #category : #initialization }
Vote >> initialize [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	timestamp := DateAndTime now.
]

{ #category : #initialization }
Vote >> initialize: anAuthor [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	timestamp := DateAndTime now.
	author := anAuthor 
]

{ #category : #accessing }
Vote >> isLike [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^isLike 
]

{ #category : #initialization }
Vote >> setToDislike [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	isLike:= false
]

{ #category : #initialization }
Vote >> setToLike [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	isLike := true
]

{ #category : #accessing }
Vote >> timestamp [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^timestamp 
]
