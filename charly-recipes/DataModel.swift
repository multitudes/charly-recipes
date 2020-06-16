//
//  DataModel.swift
//  charly-recipes
//
//  Created by Laurent B on 16/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//



import Foundation

class DataModel {
    var recipes: [Recipe]
    
    init() {
        recipes = Bundle.main.decode([Recipe].self, from: "recipes.json")
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    //  func documentsDirectory() -> URL {
    //    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //    return paths[0]
    //  }
    //
    //  func dataFilePath() -> URL {
    //    return documentsDirectory().appendingPathComponent(
    //      "Checklists.plist")
    //  }
    //
    //  func saveChecklists() {
    //    let encoder = PropertyListEncoder()
    //    do {
    //      let data = try encoder.encode(lists)
    //      try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
    //    } catch {
    //      print("Error encoding item array!")
    //    }
    //  }
    //
    //  func loadChecklists() {
    //    let path = dataFilePath()
    //    if let data = try? Data(contentsOf: path) {
    //      let decoder = PropertyListDecoder()
    //      do {
    //        lists = try decoder.decode([Checklist].self, from: data)
    //      } catch {
    //        print("Error decoding item array!")
    //      }
    //    }
    //  }
}
