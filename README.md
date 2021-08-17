# MarvelHeroes

MarvelHeroes es una pequeña aplicación para dispositivos iOS y iPadOS que utiliza la api de Marvel para listar sus personajes y visualizar su descripción, así como los cómics en los que aparece. 

<p align="row">
<img src= "https://github.com/yhondri/MarvelHeroes/blob/main/capturas/iphone_mv_1.png?raw=true" width="200" height="300" > <img src= "https://github.com/yhondri/MarvelHeroes/blob/main/capturas/iphone_mv_2.png?raw=true" width="200" height="300" > <img src= "https://github.com/yhondri/MarvelHeroes/blob/main/capturas/iphone_mv_3.png?raw=true" width="200" height="300" >
</p>

<p align="row">
<img src= "https://github.com/yhondri/MarvelHeroes/blob/main/capturas/ipad_mv_1.png?raw=true" width="200" height="300" > <img src= "https://github.com/yhondri/MarvelHeroes/blob/main/capturas/ipad_mv_2.png?raw=true" width="200" height="300" > <img src= "https://github.com/yhondri/MarvelHeroes/blob/main/capturas/ipad_mv_3.png?raw=true" width="200" height="300" >
</p>


## Features

- Visualiza todos los personajes de marvel.
- Mira los detalles de cada personaje como su descripción o cómics en los que aparece.
- Carga los personajes de forma eficiente. 
- Modo claro y modo oscuro
- Adaptado a iPhone y iPad. 

## Arquitectura

MarvelHeroes utiliza VIPER, que es una arquitectura que separa las diferentes capas que componen un módulo. 
- La Vista, es la interfaz de usuario. 
- El Interactor, es la clase que está entre el presenter y los datos. 
- El Presenter, se encarga de dirigir el flujo del módulo. Obtiene los datos del interactor y se los envía a la vista, y se encarga de redirigir el flujo hacia el router cuando el usuario realiza una acción que conlleva un cambio de módulo. 
- Entidad, representa los datos de la aplicación.
- El Router, se encarga de la navegación entre pantallas. 

Vista la arquitectura, MarvelHeroes se compone de 3 módulos. 
- CharacterList, permite visualizar los personajes de Marvel. 
- CharacterDetail, permite visualizar los detalles de un personaje. 
- ComicDetail, permite visualizar los detalles de un cómic en el que aparezca un personaje. 

Además se incluyen unos tests unitarios, MarvelHeroesTests, que se encargan de probar el presenter y el interactor del módulo CharacterList.

## Requisitos

- iOS 14.1+
- Xcode 13.0 beta 5+
- Clave pública y clave privada de la api de Marvel. Antes de poder utilizar la aplicación, necesitas una cuenta de desarrolladores de Marvel donde obtendrás las APIKeys necesarias para utilizar la aplicación. https://developer.marvel.com/

## Características
- Swift
- UIKit
- iOS
- iPadOS

## Librerías de terceros

La aplicación utiliza los siguientes proyectos open source.

- [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Carga asíncrona de imágenes

## Otros
El Icono de la aplicación ha sido creado por
[Sujud.icon](https://www.iconfinder.com/MUHrist)


## License

MIT

**Free Software, Hell Yeah!**