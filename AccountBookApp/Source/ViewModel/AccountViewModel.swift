//
//  AccountViewModel.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//

import Foundation
import Combine

class AccountViewModel: ObservableObject {
    @Published var accounts: [Account] = []
    private var cancellables = Set<AnyCancellable>()
    private let accountService: AccountServiceProtocol

    init(accountService: AccountServiceProtocol = AccountService()) {
        self.accountService = accountService
    }
    //  Loads the accounts from the account service.
    func loadAccounts() {
        accountService.fetchAccounts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error loading accounts: \(error)")
                case .finished:
                    print("Successfully loaded accounts")
                }
            }, receiveValue: { fetchedAccounts in
                self.accounts = fetchedAccounts.sorted(by: { $0.sortingOrder < $1.sortingOrder })
            })
            .store(in: &cancellables)
    }
}
