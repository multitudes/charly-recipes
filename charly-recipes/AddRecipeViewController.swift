//
//  AddRecipeViewController.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController {

    weak var delegate: AllRecipesViewController!
    
    let horizontalScrollView = UIScrollView()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureHorizontalScrollView()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addRecipe))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismssVC))
    }
    
    func configureHorizontalScrollView() {
        
    }
    
    @objc func addRecipe() {
        print("saved")
         dismiss(animated: true)
    }
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }

}
