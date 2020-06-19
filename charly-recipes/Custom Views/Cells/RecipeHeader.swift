//
//  RecipeHeader.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class RecipeHeader: UICollectionReusableView {
    
    static let reuseID = "RecipeHeader"
    
    let title = UILabel()
    let ingredients = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        title.textColor = .label
        title.font = UIFont.preferredFont(forTextStyle: .title1)
        title.adjustsFontForContentSizeCategory = true
        ingredients.textColor = .secondaryLabel
        ingredients.font = UIFont.preferredFont(forTextStyle: .body)
        ingredients.adjustsFontForContentSizeCategory = true
        ingredients.numberOfLines = 0
        
        
        let stackView = UIStackView(arrangedSubviews: [separator,title, ingredients])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        stackView.setCustomSpacing(12, after: separator)
        stackView.setCustomSpacing(6, after: title)
    }
}
