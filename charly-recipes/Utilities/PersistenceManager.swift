//
//  AllRecipesViewController.swift
//  charly-recipes
//
//  Created by Laurent B on 15/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}


enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let items = "items"
    }
    
    static func resetUserDefaults() {
        defaults.removeObject(forKey: Keys.items)
    }
    
    
    static func updateWith(item: ImageItem, actionType: PersistenceActionType, completed: @escaping (Error?) -> Void) {
        retrieveItems { result in
            switch result {
                case .success(let items):
                    var retrievedItems = items
                    
                    switch actionType {
                        case .add:
                            guard !retrievedItems.contains(item) else {
                                completed(Error.Type.self as? Error)
                                return
                            }
                            retrievedItems.append(item)
                        case .remove:
                            retrievedItems.removeAll { $0.image == item.image }
                    }
                    completed(save(items: retrievedItems))
                case .failure(let error):
                    completed(error)
            }
        }
    }
    
    
    static func retrieveItems(completed: @escaping (Result<[ImageItem], Error>) -> Void) {
        guard let itemsData = defaults.object(forKey: Keys.items) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let items = try decoder.decode([ImageItem].self, from: itemsData)
            completed(.success(items))
        } catch {
            completed(.failure(error))
        }
    }
    
    
    static func save(items: [ImageItem]) -> Error? {
        do {
            let encoder = JSONEncoder()
            let encodedItems = try encoder.encode(items)
            defaults.set(encodedItems, forKey: Keys.items)
            return nil
        } catch {
            return error
        }
    }
}
