"
Clase principal de la aplicacion
"
Class {
	#name : #CuooraPlatform,
	#superclass : #Object,
	#instVars : [
		'users',
		'topics'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : #'Cuoora-Model'
}

{ #category : #'instance creation' }
CuooraPlatform class >> clearSoleInstance [
	soleInstance := nil
]

{ #category : #'instance creation' }
CuooraPlatform class >> instanceWithData [
	| cuoora t1 t2 t3 u1 u2 u3 q1 q2 a1 a2 |
	cuoora := CuooraPlatform new.
	t1 := cuoora
		newTopic: (Topic withName: 'Python' description: 'Python').
	t2 := cuoora newTopic: (Topic withName: 'Java' description: 'Java').
	t3 := cuoora
		newTopic: (Topic withName: 'Smalltalk' description: 'Smalltalk').
	u1 := cuoora newUser: (User withUsername: 'Franco' password: '123').
	u2 := cuoora newUser: (User withUsername: 'Tomas' password: '123').
	u3 := cuoora newUser: (User withUsername: 'Juan' password: '123').
	q1 := cuoora
		newQuestion: (Question withAuthor: u1 title: 'Test1?' content: 'Test a')
		withTopics:
			{t1.
			t2}.
	q2 := cuoora
		newQuestion: (Question withAuthor: u2 title: 'Test2?' content: 'Test b')
		withTopics: {t3}.
	a1 := q1 newAnswer: (Answer withAuthor: u2 content: 'Sos un boludo').
	a2 := q1
		newAnswer: (Answer withAuthor: u3 content: 'Tomatela te dije').
	q1 likeFrom: u2.
	q1 likeFrom: u2.
	q1 dislikeFrom: u3.
	a1 dislikeFrom: u1.
	^ cuoora
]

{ #category : #'instance creation' }
CuooraPlatform class >> soleInstance [
	^ soleInstance ifNil: [ soleInstance := self instanceWithData ]
]

{ #category : #'adding/removing' }
CuooraPlatform >> deleteQuestion: aQuestion [
	topics do: [ :each | each deleteTopicQuestion: aQuestion ].
	aQuestion author deleteMyQuestion: aQuestion.
]

{ #category : #initialization }
CuooraPlatform >> initialize [
	users := OrderedCollection new.
	topics := OrderedCollection new
]

{ #category : #'adding/removing' }
CuooraPlatform >> newQuestion: aQuestion withTopics: topicList [
	aQuestion author addQuestion: aQuestion.
	topicList do: [ :each | each addTopicQuestion: aQuestion ].
	^ aQuestion
]

{ #category : #'adding/removing' }
CuooraPlatform >> newTopic: aTopic [
	topics add: aTopic.
	^ aTopic
]

{ #category : #'adding/removing' }
CuooraPlatform >> newUser: anUser [
	users add: anUser.
	^ anUser
]

{ #category : #accesing }
CuooraPlatform >> topics [
	^ topics
]

{ #category : #access }
CuooraPlatform >> username: anUsername protectedBy: aPassword [
	^ users
		detect: [ :each | each username = anUsername & (each password = aPassword) ]
		ifNone: [ nil ]
]

{ #category : #accesing }
CuooraPlatform >> users [
	^ users
]
