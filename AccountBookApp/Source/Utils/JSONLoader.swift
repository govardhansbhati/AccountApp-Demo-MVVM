//
//  JSONLoader.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//

import Foundation

/// Utility responsible for loading local JSON files from app bundle
enum JSONLoader {
    /// Load JSON from a given file name and extension
    static func loadJSON(from fileName: String, withExtension: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: withExtension) else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
}

