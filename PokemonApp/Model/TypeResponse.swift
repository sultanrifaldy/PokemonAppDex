//
//  TypeResponse.swift
//  PokemonApp
//
//  Created by Sultan Rifaldy on 05/04/24.
//

import Foundation

struct TypeResponse: Decodable {
    let count: Int
    let next: String
    let previous: String
    let results: [PokemonType]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        self.next = try container.decodeIfPresent(String.self, forKey: .next) ?? ""
        self.previous = try container.decodeIfPresent(String.self, forKey: .previous) ?? ""
        self.results = try container.decodeIfPresent([PokemonType].self, forKey: .results) ?? []
    }
}
