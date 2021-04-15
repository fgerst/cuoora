Class {
	#name : #CuooraPlatformTest,
	#superclass : #TestCase,
	#instVars : [
		'cuoora'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
CuooraPlatformTest >> setUp [
	super setUp.
	cuoora := CuooraPlatform new.

	"usuarios"
	cuoora newUser: (User withUsername: 'Juan' password: '123').

	"topicos"
	cuoora
		newTopic: (Topic withName: 'Python' description: 'Lorem ipsum');
		newTopic: (Topic withName: 'C++' description: 'Lorem ipsum');
		newTopic: (Topic withName: 'Ada' description: 'Lorem ipsum')
]

{ #category : #tests }
CuooraPlatformTest >> testNewTopic [
	| t1 |
	t1 := Topic withName: 'Smalltalk' description: 'Lorem Ipsum'.
	"setUp agregó 3 topicos"
	self assert: cuoora topics size equals: 3.
	self assert: (cuoora newTopic: t1) equals: t1.
	self assert: (cuoora topics includes: t1).
	self assert: cuoora topics size equals: 4
]

{ #category : #tests }
CuooraPlatformTest >> testNewUser [
	| u1 |
	u1 := User withUsername: 'Tomas' password: '123'.
	"setUp agregó 1 usuario"
	self assert: cuoora users size equals: 1.
	self assert: (cuoora newUser: u1) equals: u1.
	self assert: (cuoora users includes: u1).
	self assert: cuoora users size equals: 2
]

{ #category : #tests }
CuooraPlatformTest >> testParseTopics [
| str |

"existen Python, C++ y Ada"
str := 'Python,C++,Ada'.
self assert: (cuoora parseTopics: str) size equals: (3).
str := 'Python,C++'.
self assert: (cuoora parseTopics: str) size equals: (2).
str := 'Python,Smalltalk'.
self assert: (cuoora parseTopics: str) size equals: (1).
str := 'Smalltalk'.
self assert: (cuoora parseTopics: str) size equals: (0).
str := 'Smalltalk,Python,Java,Python,Python,c++'.
self assert: (cuoora parseTopics: str) size equals: (2).
]

{ #category : #tests }
CuooraPlatformTest >> testUsernameProtectedBy [
	"existe 'username: Juan password: 123'"
	self deny: ( cuoora username: 'Juan' protectedBy: '123' ) equals: ( nil ).
	self assert: ( cuoora username: 'Juan' protectedBy: '124' ) equals: ( nil ).
	self assert: ( cuoora username: 'Pedro' protectedBy: '123' ) equals: ( nil )

]
