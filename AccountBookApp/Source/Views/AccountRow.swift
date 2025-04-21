//
//  AccountRow.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//

import SwiftUI

struct AccountRow: View {
    let account: Account

    var body: some View {
        VStack(alignment: .leading) {
            ///  Displays the account name in a headline font.
            Text(account.accountName)
                .font(.headline)
            ///  Displays the account balance.
            Text(account.currency + " " + account.transactions.reduce(0.0) { (result, transaction) -> Double in
                if let outAmount = Double(transaction.outAmount ?? "0.0"), outAmount > 0 {
                    return result - outAmount
                }
                if let inAmount = Double(transaction.inAmount ?? "0.0"), inAmount > 0 {
                    return result + inAmount
                }
                return result
            }.formatted())
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}
