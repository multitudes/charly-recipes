//
//  AllRecipesViewController.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit



class AllRecipesViewController: UIViewController {
    
    var dataModel: DataModel!
    
    var recipes: [Recipe]!
    var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Recipe, ImageItem>?

    override func viewDidLoad() {
        super.viewDidLoad()
        recipes = dataModel.recipes
        print(recipes!)
        configureViewController()
    }
   
    
    func configureViewController() {
        title = "All Recipes"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipe))
        navigationItem.rightBarButtonItem = addButton
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground

        view.addSubview(collectionView)
        
        collectionView.register(RecipeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecipeHeader.reuseID)
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

    
//    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with item: ImageItem, for indexPath: IndexPath) -> T {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T else {
//            fatalError("Unable to dequeue \(cellType)")
//        }
//        cell.configure(with: item)
////        let path = DataModel.getDocumentsDirectory().appendingPathComponent(item.image)
////        imageCell.imageView.image = UIImage(contentsOfFile: path.path)
//        return cell
//    }

    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Recipe, ImageItem>(collectionView: collectionView) { collectionView, indexPath, item in
            switch self.recipes[indexPath.section].type {

            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell" , for: indexPath) as? ImageCell else {
                    fatalError("Unable to dequeue ")
                }
                let path = DataModel.getDocumentsDirectory().appendingPathComponent(item.image)
                print(item.image)
                cell.imageView.image = UIImage(contentsOfFile: path.path)
                return cell
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath in
            guard let recipeHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RecipeHeader.reuseID, for: indexPath) as? RecipeHeader else {
                return nil
            }
            guard let firstItem = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstItem) else { return nil }
            if section.recipeName.isEmpty { return nil }

            recipeHeader.title.text = section.recipeName
            recipeHeader.ingredients.text = section.ingredients
            return recipeHeader
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Recipe, ImageItem>()
        snapshot.appendSections(recipes)
        for recipe in recipes {
            snapshot.appendItems(recipe.items, toSection: recipe)
        }
        dataSource?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, layoutEnvironment in
            let recipe = self.recipes[sectionIndex]
            switch recipe.type {
                default:
                    return self.createRecipeSection(using: recipe)
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func createRecipeSection(using section: Recipe ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let layoutGroupsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(350))
        let layoutgroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupsize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutgroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(300))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        return layoutSection
        
    }

}


extension AllRecipesViewController: AddRecipeViewControllerDelegate {
    func addRecipeViewControllerDidCancel() {
        print("\ncancelld!!\n")
        navigationController?.dismiss(animated:true)
    }
    
    func addRecipeViewController(didFinishAdding item: Recipe) {
        print("\ngot ya!!\n")
        print(item)
        navigationController?.dismiss(animated:true)
    }
}
