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
CuooraPlatformTest >> testUsernameProtectedBy [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	self deny: ( cuoora username: 'Juan' protectedBy: '123' ) equals: ( nil ).
	self assert: ( cuoora username: 'Pedro' protectedBy: '123' ) equals: ( nil ).
	self assert: ( cuoora username: 'Juan' protectedBy: '124' ) equals: ( nil ).
]

{ #category : #tests }
CuooraPlatformTest >> testvalidateStringTopics [
	self
		assert:
			((cuoora validateStringTopics: 'python LLL ada ADA AdA c++ kkk')
				includes: 'AdA').
	self
		assert:
			((cuoora validateStringTopics: 'python LLL ada ADA AdA c++ kkk')
				includes: 'c++').
	self
		assert:
			((cuoora validateStringTopics: 'python LLL ada ADA AdA c++ kkk')
				includes: 'ada').
	self
		assert:
			((cuoora validateStringTopics: 'python LLL ada ADA AdA c++ kkk')
				includes: 'python').
	self
		deny:
			((cuoora validateStringTopics: 'python LLL ada ADA AdA c++ kkk')
				includes: 'LLL').
	self
		deny:
			((cuoora validateStringTopics: 'python LLL ada ADA AdA c++ kkk')
				includes: 'kkk')
]
