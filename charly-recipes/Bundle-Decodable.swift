//
//  Bundle-Decodable.swift
//  charly-recipes
//
//  File Created by Laurent B on 13/06/2020.
//  Extension by Paul Hudson
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}

extension Encodable {
    func jsonData(keys: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys, dates: JSONEncoder.DateEncodingStrategy = .deferredToDate) -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = keys
        encoder.dateEncodingStrategy = dates

        do {
            return try encoder.encode(self)
        } catch {
            print("Failed to encode to JSON.")
            return Data()
        }
    }

}
