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
    func requestPokemon(url: String) {
        Alamofire.request(url).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result

            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                do {
                    let json = try! JSON(data: data)
                    if let flavorText = json["flavor_text_entries"][2]["flavor_text"].string {
                        print("Flavor Text: \(flavorText)")

                    }
                }
            }
        }
    }
    
    func getDescription(url: String) {
//        Alamofire.request(url).responseJSON { (response) in
//            if let json = response.result.value {
//                if let
//            }
//        }
    }
    
    
}

