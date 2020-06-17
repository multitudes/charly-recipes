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
        //recipes = Bundle.main.decode([Recipe].self, from: "recipes.json")
        //configureJson()
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
            print(path.absoluteString)
                if
                    fileManager.createFile(atPath: path.path, contents: nil, attributes: nil){
                    print("file created ")
                } else {
                    print("an error happened while creating the file")
                }
            }
        
       
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
    
    func configureJson() {
        let documentsDirectory = DataModel.getDocumentsDirectory()
        let fileURL = documentsDirectory.appendingPathComponent("recipes.json")
        do {

           if try fileURL.checkResourceIsReachable() {
               print("file exist")
            
           } else {
               print("file doesnt exist")
               do {
                try Data().write(to: fileURL)
               } catch {
                   print("an error happened while creating the file")
               }
           }
       } catch {
           print("an error happened while checking for the file")
       }

    }
