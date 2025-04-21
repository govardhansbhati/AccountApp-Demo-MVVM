//
//  ContentView.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    @StateObject var accountViewModel = AccountViewModel()
    
    let dateFormatter = DateFormatterProvider.getFormatter()
    
    var body: some View {
        NavigationView {
            List {
                ///  Iterates over the accounts in the view model and creates a NavigationLink for each one.  Each link presents an AccountDetailView when tapped.
                ForEach(accountViewModel.accounts) { account in
                    NavigationLink(destination: AccountDetailView(account: account, dateFormatter: dateFormatter)) {
                        AccountRow(account: account)
                    }
                }
            }
            .navigationTitle("Accounts")
            .onAppear {
                accountViewModel.loadAccounts()
            }
        }
    }
}

#Preview {
    ContentView()
}
