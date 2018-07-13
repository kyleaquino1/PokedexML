//
//  PokemonController.swift
//  Pokèdex
//
//  A class to handle the information from Pokeapi
//
//  Created by Kyle Aquino on 6/19/18.
//  Copyright © 2018 Kyle Aquino. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AVFoundation

class PokemonController {
    var flavorText = ""
    var pokemonImage: UIImage?
    func requestImage(url: String) {}
    
    func getPokemonDataOLD(url: String) -> String {
        var flavorTextFinal = ""
        Alamofire.request(url).responseJSON { response in
            if let data = response.data {
                do {
                    let json = try! JSON(data: data)
                    
                    if let arrOfThings = json["flavor_text_entries"].array {
                        for (subJson):(JSON) in arrOfThings {
                            if subJson["language"]["name"].string == "en" {
                                if let flavorText = subJson["flavor_text"].string {
                                    flavorTextFinal = flavorText
                                    self.flavorText = flavorText
                                    print(flavorText)
                                    NotificationCenter.default.post(name: .presentPokemon, object: self)
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        return flavorTextFinal
    }
    
    func getPokemonData(for pokemon: Pokemon) {
        var flavorTextFinal = ""
        var pokemonImage: UIImage?
        let url = pokemon.descURL
        Alamofire.request(url).responseJSON { response in
            if let data = response.data {
                do {
                    let json = try! JSON(data: data)
                    
                    if let arrOfThings = json["flavor_text_entries"].array {
                        for (subJson):(JSON) in arrOfThings {
                            if subJson["language"]["name"].string == "en" {
                                if let flavorText = subJson["flavor_text"].string {
                                    flavorTextFinal = flavorText
                                    self.flavorText = flavorText.replacingOccurrences(of: "\n", with: " ")
                                    print(flavorText)
                                    DispatchQueue.global().async { [weak self] in
                                        if let data = try? Data(contentsOf: pokemon.imgURL) {
                                            if let image = UIImage(data: data) {
                                                DispatchQueue.main.async {
                                                    pokemonImage = image
                                                    self?.pokemonImage = pokemonImage
                                                    NotificationCenter.default.post(name: .presentPokemon, object: self)
                                                }
                                            }
                                        }
                                    }
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        return
    }
}

