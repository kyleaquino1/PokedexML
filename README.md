# PokedexML
### A side project app to test out Apple's New CreateML framework

## Overview

PokedexML is a simple app that you can use to take pictures of pokemon and view their Pokedex entry. It uses a custom machine learning model created with the new CreateML framework in Xcode Playgrounds. 

### How To Use

Simply put the pokemon of choice in the center of the screen and tap the screen to take a photo to be classified. The pokedex will come up if the confidence is 60% or higher.

![Imgur](https://i.imgur.com/ZMF3KNj.gifv)


## Technologies Used
* CreateML
* CoreML
* Vision
* AVFoundation
* AlamoFire
* CoreAnimation


This app was created by using CreateML to make a custom model to identify the first three generations of pokemon starters as well as Pikachu. I was curious to see how well the image recognition of CoreML's Vision framework was in combination with the custom model made from around 20 pictures per pokemon. This app also allowed me to practice making an API request to pokeapi.co and parsing through the JSON response. 
