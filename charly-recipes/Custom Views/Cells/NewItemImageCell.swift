//
//  newItemImageCell.swift
//  charly-recipes
//
//  Created by Laurent B on 14/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class NewItemImageCell: UICollectionViewCell {
    static let reuseID: String = "AddRecipeCell"
     
    let imageView = UIImageView()
    var closeButton : UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
  
        closeButton = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 36,weight: .bold, scale: .large)
        let closeImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: configuration)
        closeButton.setImage(closeImage, for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.clipsToBounds = false
        contentView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([

            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16.0),
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -16.0),
            closeButton.heightAnchor.constraint(equalToConstant: 40.0),
            closeButton.widthAnchor.constraint(equalToConstant: 40.0),
        ])
        
    }
    
    func configure(with item: ImageItem) {
        imageView.image = UIImage(named: item.image)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
