//
//  DataModel.swift
//  charly-recipes
//
//  Created by Laurent B on 16/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//



import Foundation

class DataModel {
    
    let fileManager = FileManager.default
    var recipes = [Recipe]()
    
    
    init() {
        loadRecipes()
    }
    
    
    func loadRecipes() {
        let path = dataFilePath()
        print("Files are saved in the Document Directory at this path: ", DataModel.getDocumentsDirectory() )
        if fileManager.fileExists(atPath: path.path) {
            if let data = try? Data(contentsOf: path) {
                let decoder = JSONDecoder()
                do {
                    recipes = try decoder.decode([Recipe].self, from: data)
                } catch {
                    print("Error decoding item array!")
                }
            }
        } else {
            if
                fileManager.createFile(atPath: path.path, contents: nil, attributes: nil){
            } else {
                print("an error happened while creating the file")
            }
        }
    }

    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveJson(with recipes: [Recipe]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(recipes)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array!")
        }
    }
    
   
    func dataFilePath() -> URL {
        return DataModel.getDocumentsDirectory().appendingPathComponent(
            "recipes.json")
    }
    
    static func removeImageFromDocuments(with name: String) {
        do {
            try FileManager.default.removeItem(at: DataModel.getDocumentsDirectory().appendingPathComponent(name))
        } catch {
            print("Error removing file: \(error)")
        }
    }
}

