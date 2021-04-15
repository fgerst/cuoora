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
		't1',
		't2'
	],
	#category : #'Cuoora-Tests'
}

{ #category : #running }
UserTest >> setUp [
	super setUp.
	
	anUser1 := User withUsername: 'name1' password: 'word1'.
	anUser2 := User withUsername: 'name2' password: 'word2'.
	anUser3 := User withUsername: 'name3' password: 'word3'.
	
	t1 := Topic withName: 'Python' description: 'contenido Python'.
	t2 := Topic withName: 'C' description: 'contenido C'.
	
	q1 := Question withAuthor: anUser1 title: 'Question 1' content: 'content 1' topics: { t1 }.
	q2 := Question withAuthor: anUser2 title: 'Question 2' content: 'content 2' topics: { t2 }.
	
	a1 := Answer withAuthor: anUser1 content: 'content 3'.
	a2 := Answer withAuthor: anUser2 content: 'content 4'.
	
	anUser1 newQuestion: q1. 
	anUser2 newQuestion: q2.
	
	q1 newAnswer: a2. 
	q2 newAnswer: a1.
	
	
	
	
	
	
]

{ #category : #tests }
UserTest >> testAddAnswer [
	"El metodo User>>addAnswer agrega una respuesta hecha por el usuario a su coleccion de respuestas propias. Es llamado desde Question>>newQuestion()"
	
	"Nos aseguramos de que las preguntas agregadas en el setUp esten dentro de las colecciones apropiadas"
	self assert: anUser1 answers size equals: 1.
	self assert: anUser2 answers size equals: 1.
	self assert: anUser3 answers size equals: 0.
	self assert: ( anUser1 answers includes: a1 ).
	self assert: ( anUser2 answers includes: a2 ).
	self deny: ( anUser2 answers includes: a1 ).
	self deny: ( anUser3 answers includes: a2 ).
	
	"Utilizando el metodo addAnswer() directamente podemos agregar respuestas al Usuario saltandonos la pregunta (se repiten respuestas para el testcase)"
	anUser1 addAnswer: a1. 
	anUser2 addAnswer: a2.
	
	self assert: anUser1 answers size equals: 2.
	self assert: anUser2 answers size equals: 2.
]

{ #category : #tests }
UserTest >> testAddFollowing [
	"El metodo User>>addFollowing recibe otro usuario como parametro y lo agrega a la coleccion usuarios a los que el usuario sigue"
	
	"Nos aseguramos de que la coleccion de seguidos (following) este vacia"
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
	
	anUser1 addInterest: t1.
	anUser1 addInterest: t2.
	anUser2 addInterest: t1.
	self assert: anUser1 interests size equals: 2.
	self assert: anUser2 interests size equals: 1.
	self assert: (anUser2 interests includes: t1).
	self assert: anUser3 interests size equals: 0.
]

{ #category : #tests }
UserTest >> testDeleteMyAnswer [
	"El metodo User>>deleteMyAnswer() se lo llama desde Answer>>delete() cuando se elimina una pregunta para limpiar la referencia a una respuesta en el User."

	"Si se le envia como parametro una respuesta que no este en la coleccion del usuario devuelve nil"
	self assert: (anUser1 deleteMyAnswer: a2) equals: nil.

	"Le enviamos una respuesta que esta en la coleccion del usuario y vemos que es eliminada"
	self assert: (anUser1 answers includes: a1).
	self assert: (anUser1 answers size) equals: 1.
	anUser1 deleteMyAnswer: a1.
	self deny: (anUser1 answers includes: a1).
	self assert: (anUser1 answers size) equals: 0.
]

{ #category : #tests }
UserTest >> testDeleteMyQuestion [
	"Test>>DeleteMyQuestion() elimina la pregunta del usuario y de los topicos relacionados, junto con todas sus respuestas y referencias a las mismas en usuarios."
			
	"Si se manda una pregunta que el usuario no tiene para eliminar se devuelve nil"
	self assert: ( anUser1 deleteMyQuestion: q2 ) equals: ( nil ).
	
	"Primero nos aseguramos que el usuario anUser1 tenga la pregunta q1 y su respuesta a1 entre sus preguntas y respuestas; ademas de que q1 	pertenece al topico t1"
	self assert: ( anUser1 questions includes: q1 ).
	self assert: ( anUser2 answers includes: a2 ).
	self assert: ( t1 topicQuestions includes: q1 ).
	
	"Ahora eliminamos la pregunta y vemos que referencias en Topic y en User son eliminadas."
	anUser1 deleteMyQuestion: q1.
	self deny:  ( anUser1 questions includes: q1 ).
	self deny: ( anUser2 answers includes: a2 ).
	self deny: ( t1 topicQuestions includes: q1 ).
]

{ #category : #tests }
UserTest >> testIsFollowing [
	"El metodo User>>isFollowing() recibe un usario como parametro y se asegura si el usuario enviado como parametro es seguido por el usuario al que se le mando el mensaje"
	
	"Primero nos aseguramos de que anUser1 no siga a anUser2"
	self deny: ( anUser1 isFollowing: anUser2 ) .
	
	"Despues nos aseguramos de que si lo empieza a seguir ahora devuelva true"
	anUser1 addFollowing: anUser2.
	self assert: ( anUser1 isFollowing: anUser2 ) .
]

{ #category : #tests }
UserTest >> testNewQuestion [
	"User>>newQuestion() es un metodo que añade una pregunta dada a la coleccion de preguntas propias del usuario y a los topicos correspondientes."
	
	"Comprobamos que en el setUp User>>newQuestion() haya agregado las preguntas correctamente"
	self assert: ( anUser2 questions size ) equals: 1.
	self assert: ( anUser3 questions size ) equals: 0.
	self assert: ( anUser2 questions includes: q2 ).
	
	"Comprobamos que si User>>newQuestion() agrega otra pregunta entonces se consolida el cambio"
	self assert: ( anUser1 newQuestion: q2 ) equals: ( q2 ).
	self assert: ( anUser1 questions size ) equals: 2.
	self assert: ( anUser3 newQuestion: q2 ) equals: ( q2 ).
	self assert: ( anUser3 questions size ) equals: 1.
]

{ #category : #tests }
UserTest >> testRelevantQuestions [
	"User>>RelevantQuestions() devuelve todas las preguntas que pertenezcan a los topicos interesantes para el usuario y las preguntas que hayan hecho los usuarios que este siguiendo."
		
	| q3 |
	q3 := Question withAuthor: anUser3 title: 'Question 3' content: 'content 3' topics: { }.
	
	"Comprobamos que si un usuario anUser1 no esta siguiendo a nadie ni tiene intereses User>>relevantQuestions() devuelve una lista vacia"
	self assert: ( anUser1 relevantQuestions isEmpty ).
	
	"Si agregamos a un usuario anUser2 a los usuarios que anUser1 sigue, entonces User>>relevantQuestions() devolvera una coleccion incluyendo las preguntas de ese usuario"
	anUser1 addFollowing: anUser2.
	self assert: ( anUser1 relevantQuestions includes: q2 ).
	self assert: ( anUser1 relevantQuestions size) equals: 1.
	
	"Si agregamos intereses a los intereses de anUser1, entonces User>>relevantQuestions() devolvera una coleccion incluyendo las preguntas de este topico ademas de las de los usuarios seguidos, y sin preguntas repetidas"
	anUser1 addInterest: ( t1 ); addInterest: t2.
	self assert: ( anUser1 relevantQuestions includes: q1).
	self deny: ( anUser1 relevantQuestions includes: q3 ).
	self assert: ( anUser1 relevantQuestions size) equals: 2.
]

{ #category : #tests }
UserTest >> testUserScore [
	| q3 a3 |
	"User>>userScore() calcula el puntaje del User segun sus participaciones"

	"En el setup se declara que cada User hizo una pregunta (+20) y tiene una respuesta a la pregunta del otro (+50). anUser3 no tiene participaciones"
	self assert: anUser1 userScore equals: 70.
	self assert: anUser2 userScore equals: 70.
	self assert: anUser3 userScore equals: 0.

	"se le dan 2 likes a la pregunta que hizo anUser1, entonces su userScore sumara 2 puntos"
	q1 likeFrom: anUser2.
	q1 likeFrom: anUser3.
	self assert: anUser1 userScore equals: 72.

	"q1 recibe un dislike del mismo usuario que le dio like, se resta un like y se suma un dilike, quitando 2 puntos. Si ademas le damos dos dislikes de ususarios que antes no tenian like o dislike a la respuesta de anUser1, esto quitara otros 2 puntos."
	q1 dislikeFrom: anUser2.
	a1 dislikeFrom: anUser2.
	a1 dislikeFrom: anUser3.
	self assert: anUser1 userScore equals: 68.

	"Otro dislike a la respuesta de anUser1 de un usuario que ya habia dado dislike sumará un punto al userScore (se quita el dislike). Un like de anUser3 que antes tenia un dislike en la respuesta 1, deshara el dislike y agregara un like, sumando 2 puntos a la user Score del usuario 1"
	a1 dislikeFrom: anUser2.
	a1 likeFrom: anUser3.
	self assert: anUser1 userScore equals: 71.

	"anUser3 realiza una pregunta (+20) y se responde a sí mismo (+0)"
	q3 := Question withAuthor: anUser3 title: 'Question' content: 'content' topics: { }.
	a3 := Answer withAuthor: anUser3 content: 'content'.
	anUser3 newQuestion: q3.
	q3 newAnswer: a3.
	self assert: anUser3 userScore equals: 20.
]
