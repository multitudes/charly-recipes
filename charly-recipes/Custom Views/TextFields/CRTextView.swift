//
//  recipeDescriptionTextView.swift
//  charly-recipes
//
//  Created by Laurent B on 17/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit


class CRTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        adjustsFontForContentSizeCategory = true
        font = .preferredFont(forTextStyle: .body)
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 10
    }
}
