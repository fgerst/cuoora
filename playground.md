Testing Modelo
```Smalltalk
cuoora := CuooraPlatform new.

t1 := cuoora newTopic: (Topic withName: 'Python' description: 'Python').
t2 := cuoora newTopic: (Topic withName: 'Java' description: 'Java').
t3 := cuoora newTopic: (Topic withName: 'Smalltalk' description: 'Smalltalk').

u1 := cuoora newUser: (User withUsername: 'Franco' password: '123').
u2 := cuoora newUser: (User withUsername: 'Tomas' password: '123').
u3 := cuoora newUser: (User withUsername: 'Juan' password: '123').

q1 := cuoora newQuestion: (Question withAuthor: u1 title: 'Test1?' content: 'Test a') withTopics: {t1. t2}.
q2 := cuoora newQuestion: (Question withAuthor: u2 title: 'Test2?' content: 'Test b') withTopics: {t3}.

a1 := q1 newAnswer: (Answer withAuthor: u2 content: 'Sos un boludo').
a2 := q1 newAnswer: (Answer withAuthor: u3 content: 'Tomatela te dije').

q1 likeFrom: u2.
q1 likeFrom: u2.
q1 dislikeFrom: u3.
a1 dislikeFrom: u1.

cuoora.
```
Testing App
```Smalltalk
| app |

app := WAAdmin register: LoginComponent asApplicationAt: 'cuoora'.
```
