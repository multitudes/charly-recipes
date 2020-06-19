//
//  Section.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import Foundation

struct Recipe: Codable, Hashable {
    var recipeName: String
    var ingredients: String
    var items: [ImageItem]
}
