//
//  Transaction.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//


import Foundation

struct Transaction: Decodable, Identifiable {
    let date: String
    let inAmount: String?
    let outAmount: String?
    let transactionCardToken: String?
    let paymentType: String
    let title: String
    let uniqueID: String
    let reference: String? // Optional
    var id: String { uniqueID } // Conform to Identifiable
    
    private enum CodingKeys: String, CodingKey {
        case date, inAmount, outAmount, transactionCardToken, paymentType, title, uniqueID, reference
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.inAmount = try container.decodeIfPresent(String.self, forKey: .inAmount)
        self.outAmount = try container.decodeIfPresent(String.self, forKey: .outAmount)
        self.transactionCardToken = try container.decodeIfPresent(String.self, forKey: .transactionCardToken)
        self.paymentType = try container.decode(String.self, forKey: .paymentType)
        self.title = try container.decode(String.self, forKey: .title)
        self.uniqueID = try container.decode(String.self, forKey: .uniqueID)
        self.reference = try container.decodeIfPresent(String.self, forKey: .reference)
    }
}
