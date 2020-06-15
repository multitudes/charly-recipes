//
//  AddRecipeViewController.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController {
    
    //var items = [ImageItem(id: 1, name: "", image: "addImagePlaceholder", editable: false)]
    var items:[ImageItem] = [ ImageItem(  id: 5,
                                          name: "healthy-insta",
                                          image: "00A064A9-5B12-4F50-8581-3D42733D957D",
                                          editable: false),ImageItem(  id: 5,
                                                                       name: "healthy-insta",
                                                                       image: "healthy-insta",
                                                                       editable: false)
    ]
    var placeholderItem = [ImageItem(id: 1, name: "", image: "addImagePlaceholder", editable: false)]
    var horizontalCollectionView: UICollectionView!
    var tap: UITapGestureRecognizer!
    
    
    weak var delegate: AllRecipesViewController!
    
    let recipeTitle = CRTitleLabel(with: "Title: ")
    let recipeTitleTextField = CRTextField()
    let recipeDescription = CRTitleLabel(with: "Ingredients: ")
    let recipeDescriptionTextView = UITextView()
    let addImageLabel = CRTitleLabel(with: "Add images: ")
    
    
    //    @objc func handleTap(_ sender: UITapGestureRecognizer) {
    //       if let indexPath = self.horizontalCollectionView?.indexPathForItem(at: sender.location(in: horizontalCollectionView)) {
    //        addNewPicture()
    //
    //    }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTextInput()
        configureHorizontalCollectionView()
        configureUI()
        createDismissKeyboardTapGesture()
        listenForBackgroundNotification()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Add Recipe"
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addRecipe))
        navigationItem.rightBarButtonItem = saveButton
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
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        //horizontalCollectionView.addGestureRecognizer(tap)
        //horizontalCollectionView.isUserInteractionEnabled = true
        
        horizontalCollectionView.register(NewItemImageCell.self, forCellWithReuseIdentifier: "AddRecipeCell")
        horizontalCollectionView.allowsMultipleSelection = false
        horizontalCollectionView.backgroundColor = .systemBackground
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        
        horizontalCollectionView.backgroundColor = .yellow
        
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
        dismiss(animated: true)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
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
        
        print("textFieldShouldReturn")
        //print(textField.text)
        textField.resignFirstResponder()
        tap.isEnabled = false
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        tap.isEnabled = false
        print("textViewDidEndEditing")
        
        //print(textView.text)
    }
}

extension AddRecipeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            print(collectionView.frame)
            return CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height * 0.7)
        }
        return CGSize(width: collectionView.frame.height * 0.8, height: collectionView.frame.height * 0.8)
        
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    //        if let cell = collectionView.cellForItem(at: indexPath) {
    //            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
    //        }
    //    }
    
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
        print(indexPath.item)
        if indexPath.section == 0 {
            print(indexPath.section)
            
            addNewPicture()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath)
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddRecipeCell", for: indexPath)
            print(cell)
            //cell.configure(with: items[indexPath.item])
            if let imageCell = cell as? NewItemImageCell {
                let item = items[indexPath.item]
                print(item)
                //imageCell.configure(with: items[indexPath.item])
                let path = getDocumentsDirectory().appendingPathComponent(item.image)
                imageCell.imageView.image = UIImage(contentsOfFile: path.path)
                
                imageCell.closeButton.tag = indexPath.row
                imageCell.closeButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
                // Do other cell setup here with data source
                return cell
                

            }
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddRecipeCell", for: indexPath) as! NewItemImageCell
            print(placeholderItem[indexPath.item])
            cell.configure(with: placeholderItem[indexPath.item])
            cell.isSelected = false
            cell.closeButton.isHidden = true
            return cell
        }
        
    }

    @objc func deleteUser(sender:UIButton) {
        let i = sender.tag
        print(i)
//        dataSource.remove(at: i)
//        collectionView.reloadData()
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
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        print("DocumentsDirectory ", imagePath)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let item = ImageItem(id: 0, name: "", image: imageName, editable: true)
        items.append(item)
        horizontalCollectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        horizontalCollectionView.reloadData()
        dismiss(animated: true)
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
    
//    func removePhotoFile() {
//
//    do {
//    try FileManager.default.removeItem(at: photoURL)
//    } catch {
//          print("Error removing file: \(error)")
//        }
//    }
}
