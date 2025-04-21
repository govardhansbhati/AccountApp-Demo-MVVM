//
//  Account.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//

import Foundation

struct AccountsResponse: Decodable {
    let accounts: [Account]
}

struct Account: Decodable, Identifiable {
    let accountName: String
    let sortingOrder: Int
    let currency: String
    let conversionRate: String
    let cards: [Card]?
    let transactions: [Transaction]
    let uniqueID: String
    var id: String { uniqueID } // Conform to Identifiable
}

