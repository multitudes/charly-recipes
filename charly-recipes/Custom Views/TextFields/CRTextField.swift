//
//  CRTextField.swift
//  charly-recipes
//
//  Created by Laurent B on 14/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class CRTextField: UITextField {


        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    
        // without these 2 functions below the text would stick to the left without any padding
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 10.0, dy: 0)
        }

    
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return self.textRect(forBounds: bounds)
        }
    
    
        private func configure() {
            translatesAutoresizingMaskIntoConstraints = false
            
            layer.cornerRadius          = 10
            layer.borderWidth           = 1
            layer.borderColor           = UIColor.systemGray4.cgColor
            
            textColor                   = .label
            tintColor                   = .label
            textAlignment               = .left
            font                        = UIFont.preferredFont(forTextStyle: .title2)
            adjustsFontSizeToFitWidth   = true
            minimumFontSize             = 12
            
            backgroundColor             = .tertiarySystemBackground
            autocorrectionType          = .yes
            autocapitalizationType      = .sentences
            returnKeyType               = .next
            clearButtonMode             = .whileEditing
            placeholder                 = "Enter a title"
        }


}
