//
//  TransactionRow.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    let currency: String
    let dateFormatter: DateFormatter  
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(transaction.title)
                    .font(.headline)
                Spacer()
                Text(formattedAmount(transaction: transaction, currency: currency))
                    .font(.subheadline)
                    .foregroundColor(amountColor(transaction: transaction))
            }
            Text(formatDate(transaction.date))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private func formattedAmount(transaction: Transaction, currency: String) -> String {
        var amount: Double = 0.0
        if let outAmount = Double(transaction.outAmount ?? "0.0"), outAmount > 0 {
            amount = -outAmount
        } else if let inAmount = Double(transaction.inAmount ?? "0.0"), inAmount > 0{
            amount = inAmount
        }
        return "\(currency)\(amount.formatted())"
    }
    
    private func amountColor(transaction: Transaction) -> Color {
        if let outAmount = Double(transaction.outAmount ?? "0.0"), outAmount > 0 {
            return .red
        }
        if let inAmount = Double(transaction.inAmount ?? "0.0"), inAmount > 0 {
            return .green
        }
        return .gray
    }
    
    private func formatDate(_ dateString: String) -> String {
        // Use the provided dateFormatter
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            return outputFormatter.string(from: date)
        }
        return "Invalid Date"
    }
}
