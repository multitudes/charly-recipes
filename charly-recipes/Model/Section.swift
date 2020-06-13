//
//  Section.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import Foundation

struct Section: Decodable, Hashable {
    let type: String
    let recipeName: String
    let ingredients: String
    let items: [ImageItem]
    
}
