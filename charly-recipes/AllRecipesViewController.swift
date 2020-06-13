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
        title = "All Recipes"
        view.backgroundColor = .systemBackground
        //navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipe))
        navigationItem.rightBarButtonItem = addButton
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground

        view.addSubview(collectionView)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseID)
        createDataSource()
        reloadData()
    }

    @objc func addRecipe() {
        let destVC          = AddRecipeViewController()
        destVC.delegate     = self
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }

    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with item: ImageItem, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }

        cell.configure(with: item)
        return cell
    }

    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ImageItem>(collectionView: collectionView) { collectionView, indexPath, item in
            switch self.recipes[indexPath.section].type {
//            case "mediumTable":
//                return self.configure(MediumTableCell.self, with: app, for: indexPath)
//            case "smallTable":
//                return self.configure(SmallTableCell.self, with: app, for: indexPath)
            default:
                return self.configure(ImageCell.self, with: item, for: indexPath)
            }
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ImageItem>()
        snapshot.appendSections(recipes)
        for recipe in recipes {
            snapshot.appendItems(recipe.items, toSection: recipe)
        }
        dataSource?.apply(snapshot)
    }
}
