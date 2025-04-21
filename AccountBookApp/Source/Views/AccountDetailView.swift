//
//  AccountDetailView.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//

import SwiftUI

struct AccountDetailView: View {
    let account: Account
    let dateFormatter: DateFormatter

    var body: some View {
        List {
            Section(header: Text("Account Details")) {
                Text("Name: \(account.accountName)")
                Text("Currency: \(account.currency)")
            }
            
            //  Section for cards, if any.
            if let cards = account.cards, !cards.isEmpty {
                Section(header: Text("Cards")) {
                    ForEach(cards) { card in
                        Text("Card Token: \(card.cardToken)")
                        Text("Apple Pay Eligible: \(card.applePayEligible ? "Yes" : "No")")
                    }
                }
            }

            Section(header: Text("Transactions")) {
                ForEach(account.transactions.sorted(by: {
                    
                    guard let date1 = dateFormatter.date(from: $0.date),
                          let date2 = dateFormatter.date(from: $1.date) else {
                        
                        return false 
                    }
                    return date1 > date2
                })) { transaction in
                    TransactionRow(transaction: transaction, currency: account.currency, dateFormatter: dateFormatter)
                }
            }
        }
        .navigationTitle(account.accountName)
    }
}

