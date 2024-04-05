//
//  CoreDataStorage.swift
//  PokemonApp
//
//  Created by Sultan Rifaldy on 05/04/24.
//

import Foundation
import CoreData
import UIKit

class CoreDataStorage {
    static let shared: CoreDataStorage = CoreDataStorage()
    private init () {
        printCoreDBPath()
    }
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func printCoreDBPath() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        
        print("Core Data DB Path :: \(path ?? "Not Found)")")
    }
    func catchPokemon(result: Results) {
        let pokemonData: PokemonData
        
        let fetchRequest = PokemonData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "pokemon = \(result.name)")
        if let data = try? context.fetch(fetchRequest).first {
            pokemonData = data
        } else {
            pokemonData = PokemonData(context: context)
        }
        
        pokemonData.name = result.name
        pokemonData.imageUrl = result.imageUrl
    }
}
