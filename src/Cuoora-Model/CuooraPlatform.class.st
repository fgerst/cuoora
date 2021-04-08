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
	| cuoora t1 t2 t3 u1 u2 u3 q1 q2 q3 a1 a2 |
	cuoora := CuooraPlatform new.
	"creacion de topicos"
	t1 := cuoora
		newTopic: (Topic withName: 'Python' description: 'Python').
	t2 := cuoora newTopic: (Topic withName: 'Java' description: 'Java').
	t3 := cuoora
		newTopic: (Topic withName: 'Smalltalk' description: 'Smalltalk').
	"creacion de users"
	u1 := cuoora newUser: (User withUsername: 'Franco' password: '123').
	u2 := cuoora newUser: (User withUsername: 'Tomas' password: '123').
	u3 := cuoora newUser: (User withUsername: 'Juan' password: '123').
	"creacion de preguntas"
	q1 := cuoora
		newQuestion:
			(Question
				withAuthor: u1
				title: '¿Para que sirve el método setUp en un Test Case?'
				content: 'Lorem ipsum lorem ipsum')
		withTopics:
			{t1.
			t2}.
	q2 := cuoora
		newQuestion:
			(Question
				withAuthor: u2
				title: '¿Qué significa #MessageNotUnderstood?'
				content: 'Lorem ipsum lorem ipsum')
		withTopics: {t3}.
	q3 := cuoora
		newQuestion:
			(Question
				withAuthor: u3
				title: '¿Como imprimo en consola en Java?'
				content: 'Lorem ipsum lorem ipsum')
		withTopics: {t2}.
	"creacion de respuestas"
	a1 := q1 newAnswer: (Answer withAuthor: u2 content: 'Sos un boludo').
	a2 := q1
		newAnswer: (Answer withAuthor: u3 content: 'Tomatela te dije').
	"intereses"
	u2
		addInterest: t1;
		addInterest: t2;
		addInterest: t3.
	u1 addInterest: t2.
	"likes y dislikes"
	q1 likeFrom: u2.
	q1 dislikeFrom: u3.
	a1 dislikeFrom: u1.
	q2 likeFrom: u1.
	q3 dislikeFrom: u1.
	q3 dislikeFrom: u3.
	^ cuoora
]

{ #category : #'instance creation' }
CuooraPlatform class >> soleInstance [
	^ soleInstance ifNil: [ soleInstance := self instanceWithData ]
]

{ #category : #'adding/removing' }
CuooraPlatform >> deleteQuestion: aQuestion [
"Este metodo es inutil creo"
	users do: [ :each | each deleteMyQuestion: aQuestion ]
]

{ #category : #'adding/removing' }
CuooraPlatform >> deleteTopicQuestions: aTopic [
	users do: [ :each | each deleteTopicQuestion: aTopic ]
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

{ #category : #users }
CuooraPlatform >> username: anUsername protectedBy: aPassword [
	| user |
	user := users
		detect: [ :each | each username = anUsername & (each password = aPassword) ]
		ifNone: [ nil ].
	user.
	^ user
]

{ #category : #users }
CuooraPlatform >> usernameExists: anUsername [
	^ users anySatisfy: [ :each | each username = anUsername ]
]

{ #category : #accesing }
CuooraPlatform >> users [
	^ users
]

{ #category : #accesing }
CuooraPlatform >> validatingStringTopics: stringOfTopicNamesSeparatedBySpaces [

| validTopics topicNames|

topicNames := topics collect: [ :each | ( each name ) asLowercase ].
validTopics := ( stringOfTopicNamesSeparatedBySpaces splitOn: ' ' ).
validTopics := validTopics select: [ :each | topicNames includes: (each asLowercase) ].
^validTopics 
]
