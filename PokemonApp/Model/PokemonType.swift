//
//  PokemonType.swift
//  PokemonApp
//
//  Created by Sultan Rifaldy on 05/04/24.
//

import Foundation


struct PokemonType: Decodable {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey{
        case name
        case url
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
}
