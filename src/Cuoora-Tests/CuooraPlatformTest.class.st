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
	"Hooks that subclasses may override to define the fixture of test."
	
super setUp.
cuoora := CuooraPlatform new.
cuoora newTopic: ( Topic withName: 'python' description: 'ada' ).
cuoora newTopic: ( Topic withName: 'c++' description: 'ada' ).
cuoora newTopic: ( Topic withName: 'Ada' description: 'ada' ).

cuoora newUser: ( User withUsername: 'Juan' password: '123' )
]

{ #category : #tests }
CuooraPlatformTest >> testAdd [
| aUser aTopic |

aUser := User withUsername: 'name' password: 'pass'.
self assert: ( cuoora newUser: aUser ) equals: ( aUser ).
self assert: ( cuoora users includes: aUser ).


aTopic := Topic withName: 'smalltalk' description: 'desc'.
self assert: ( cuoora newTopic: aTopic ) equals: ( aTopic ).
self assert: ( cuoora topics includes: aTopic ).
]

{ #category : #tests }
CuooraPlatformTest >> testUsernameProtectedBy [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	self deny: ( cuoora username: 'Juan' protectedBy: '123' ) equals: ( nil ).
	self assert: ( cuoora username: 'Pedro' protectedBy: '123' ) equals: ( nil ).
	self assert: ( cuoora username: 'Juan' protectedBy: '124' ) equals: ( nil ).
]
