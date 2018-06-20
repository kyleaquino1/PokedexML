//
//  Pokemon.swift
//  Pokèdex
//
//  Created by Kyle Aquino on 6/19/18.
//  Copyright © 2018 Kyle Aquino. All rights reserved.
//

import Foundation

enum PokemonType: String, CaseIterable {
    case bulbasaur = "bulbasaur"
    case charmander = "charmander"
    case squirtle = "squirtle"
    case pikachu = "pikachu"
    case chikorita = "chikorita"
    case cyndaquil = "cyndaquil"
    case totodile = "totodile"
    case treecko = "treecko"
    case torchic = "torchic"
    case mudkip = "mudkip"
    
    var id: Int {
        switch self {
        case .bulbasaur:
            return 1
        case .charmander:
            return 4
        case .squirtle:
            return 7
        case .pikachu:
            return 25
        case .chikorita:
            return 152
        case .cyndaquil:
            return 155
        case .totodile:
            return 158
        case .treecko:
            return 252
        case .torchic:
            return 255
        case .mudkip:
            return 258
        }
    }
}

class Pokemon {
    let name: String
    let id: Int
    let baseURL: String
    let descURL: String
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
        self.baseURL = "http://pokeapi.co/api/v2/pokemon/\(id)/"
        self.descURL = "http://pokeapi.co/api/v2/pokemon-species/\(id)/"
    }
}
