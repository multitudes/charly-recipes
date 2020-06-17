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
        if fileManager.fileExists(atPath: path.path) {
            print("file exist")
            if let data = try? Data(contentsOf: path) {
                let decoder = JSONDecoder()
                do {
                    recipes = try decoder.decode([Recipe].self, from: data)
                    print(recipes)
                } catch {
                    print("Error decoding item array!")
                }
            }
        } else {
            print("file doesnt exist")
            if
                fileManager.createFile(atPath: path.path, contents: nil, attributes: nil){
                print("file created ")
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
    
    func documentsDirectory() -> URL {
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0])
        return paths[0]
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

