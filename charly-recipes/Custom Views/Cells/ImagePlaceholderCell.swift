//
//  ImagePlaceholderCell.swift
//  charly-recipes
//
//  Created by Laurent B on 16/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class ImagePlaceholderCell: UICollectionViewCell {
    
    
    static let reuseID: String = "PlaceholderCell"
    
    let imageView = UIImageView()
    
    override var isSelected:Bool {
        didSet {
            self.imageView.alpha = isSelected ? 0.75 : 1.0
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.image = UIImage(named: "addImagePlaceholder")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


