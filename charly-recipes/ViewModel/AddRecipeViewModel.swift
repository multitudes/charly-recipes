//
//  AddRecipeViewModel.swift
//  charly-recipes
//
//  Created by Laurent B on 18/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

// I had to add UIKit because of UIImage
import UIKit


class AddRecipeViewModel {
    
    private var recipe = Recipe(recipeName: "", ingredients: "", items: [])
    
    
    var recipeName: String {
        return recipe.recipeName
    }
    
    
    var ingredients: String {
        return recipe.ingredients
    }
    
    
    var items: [ImageItem] {
        get {
            return recipe.items
        }
    }
    
    
    func updateRecipeName(recipeName: String) {
        recipe.recipeName = recipeName
    }
    
    
    func updateIngredients(ingredients: String) {
        recipe.ingredients = ingredients
    }
    
    
    func updateItems(item: ImageItem) {
        recipe.items.append(item)
    }
    
    
    func addImage(with image: UIImage) {
        let imageName = UUID().uuidString
        let imagePath = DataModel.getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let item = ImageItem(image: imageName)
        PersistenceManager.updateWith(item: item, actionType: .add) { error in
            guard let error = error else {
                return
            }
            print(error.localizedDescription)
        }
        updateItems(item: item)
    }
    
    func deleteImage(_ imageTag : Int) {
        DataModel.removeImageFromDocuments(with: items[imageTag].image)
        PersistenceManager.updateWith(item: items[imageTag], actionType: .remove) { error in
            guard let error = error else { return }
            print(error.localizedDescription)
        }
        recipe.items.remove(at: imageTag)
    }
    
    
    func getPersistentData() {
        PersistenceManager.retrieveItems{ [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let items):
                    self.recipe.items = items
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    func removeAllImages() {
        for i in 0..<items.count{
            DataModel.removeImageFromDocuments(with: items[i].image)
        }
        PersistenceManager.resetUserDefaults()
    }
    
    
    func getRecipe() -> Recipe {
        PersistenceManager.resetUserDefaults()
        return recipe
        }
    
}


