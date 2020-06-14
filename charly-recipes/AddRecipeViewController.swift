//
//  AddRecipeViewController.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController {
    
    var items = [ImageItem(id: 1, name: "", image: "addImagePlaceholder", editable: false)]

    var horizontalCollectionView: UICollectionView!
    
    weak var delegate: AllRecipesViewController!
    
    let recipeTitle = CRTitleLabel(with: "Title: ")
    let recipeTitleTextField = CRTextField()
    let recipeDescription = CRTitleLabel(with: "Ingredients: ")
    let recipeDescriptionTextView = UITextView()
    let addImageLabel = CRTitleLabel(with: "Add images: ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTextInput()
        configureHorizontalCollectionView()
        configureUI()
        createDismissKeyboardTapGesture()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Add Recipe"
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addRecipe))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismssVC))
        
    }
    
    func configureTextInput() {
        recipeTitleTextField.delegate = self
        recipeDescriptionTextView.delegate = self
        
        recipeDescriptionTextView.adjustsFontForContentSizeCategory = true
        recipeDescriptionTextView.font = .preferredFont(forTextStyle: .body)
        recipeDescriptionTextView.layer.borderColor = UIColor.systemGray4.cgColor
        recipeDescriptionTextView.layer.borderWidth = 1.0
        recipeDescriptionTextView.layer.cornerRadius = 10
    }
    
    func configureHorizontalCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        horizontalCollectionView.register(NewItemImageCell.self, forCellWithReuseIdentifier: "AddRecipeCell")
        horizontalCollectionView.backgroundColor = .yellow
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
    }
    
    func configureUI() {
        
        let padding: CGFloat = 20
        
        view.addSubview(recipeTitle)
        view.addSubview(recipeTitleTextField)
        view.addSubview(recipeDescription)
        view.addSubview(recipeDescriptionTextView)
        view.addSubview(addImageLabel)
        view.addSubview(horizontalCollectionView)
        
        recipeDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            recipeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            recipeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTitle.heightAnchor.constraint(equalToConstant: padding * 2),
            
            recipeTitleTextField.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: padding),
            recipeTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeTitleTextField.heightAnchor.constraint(equalToConstant: padding * 2.5),
            
            recipeDescription.topAnchor.constraint(equalTo: recipeTitleTextField.bottomAnchor, constant: padding),
            recipeDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeDescription.heightAnchor.constraint(equalToConstant: padding * 2),
            
            recipeDescriptionTextView.topAnchor.constraint(equalTo: recipeDescription.bottomAnchor, constant: padding),
            recipeDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeDescriptionTextView.heightAnchor.constraint(equalToConstant: padding * 5),
            
            addImageLabel.topAnchor.constraint(equalTo: recipeDescriptionTextView.bottomAnchor, constant: padding),
            addImageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            addImageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addImageLabel.heightAnchor.constraint(equalToConstant: padding * 2),
            
            horizontalCollectionView.topAnchor.constraint(equalTo: addImageLabel.bottomAnchor, constant: padding),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            horizontalCollectionView.heightAnchor.constraint(equalToConstant: 150)
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
        //print(textField.text)
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing")
        //print(textView.text)
    }
}
extension AddRecipeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddRecipeCell", for: indexPath) as! NewItemImageCell
        //cell.image = self.recipeToAdd[indexPath.item]
        cell.configure(with: items[indexPath.item])
        return cell
    }
}
