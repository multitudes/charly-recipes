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
    var editable: Bool = true

    override var isSelected:Bool {
        didSet {

            self.imageView.alpha = isSelected ? 0.75 : 1.0
        }
      }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([

            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    func configure(with item: ImageItem) {
        imageView.image = UIImage(named: item.image)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
