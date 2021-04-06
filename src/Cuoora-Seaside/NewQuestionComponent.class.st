"
Componente que implementa la agregacion de nuevas preguntas.
Va a venir directamente de HomeComponent, cuando apreta en el boton de ""+ Hacer nueva pregunta"".
"
Class {
	#name : #NewQuestionComponent,
	#superclass : #HeaderComponent,
	#instVars : [
		'titulo',
		'desarrollo',
		'topicos'
	],
	#category : #'Cuoora-Seaside'
}

{ #category : #callbacks }
NewQuestionComponent >> cancel [ 

	self answer
]

{ #category : #accessing }
NewQuestionComponent >> desarrollo [
	^ desarrollo
]

{ #category : #accessing }
NewQuestionComponent >> desarrollo: anObject [
	desarrollo := anObject
]

{ #category : #accessing }
NewQuestionComponent >> fieldsEmpty [

	^ titulo isEmpty | desarrollo isEmpty | topicos isEmpty
]

{ #category : #rendering }
NewQuestionComponent >> renderButtonsOn: aCanvas [
	"El guardado todavia no guarda"
	aCanvas form: [ 
		aCanvas space. aCanvas space.
		aCanvas submitButton
		class: 'submit-button';
		callback: [ self savingQuestion ];
		with: 'Guardar'.
		
		aCanvas space. aCanvas space.
		aCanvas submitButton
		class: 'submit-button';
		callback: [ self cancel ];
		with: 'Cancelar']
]

{ #category : #rendering }
NewQuestionComponent >> renderContentOn: anHtmlCanvas [
	super renderContentOn: anHtmlCanvas.
	self renderQuestionTitleOn: anHtmlCanvas.
	anHtmlCanvas horizontalRule.
	self renderImputTextOn: anHtmlCanvas.
	anHtmlCanvas horizontalRule.
	self renderButtonsOn: anHtmlCanvas
]

{ #category : #rendering }
NewQuestionComponent >> renderImputTextOn: aCanvas [
			
	aCanvas
		form: [ aCanvas space. aCanvas space.
			aCanvas text: 'Titulo:  '.
				aCanvas textInput
				placeholder: 'Escriba aqui el titulo de su pregunta';
				on: #titulo of: self ].
	aCanvas space.
	aCanvas
		form: [ aCanvas space. aCanvas space.
			aCanvas text: 'Desarrollo:'.
				aCanvas textInput
				placeholder: 'Escriba aqui el desarrollo de su pregunta';
				on: #desarrollo of: self ].
	aCanvas space.
	aCanvas
		form: [ aCanvas space. aCanvas space.
			aCanvas text: 'Topicos:  '.
				aCanvas textInput
				placeholder: 'Escriba aqui los topicos separados por coma';
				on: #topicos of: self ].
]

{ #category : #rendering }
NewQuestionComponent >> renderQuestionTitleOn: aCanvas [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	aCanvas heading
		id: 'title';
		level1;
		with: [ aCanvas span with: 'Nueva Pregunta' ]
]

{ #category : #callbacks }
NewQuestionComponent >> savingQuestion [

	self fieldsEmpty
		ifTrue: [ ^ nil ].
		
	"Aca comprobar que los topicos sean correctos"
	"Guardar pregunta en donde deberia de guardarse"
	
	self answer.
]

{ #category : #accessing }
NewQuestionComponent >> titulo [
	^ titulo
]

{ #category : #accessing }
NewQuestionComponent >> titulo: anObject [
	titulo := anObject
]

{ #category : #accessing }
NewQuestionComponent >> topicos [
	^ topicos
]

{ #category : #accessing }
NewQuestionComponent >> topicos: anObject [
	topicos := anObject
]
