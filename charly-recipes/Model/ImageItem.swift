//
//  ImagesCells.swift
//  charly-recipes
//
//  Created by Laurent B on 13/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import Foundation

struct ImageItem: Decodable, Hashable {
    let id: Int
    let name: String
    let image: String
    let editable: Bool
}
