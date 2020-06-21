//
//  FileHelper.swift
//  charly-recipes
//
//  Created by Laurent B on 21/06/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import Foundation

enum FileHelper {
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
