//
//  CRTitleLabel.swift
//  charly-recipes
//
//  Created by Laurent B on 14/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class CRTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(with text: String) {
        self.init(frame: .zero)
        self.text = text
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .label
        font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }

}
