# cuoora
Plataforma web de preguntas y respuestas para la materia Orientación a Objetos 2 2021 de la UNLP.

## Stack

- [Pharo](https://pharo.org)
- [Seaside](https://github.com/SeasideSt/Seaside)

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
- Si todo funcionó correctamente, ejecutando en el Playground:
```Smalltalk
WAAdmin register: HelloWorldComponent asApplicationAt: 'ejemplo'.
```
y navegando a https://localhost:8080/ejemplo debería mostrar el mensaje 'Hello World!'.
