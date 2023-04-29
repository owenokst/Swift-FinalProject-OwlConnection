//
//  Character.swift
//  FinalProject
//
//  Created by Owen Okst on 4/23/23.
//

import Foundation

struct Character: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var species: String
    var house: String
    var ancestry: String
    var eyeColour: String
    var hairColour: String
    var actor: String
    var image: String
    
    enum CodingKeys: CodingKey {
        case name, species, house, ancestry, eyeColour, hairColour, actor, image
    }
}
