//
//  Recipe.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import Foundation


// this is being replaced by the section struct for the collection view.
struct Recipe2: Codable, Hashable {

    var name: String
    var pictures: [String]
    var ingredients: String
    
}
