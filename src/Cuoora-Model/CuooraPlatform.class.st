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
	| cuoora t1 t2 t3 u1 u2 u3 q1 q2 |
	cuoora := CuooraPlatform new.
	
	"creacion de topicos"
	t1 := cuoora 
				newTopic: (Topic withName: 'OO1' description: 'Preguntas relacionadas a la materia "Progrmacion Orientada a Objetos 1".').
	t2 := cuoora 
				newTopic: (Topic withName: 'Test de unidad' description: 'Preguntas relacionadas a testing de unidad.').
	t3 := cuoora 
				newTopic: (Topic withName: 'Smalltalk' description: 'Preguntas relacionadas al lenguaje de programación Smalltalk').
				
	"creacion de users"
	u1 := cuoora newUser: (User withUsername: 'pedro@cuoora.com' password: 'pedro@cuoora.com').
	u2 := cuoora newUser: (User withUsername: 'diego@cuoora.com' password: 'diego@cuoora.com').
	u3 := cuoora newUser: (User withUsername: 'juan@cuoora.com' password: 'juan@cuoora.com').
	u1 profileName: 'Pedro'.
	u2 profileName: 'Diego'.
	u3 profileName: 'Juan'.
	
	"creacion de preguntas"
	q1 := u1
		newQuestion:
			(Question
				withAuthor: u1
				title: '¿Para qué sirve el método SetUp?'
				content: 'Lo encuentro cuando busco información sobre tests pero no entiendo que propósito cumple.'
				topics: {t1. t2}).
	q2 := u2
		newQuestion:
			(Question
				withAuthor: u2
				title: '¿Qué significa #messageNotUnderstood?'
				content: 'Me sale un error en Pharo Smalltalk y pone #messageNotUnderstood'
				topics: {t1. t3} ).
				
	"creacion de respuestas"
	q1 
		newAnswer: (Answer withAuthor: u2 content: 'Sirve para instanciar los objetos que son evaluados por el test en un único método y que se 		ejecute siempre antes de cada test.').
	q2
		newAnswer: (Answer withAuthor: u1 content: 'Significa que el objeto que recibió el mensaje no encontró ningún método para ejecutar en 		respuesta.').

	"follows"
	u3 addFollowing: u2.
	u1 addFollowing: u3.
	
	"intereses: no hay intereses en la instancia de prueba"
	
	"likes y dislikes: no hay likes en la instancia de prueba"
	
	^ cuoora
]

{ #category : #'instance creation' }
CuooraPlatform class >> instanceWithDataAux [
	| cuoora t1 t2 t3 u1 u2 u3 q1 q2 q3 a1 a2 |
	
	cuoora := CuooraPlatform new.
	
	"creacion de topicos"
	t1 := cuoora newTopic: (Topic withName: 'Python' description: 'Python').
	t2 := cuoora newTopic: (Topic withName: 'Java' description: 'Java').
	t3 := cuoora newTopic: (Topic withName: 'Smalltalk' description: 'Smalltalk').
	
	"creacion de users"
	u1 := cuoora newUser: (User withUsername: 'Franco' password: '123').
	u2 := cuoora newUser: (User withUsername: 'Tomas' password: '123').
	u3 := cuoora newUser: (User withUsername: 'Juan' password: '123').
	
	"creacion de preguntas"
	q1 := u1
		newQuestion:
			(Question
				withAuthor: u1
				title: '¿Para que sirve el método setUp en un Test Case?'
				content: 'Lorem ipsum lorem ipsum'
				topics: {t1. t2}).
	q2 := u2
		newQuestion:
			(Question
				withAuthor: u2
				title: '¿Qué significa #MessageNotUnderstood?'
				content: 'Lorem ipsum lorem ipsum'
				topics: {t3} ).
	q3 := u3
		newQuestion:
			(Question
				withAuthor: u3
				title: '¿Como imprimo en consola en Java?'
				content: 'Lorem ipsum lorem ipsum'
				topics: {t2}).
				
	"creacion de respuestas"
	a1 := q1 newAnswer: (Answer withAuthor: u2 content: 'Sos un bolud*').
	a2 := q1 newAnswer: (Answer withAuthor: u3 content: 'Tomatela te dije').
	
	"intereses"
	u2
		addInterest: t1;
		addInterest: t2;
		addInterest: t3.
	u1 addInterest: t2.
	
	"follows"
	u3 addFollowing: u1.
	
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

{ #category : #initialization }
CuooraPlatform >> initialize [
	users := OrderedCollection new.
	topics := OrderedCollection new
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

{ #category : #'validating-topics' }
CuooraPlatform >> parseTopics: aTopicListString [
	"devuelve los topicos ingresados que existan en el sistema"

	| names |
	names := aTopicListString asLowercase splitOn: ','.
	^ topics select: [ :topic | names includes: topic name asLowercase ]
]

{ #category : #accesing }
CuooraPlatform >> topics [
	^ topics
]

{ #category : #'validating-users' }
CuooraPlatform >> username: anUsername protectedBy: aPassword [
	| user |
	user := users
		detect: [ :each | each username = anUsername & (each password = aPassword) ]
		ifNone: [ nil ].
	^ user
]

{ #category : #accesing }
CuooraPlatform >> users [
	^ users
]
