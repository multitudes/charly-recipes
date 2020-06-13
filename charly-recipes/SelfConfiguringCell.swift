//
//  SelfConfiguringCell.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseID: String { get }
    func configure(with item: ImageItem)
}
