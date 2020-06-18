//
//  CRstartView.swift
//  charly-recipes
//
//  Created by Laurent B on 18/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class CRstartView: UIView {

    let messageLabel    = CRTitleLabel(with: "No recipes yet! 😀 \nCreate a new recipe\nclicking on the + button above", textAlignment: .center )
    let logoImageView   = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    private func configure() {
        configureMessageLabel()
        configureLogoImageView()
    }
    
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        messageLabel.numberOfLines  = 4
        messageLabel.textColor      = .secondaryLabel
        

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureLogoImageView() {
        addSubview(logoImageView)
        logoImageView.image = UIImage(named: "cookbookIcon")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20)
        ])
    }

}
