//
//  AllRecipesViewController.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class AllRecipesViewController: UIViewController {

    let recipes = Bundle.main.decode([Section].self, from: "recipes.json")
    var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Section, ImageItem>?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(recipes)
        configureViewController()
    }
   
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipe))
        navigationItem.rightBarButtonItem = addButton
    }

    
    @objc func addRecipe() {
        let destVC          = AddRecipeViewController()
        destVC.delegate     = self
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }

}
