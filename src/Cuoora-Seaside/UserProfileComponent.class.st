"
Este componente se encarga de mostrar todas las preguntas de un usuario y permitir agregar al usuario del perfil a tus follows.
"
Class {
	#name : #UserProfileComponent,
	#superclass : #CommonPageComponent,
	#instVars : [
		'userProfile'
	],
	#category : #'Cuoora-Seaside'
}

{ #category : #creation }
UserProfileComponent class >> newWithUserProfile: anUser [
	^ self new userProfile: anUser yourself
]

{ #category : #callbacks }
UserProfileComponent >> followUser [
	self session user addFollowing: userProfile.
]

{ #category : #accessing }
UserProfileComponent >> isFollowing [
	^ self session user isFollowing: userProfile
]

{ #category : #'rendering-elements' }
UserProfileComponent >> renderFollowAnchorOn: html [
	html anchor
		class: 'small';
		callback: [ self followUser ];
		with: 'follow'
]

{ #category : #'rendering-elements' }
UserProfileComponent >> renderFollowStatusOn: html [
	userProfile = self session user
		ifTrue: [ ^ nil ].
	html space.
	self isFollowing
		ifTrue: [ self renderFollowingTextOn: html ]
		ifFalse: [ self renderFollowAnchorOn: html ]
]

{ #category : #'rendering-elements' }
UserProfileComponent >> renderFollowingTextOn: html [
	html span
		class: 'small';
		with: '| following'
]

{ #category : #rendering }
UserProfileComponent >> renderPageContentOn: aCanvas [
	self renderPageTitleOn: aCanvas.
	self renderUserQuestionsOn: aCanvas
]

{ #category : #rendering }
UserProfileComponent >> renderPageTitleOn: html [
	html heading
		level: 2;
		class: 'h2-alt';
		with: [ self renderUsernameOn: html.
			self renderFollowStatusOn: html ]
]

{ #category : #rendering }
UserProfileComponent >> renderUserQuestionsOn: html [
	self renderQuestions: userProfile questions on: html
]

{ #category : #'rendering-elements' }
UserProfileComponent >> renderUsernameOn: html [
	html span: 'Preguntas de '.
	html span: userProfile profileName
]

{ #category : #accessing }
UserProfileComponent >> userProfile [
	^ userProfile
]

{ #category : #accessing }
UserProfileComponent >> userProfile: anObject [
	userProfile := anObject
]
