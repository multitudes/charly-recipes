//
//  DataModel.swift
//  charly-recipes
//
//  Created by Laurent B on 16/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import Foundation

class DataModel {
    
    private var dataSourceFile = "recipes.json"
    
    var recipes = [Recipe]()
    
    
    init() {
        loadRecipes()
    }
    
    
    private func loadRecipes() {
        let path = FileHelper.getDocumentsDirectory().appendingPathComponent(dataSourceFile)
        print("Files are saved in the Document Directory at this path: ", FileHelper.getDocumentsDirectory() )
        if FileManager.default.fileExists(atPath: path.path) {
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
                FileManager.default.createFile(atPath: path.path, contents: nil, attributes: nil){
            } else {
                print("an error happened while creating the file")
            }
        }
    }
    
    
    func saveJson(with recipes: [Recipe]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(recipes)
            let path = FileHelper.getDocumentsDirectory().appendingPathComponent(dataSourceFile)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array!")
        }
    }
    
    
    static func removeImageFromDocuments(with name: String) {
        do {
            try FileManager.default.removeItem(at: FileHelper.getDocumentsDirectory().appendingPathComponent(name))
        } catch {
            print("Error removing file: \(error)")
        }
    }
}

