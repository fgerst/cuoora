# cuoora
Plataforma web de preguntas y respuestas desarrollada en Smalltalk con el framework Seaside, para la materia Orientación a Objetos 2 2021 de la UNLP.

![question](https://user-images.githubusercontent.com/45186471/130708247-df9f66d3-ccaf-4f18-add8-b637e7eb7c63.PNG)

## Stack
- [Smalltalk](https://en.wikipedia.org/wiki/Smalltalk) (lenguaje de programación)
- [Pharo](https://pharo.org) (entorno de desarrollo)
- [Seaside](https://github.com/SeasideSt/Seaside) (framework web)

## Instalar dependencias

- Seaside3

Ejecutar en el Playground de Pharo
```Smalltalk
Metacello new
 baseline:'Seaside3';
 repository: 'github://SeasideSt/Seaside:master/repository';
 load
```

## Ejecutar app

- Cargar Seaside en la imagen de Pharo.
- Clonar el repositorio utilizando [Iceberg](https://books.pharo.org/booklet-ManageCode/pdf/2019-03-24-ManageCode.pdf) en Pharo.
- Cargar los paquetes del repositorio cuoora en la imagen de Pharo.
- Si todo funcionó correctamente, ejecutando en el Playground:
```Smalltalk
| app |

app := WAAdmin register: LoginComponent asApplicationAt: 'cuoora'.
app sessionClass: UserSession.
```
y navegando a https://localhost:8080/cuoora debería mostrarse la aplicación.
