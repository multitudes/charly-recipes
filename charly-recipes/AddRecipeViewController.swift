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
    let recipeTitle = CRTitleLabel(with: "Title: ")
    let recipeTitleTextField = CRTextField()
    let recipeDescription = CRTitleLabel(with: "Ingredients: ")
    let recipeDescriptionTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureUI()
        createDismissKeyboardTapGesture()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Add Recipe"
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addRecipe))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismssVC))
        
        recipeTitleTextField.delegate = self
        recipeDescriptionTextView.delegate = self
        recipeDescriptionTextView
    }
    
    func configureUI() {
        
        let padding: CGFloat = 20
        
        view.addSubview(recipeTitle)
        
        view.addSubview(recipeTitleTextField)
        view.addSubview(recipeDescription)
        view.addSubview(recipeDescriptionTextView)
        
        recipeDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            recipeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding * 2),
            recipeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTitle.heightAnchor.constraint(equalToConstant: padding * 2),
            
            recipeTitleTextField.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: padding),
            recipeTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeTitleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            recipeDescription.topAnchor.constraint(equalTo: recipeTitleTextField.bottomAnchor, constant: padding),
            recipeDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeDescription.heightAnchor.constraint(equalToConstant: padding * 2),
            
            recipeDescriptionTextView.topAnchor.constraint(equalTo: recipeDescription.bottomAnchor, constant: padding),
            recipeDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeDescriptionTextView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func addRecipe() {
        print("saved")
        dismiss(animated: true)
    }
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }
    
}


extension AddRecipeViewController: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("textFieldShouldReturn")
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing")
    }
}
