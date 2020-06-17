//
//  ImageCell.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
   
    static let reuseID: String = "RecipeCell"
    
    let imageView = UIImageView()
    var editable: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.layer.cornerRadius = 10
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
        let path = DataModel.getDocumentsDirectory().appendingPathComponent(item.image)
        imageView.image = UIImage(contentsOfFile: path.path)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
