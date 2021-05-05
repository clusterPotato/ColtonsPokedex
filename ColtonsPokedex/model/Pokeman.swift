//
//  Pokeman.swift
//  ColtonsPokedex
//
//  Created by Gavin Craft on 5/4/21.
//

import UIKit

struct Pokeman: Encodable, Decodable, Equatable{
    let name: String
    let id: Int
    let sprites: Sprite
}
struct Sprite: Decodable, Encodable, Equatable{
    let classic: URL?
    let classicShiny: URL?
    let femaleShiny: URL?
    enum CodingKeys:String, CodingKey{
        case classic = "front_default"
        case classicShiny = "front_shiny"
        case femaleShiny = "front_shiny_female"
    }
}
struct StoredPokeman: Equatable, Encodable, Decodable{
    let poke: Pokeman
    let image: Data
}
