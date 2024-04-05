//
//  Result.swift
//  PokemonApp
//
//  Created by Sultan Rifaldy on 04/04/24.
//

import Foundation



struct Results: Decodable {
    let name: String
    let url: String
    var imageUrl: String? {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(self.id ?? "").png"
        }
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case imageUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""

    }
    
    private var id: String? {
            guard let urlComponents = URLComponents(string: url), let lastPathComponent = urlComponents.path.split(separator: "/").last else {
                return nil
            }
            return String(lastPathComponent)
        }
}
