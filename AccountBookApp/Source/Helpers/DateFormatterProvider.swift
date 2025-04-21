//
//  DateFormatterProvider.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//

import Foundation

final class DateFormatterProvider {
    static let shared = DateFormatterProvider()

    private(set) weak var dateFormatter: DateFormatter?

    private init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateFormatter = formatter
    }

     // Added a method to get the date formatter
    static func getFormatter() -> DateFormatter {
        // Use the stored weak reference, or create a new one if it's nil
        if let formatter = shared.dateFormatter {
            return formatter
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            shared.dateFormatter = formatter // Store in the weak reference
            return formatter
        }
    }
    deinit {
        // dateFormatter = nil // Not necessary with weak, but good practice for strong
        print("DateFormatterProvider deinit") //check deallocation
    }
}
