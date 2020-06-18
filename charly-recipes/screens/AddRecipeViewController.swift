//
//  AddRecipeViewController.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

protocol AddRecipeViewControllerDelegate: class {
    func addRecipeViewControllerDidCancel()
    func addRecipeViewController(didFinishAdding recipe: Recipe)
}

class AddRecipeViewController: UIViewController {
    
    private var viewModel = AddRecipeViewModel()
    
    var items:[ImageItem] = []
    
    var horizontalCollectionView: UICollectionView!
    var tap: UITapGestureRecognizer!
    var saveBarButton: UIBarButtonItem!
    weak var delegate: AllRecipesViewController!
    
    let recipeTitle = CRTitleLabel(with: "Title: ", textAlignment: .left)
    let recipeTitleTextField = CRTextField()
    let recipeDescription = CRTitleLabel(with: "Ingredients: ", textAlignment: .left)
    let recipeDescriptionTextView = CRTextView()
    let addImageLabel = CRTitleLabel(with: "Add images: ", textAlignment: .left)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTitleTextField.delegate = self
        recipeDescriptionTextView.delegate = self
        
        configureViewController()
        configureHorizontalCollectionView()
        configureUI()
        createDismissKeyboardTapGesture()
        listenForBackgroundNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getPersistentData()
        horizontalCollectionView.reloadData()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Add Recipe"
        saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addRecipe))
        saveBarButton.isEnabled = false
        navigationItem.rightBarButtonItem = saveBarButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
    }
    
    
    func configureHorizontalCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        horizontalCollectionView.register(NewItemImageCell.self, forCellWithReuseIdentifier: "AddRecipeCell")
        horizontalCollectionView.register(ImagePlaceholderCell.self, forCellWithReuseIdentifier: "PlaceholderCell")
        horizontalCollectionView.allowsMultipleSelection = false
        horizontalCollectionView.backgroundColor = .systemBackground
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
        tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.isEnabled = false
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func addRecipe() {
        delegate?.addRecipeViewController(didFinishAdding: viewModel.sendBackRecipe())
    }
    
    
    @objc func dismissVC() {
        viewModel.removeAllImages()
        delegate?.addRecipeViewControllerDidCancel()
    }
}


extension AddRecipeViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tap.isEnabled = true
        textView.text = viewModel.ingredients
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tap.isEnabled = true
        textField.text = viewModel.recipeName
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        tap.isEnabled = false
        viewModel.updateRecipeName(recipeName: textField.text ?? "")
        saveBarButton.isEnabled = !textField.text!.isEmpty && items.count != 0
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        tap.isEnabled = false
        viewModel.updateIngredients(ingredients: textView.text)
    }
}

extension AddRecipeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height * 0.7)
        }
        return CGSize(width: collectionView.frame.height * 0.8, height: collectionView.frame.height * 0.8)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
            case 1: return items.count
            default: return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if indexPath.section == 0 {
            addNewPicture()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddRecipeCell", for: indexPath)
            if let imageCell = cell as? NewItemImageCell {
                let item = items[indexPath.item]
                let path = DataModel.getDocumentsDirectory().appendingPathComponent(item.image)
                imageCell.imageView.image = UIImage(contentsOfFile: path.path)
                imageCell.closeButton.tag = indexPath.item
                imageCell.closeButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
            }
            return cell
        } else  { //if indexPath.section == 0
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceholderCell", for: indexPath)
            if cell is ImagePlaceholderCell {
                cell.isSelected = false
            }
            return cell
        }
    }
    
    @objc func deleteItem(sender:UIButton) {
        let imageTag = sender.tag
        viewModel.deleteImage(imageTag)
        items = viewModel.items
       
        saveBarButton.isEnabled = !recipeTitleTextField.text!.isEmpty && items.count != 0
        horizontalCollectionView.reloadData()
    }
}


extension AddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func addNewPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        viewModel.addImage(with: image)
        items = viewModel.items
        
        saveBarButton.isEnabled = !recipeTitleTextField.text!.isEmpty && items.count != 0
        horizontalCollectionView.reloadData()
        dismiss(animated: true)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        horizontalCollectionView.reloadData()
        dismiss(animated: true)
    }
    
    
    // when the app goes into background I resign first responder for the two text input fields
    func listenForBackgroundNotification() {
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: OperationQueue.main) { [weak self] _ in
            if let self = self {
                if self.presentedViewController != nil {
                    self.dismiss(animated: false, completion: nil)
                }
                self.recipeTitleTextField.resignFirstResponder()
                self.recipeDescriptionTextView.resignFirstResponder()
            }
        }
    }
}
