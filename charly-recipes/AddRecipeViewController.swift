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
    func addRecipeViewController(didFinishAdding item: Recipe)
}

class AddRecipeViewController: UIViewController {
    
    var items:[ImageItem] = []
    
    var horizontalCollectionView: UICollectionView!
    var tap: UITapGestureRecognizer!
    
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
        listenForBackgroundNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPersistentData()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Add Recipe"
        //recipeTitleTextField.becomeFirstResponder()
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addRecipe))
        rightBarButton.isEnabled = true
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        
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
        print("saved")
        let recipeName = recipeTitleTextField.text!
        let ingredients = recipeDescriptionTextView.text!
        let recipe = Recipe(type: "", recipeName: recipeName, ingredients: ingredients, items: items)
        PersistenceManager.resetUserDefaults()
        delegate?.addRecipeViewController(didFinishAdding: recipe)
    }
    
    
    @objc func dismissVC() {
        cleanUp()
        delegate?.addRecipeViewControllerDidCancel()
    }
    
    func cleanUp() {
        do {
            for i in 0..<items.count{
                print("trying to remove \(items[i].image)")
                try FileManager.default.removeItem(at: DataModel.getDocumentsDirectory().appendingPathComponent(items[i].image))
            }
        } catch {
            print("Error removing file: \(error)")
        }
        PersistenceManager.resetUserDefaults()
    }
    
    func getPersistentData() {
        PersistenceManager.retrieveItems{ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let items):
                self.items = items
                DispatchQueue.main.async {
                    self.horizontalCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension AddRecipeViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tap.isEnabled = true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tap.isEnabled = true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print(textField.text)
        textField.resignFirstResponder()
        tap.isEnabled = false
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        tap.isEnabled = false
        //print(textView.text)
    }
}

extension AddRecipeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            //print(collectionView.frame)
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
                print("item in cell \(indexPath.item)",item )
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
        let i = sender.tag
        print("deleting tag ", i)
        do {
            print("trying to remove \(items[i].image)")
            try FileManager.default.removeItem(at: DataModel.getDocumentsDirectory().appendingPathComponent(items[i].image))
        } catch {
            print("Error removing file: \(error)")
        }
        PersistenceManager.updateWith(item: items[i], actionType: .remove) { error in
            guard let error = error else { return }
            print(error.localizedDescription)
        }
        items.remove(at: i)
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
        
        let imageName = UUID().uuidString
        let imagePath = DataModel.getDocumentsDirectory().appendingPathComponent(imageName)
        print("DocumentsDirectory ", imagePath)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let item = ImageItem(id: 0, name: "", image: imageName, editable: true)
        PersistenceManager.updateWith(item: item, actionType: .add) { error in
            guard let error = error else {
                print("item added!" )
                return
            }
            print(error.localizedDescription)
        }
        items.append(item)
        horizontalCollectionView.reloadData()
        dismiss(animated: true)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        horizontalCollectionView.reloadData()
        dismiss(animated: true)
    }
    
    
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
