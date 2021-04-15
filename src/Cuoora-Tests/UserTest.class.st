Class {
	#name : #UserTest,
	#superclass : #TestCase,
	#instVars : [
		'anUser1',
		'anUser2',
		'anUser3',
		'q1',
		'q2',
		'a1',
		'a2',
		'i1',
		'i2'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
UserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	anUser1 := User withUsername: 'name1' password: 'word1'.
	anUser2 := User withUsername: 'name2' password: 'word2'.
	anUser3 := User withUsername: 'name3' password: 'word3'.
	i1 := Topic withName: 'Python' description: 'contenido Python'.
	i2 := Topic withName: 'C' description: 'contenido C'.
	q1 := Question withAuthor: anUser1 title: 'Question 1' content: 'content 1' topics: { i1 }.
	q2 := Question withAuthor: anUser2 title: 'Question 2' content: 'content 2' topics: { i2 }.
	a1 := Answer withAuthor: anUser1 content: 'content 3'.
	a2 := Answer withAuthor: anUser3 content: 'content 4'.
	q1 newAnswer: a1. q2 newAnswer: a2.
	anUser1 newQuestion: q1. 
	anUser2 newQuestion: q2. anUser2 addAnswer: a1. anUser2 addAnswer: a2.
	
	
	
	
	
]

{ #category : #tests }
UserTest >> testAddAnswer [
	"El metodo User>>addAnswer agrega una respuesta hecha por el usuario a us coleccion de respuestas propias"
	
	"Nos aseguramos de que las preguntas agregadas en el setUp esten dentro de las colecciones apropiadas"
	self assert: anUser1 answers size equals: 1.
	self assert: anUser2 answers size equals: 2.
	self assert: anUser3 answers size equals: 1.
	self assert: ( anUser2 answers includes: a1 ).
	self assert: ( anUser2 answers includes: a2 ).
	self assert: ( anUser1 answers includes: a1 ).
	self assert: ( anUser3 answers includes: a2 ).
]

{ #category : #tests }
UserTest >> testAddFollowing [
	"El metodo User>>addFollowing recibe otro usuario como parametro y lo agrega a la coleccion de otros usuarios a los que el usuario sigue"
	
	"Nos aseguramos de que la coleccion de seguidos (flollowing) este vacia"
	self deny: ( anUser1 following includes: anUser2 ).
	self assert: ( anUser1 following size ) equals: 0.

	"Primero agregamos los usuarios como seguidos"
	self assert: ( anUser1 addFollowing: anUser2 ) equals: ( anUser1 ).
	self assert: ( anUser1 addFollowing: anUser3 ) equals: ( anUser1 ).
	self assert: ( anUser2 addFollowing: anUser3 ) equals: ( anUser2 ).
	
	"Luego constatamos los cambios que pasaron en la coleccion de seguidos"
	self assert: ( anUser1 following includes: anUser2 ).
	self assert: ( anUser1 following includes: anUser3 ).
	self assert: ( anUser2 following includes: anUser3 ).
	self assert: ( anUser1 following size ) equals: 2.
	self assert: ( anUser2 following size ) equals: 1.
	self assert: ( anUser3 following size ) equals: 0.
]

{ #category : #tests }
UserTest >> testAddinterest [
	"El metodo User>>addInterests agrega topicos a los intereses del usuario"
	
	anUser1 addInterest: i1.
	anUser1 addInterest: i2.
	anUser1 addInterest: i2.
	anUser2 addInterest: i1.
	self assert: anUser1 interests size equals: 3.
	self assert: anUser2 interests size equals: 1.
	self assert: anUser3 interests size equals: 0.
]

{ #category : #tests }
UserTest >> testDeleteMyAnswer [
	"El metodo User>>DeleteMyAnswer() se lo llama desde Answer>>delete() cuando se elimina una pregunta para de eliminar la respuesta que se le manda de la coleccion del usuario."
		
	"Si se le envia como parametro una respuesta que no este en la coleccion del usuario devuielve nil"	
	self assert: ( anUser1 deleteMyAnswer: a2 ) equals: ( nil ).
	
	"Le enviamos una respuesta que esta en la coleccion del usuario y vemos que es eliminada"
	self assert: ( anUser1 answers includes: a1 ).
	anUser1 deleteMyAnswer: a1.
	self assert: (( anUser1 answers includes: a1 ) not).
	
	
]

{ #category : #tests }
UserTest >> testDeleteMyQuestion [
	"Test>>DeleteMyQuestion() es un metodo que elimina la pregunta del usuario y todas sus respuestas de los respectivo usuarios y topicos. que le mandes como parametro y devuelve nil si no la encuentra."
			
	"Si se manda una pregunta que el usuario no tiene para eliminar se devuelve nil"
	self assert: ( anUser1 deleteMyQuestion: q2 ) equals: ( nil ).
	
	"Primero nos aseguramos que el usuario anUser1 tenga la pregunta q1 y su respuesta a1 entre sus preguntas y respuetsas; ademas de que q1 pertenece al topico i1"
	self assert: ( anUser1 questions includes: q1 ).
	self assert: ( anUser1 answers includes: a1 ).
	self assert: ( i1 topicQuestions includes: q1 ).
	
	"Ahora eliminamos la pregunta y vemos que su respuesta tambien es eliminada de donde aparecia."
	anUser1 deleteMyQuestion: q1.
	self deny:  ( anUser1 questions includes: q1 ).
	self deny: ( anUser1 answers includes: a1 ).
	self deny: ( i1 topicQuestions includes: q1 ).
]

{ #category : #tests }
UserTest >> testIsFollowing [
	"El metodo User>>isFollowing() recibe un usario como parametro y se asegura si el usuario enviado como parametro es seguido por el usuario al que se le mando el mensaje"
	
	"Primero nos aseguramos de que anUser1 no siga a anUser2"
	self deny: ( anUser1 isFollowing: anUser2 ) .
	
	"Despues nos aseguramos de que si lo empieza a seguir ahora devuelva positivo"
	anUser1 addFollowing: anUser2.
	self assert: ( anUser1 isFollowing: anUser2 ) .
]

{ #category : #tests }
UserTest >> testNewQuestion [
	"User>>newQuestion() es un metodo que añade una pregunta dada a la coleccion de preguntas propias del usuario."
	
	"Comprobamos que en el setUp User>>newQuestion() haya agregado las preguntas correctamente"
	self assert: ( anUser1 questions size ) equals: 1.
	self assert: ( anUser2 questions size ) equals: 1.
	self assert: ( anUser3 questions size ) equals: 0.
	self assert: ( anUser1 questions includes: q1 ).
	self assert: ( anUser2 questions includes: q2 ).
	self deny: ( anUser3 questions includes: q1 ).
	
	"Comprobamos que si User>>newQuestion() agrega otra pregunta entonces se consolida el cambio y que el metodo devuelve la pregunta enviada como parametro"
	self assert: ( anUser1 newQuestion: q2 ) equals: ( q2 ).
	self assert: ( anUser1 questions size ) equals: 2.
]

{ #category : #tests }
UserTest >> testRelevantQuestions [
	"User>>RelevantQuestions() es un metodo que devuelve todas las preguntas que pertenezcan a los topicos interesantes para el usuario y las preguntas que hayan hecho los usuarios que este siguiendo."
		
	| q3 |
	q3 := Question withAuthor: anUser3 title: 'Question 3' content: 'content 3' topics: { }.
	
	"Comprobamos que si un usuario anUser1 no esta siguiendo a nadie ni tinee intereses User>>relevantQuestions() devuelve una lista vacia"
	self assert: ( anUser1 relevantQuestions isEmpty ).
	
	"Si agregamos a un usuario anUser2 a los usuarios que anUser1 sigue, entonces User>>relevantQuestions() devolvera una coleccion incluyendo las preguntas de ese usuario"
	anUser1 addFollowing: anUser2.
	self assert: ( anUser1 relevantQuestions includes: q2 ).
	self deny: ( anUser1 relevantQuestions includes: q1 ).
	
	"Si agregamos a un interes i1 a los intereses de anUser1, entonces User>>relevantQuestions() devolvera una coleccion incluyendo las preguntas de este topico"
	i1 addTopicQuestion: q1.
	i2 addTopicQuestion: q2.
	anUser1 addInterest: ( i1 ).
	self assert: ( anUser1 relevantQuestions includes: q1).
	self deny: ( anUser1 relevantQuestions includes: q3 ).
	self assert: ( anUser1 relevantQuestions size) equals: 2.
]

{ #category : #tests }
UserTest >> testUserScore [
	"User>>userScore() es un metodo que recibe un usuario, y se retorna un puntaje que se
calcula en función de su actividad en la red social. Por cada pregunta realizada, suma 20
puntos, y por cada respuesta a una pregunta que realizó otro usuario, suma 50 puntos.
Además, se suma puntaje determinado por la diferencia entre likes y dislikes de todas
sus participaciones, que de tener mas dislikes que likes, puede ser negativo."
	"anUser1 tien una respuesta a su propia pregunta que no se cuenta, excepto para likes"
			
	"En el setup se declara que anUser1 hizo una pregunta (+20) y tiene una respuesta a su propia pregunta por lo que no cuenta para el +50 puntos, aunque sus likes y dislikes si se cuentan. anUser2 tiene una respuesta a otro usuario (+50) e hizo una pregunta (+20). Y anUser3 hizo una pregunta y n"
	self assert: ( anUser1 userScore ) equals: 20.
	self assert: ( anUser2 userScore ) equals: 70.
	self assert: ( anUser3 userScore ) equals: 50.
	
	"Si ahora se le dan 2 likes a la pregunta que hizo anUser1, entonces su userScore sumara 2 puntos"
	q1 likeFrom: anUser2.
	q1 likeFrom: anUser3.
	self assert: ( anUser1 userScore ) equals: 22.
	"Si ahora q1 recibe un dislike del mismo usuario que le dio like entonces se deshara el like previo y se agregara un dislike, quitando 2 puntos. Si ademas le damos dos dislikes de ususarios que antes no tenian like o dislike a la respuesta del usuario 1, esto quitara otros 2 puntos."
	q1 dislikeFrom: anUser2.
	a1 dislikeFrom: anUser2.
	a1 dislikeFrom: anUser3.
	self assert: ( anUser1 userScore ) equals: 18.
	"Otro dislike a la respuesta del usuario 1 de un usuario que ya habia dado dislike deshara el sidlike y agregara un punto a la user score del usuario 1. Un like del usuario 3 que antes tenia un dislike en la respuesta 1, deshara el dislike y agregara un like, sumando 2 puntos a la user Score del usuario 1"
	a1 dislikeFrom: anUser2.
	a1 likeFrom: anUser3.
	self assert: ( anUser1 userScore ) equals: 21.
]
