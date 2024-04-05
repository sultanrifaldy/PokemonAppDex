//
//  Api.swift
//  PokemonApp
//
//  Created by Sultan Rifaldy on 03/04/24.
//

import Foundation
import Moya

enum Api {
    case pokemon(name: String)
    case moves(name: String)
    case types(name: String)
}

extension Api: TargetType {
    var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2")!
    }
    
    var path: String {
        switch self {
        case .pokemon(let name):
            return "/pokemon/\(name)"
        case .moves(let name):
            return "/pokemon/\(name)/moves/"
        case .types(let name):
            return "/type/\(name)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .pokemon:
            return .get
        case .moves:
            return .get
        case .types:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .pokemon:
            return .requestPlain
        case .moves:
            return .requestPlain
        case .types:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
