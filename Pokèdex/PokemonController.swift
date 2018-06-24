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
    func requestImage(url: String) {}
    
    func getDescription(url: String) -> String {
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
}

