//
//  ApiServices.swift
//  PokemonApp
//
//  Created by Sultan Rifaldy on 03/04/24.
//

import Foundation
import Moya
import RxSwift


class ApiServices {
    static let shared: ApiServices = ApiServices()
    private init (){}
    
    private lazy var apiProvider: MoyaProvider<Api> = {
        return MoyaProvider<Api>()
    }()
    
    private let disposeBag = DisposeBag()
    
    func loadPokemon(name: String,completion: @escaping (_ results: [Results], Error? ) ->Void) {
        apiProvider.rx.request(Api.pokemon(name: name))
            .map { response -> [Results] in
                guard let pokemonResponse = try? response.map(Pokemon.self) else {
                    throw MoyaError.jsonMapping(response)
                }
                return pokemonResponse.results
            }
            .subscribe { event in
                switch event{
                case .success(let pokemon):
                    completion(pokemon, nil)
                case .failure(let error):
                    completion([], error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func loadMove(name: String, completion: @escaping (_ results: [Move], Error?) -> Void) {
        apiProvider.rx.request(Api.moves(name: name))
            .map{ response -> [Move] in
                do {
                    let moveResponse = try response.map(MoveResponse.self)
                    return moveResponse.results
                } catch {
                    print("Failed to map response to MoveResponse")
                    if let responseData = try? response.mapJSON() {
                        print("Response Data: \(responseData)")
                    }
                    throw MoyaError.jsonMapping(response)
                }
            }
            .subscribe { event in
                switch event{
                case .success(let move):
                    completion(move, nil)
                case .failure(let error):
                    completion([], error)
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}

