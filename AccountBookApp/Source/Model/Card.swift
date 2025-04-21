//
//  Card.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//


import Foundation

struct Card: Decodable, Identifiable {
    let applePayEligible: Bool
    let cardToken: String
    var id: String { cardToken } // Conform to Identifiable
}
