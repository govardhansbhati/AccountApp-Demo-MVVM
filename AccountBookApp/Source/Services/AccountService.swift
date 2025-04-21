//
//  AccountService.swift
//  AccountBookApp
//
//  Created by Govardhan Singh on 21/04/25.
//

import Foundation
import Combine

protocol AccountServiceProtocol {
    func fetchAccounts() -> AnyPublisher<[Account], Error>
}

class AccountService: AccountServiceProtocol {
    // Use the shared instance's formatter
    let dateFormatter = DateFormatterProvider.getFormatter()
    
    func fetchAccounts() -> AnyPublisher<[Account], Error> {
        guard let data = JSONLoader.loadJSON(from: "Accounts", withExtension: "txt"),
              let jsonString = String(data: data, encoding: .utf8),
              let jsonData = jsonString.data(using: .utf8) else {
            return Fail(error: NSError(domain: "AppError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to load or process data."])).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return Future<[Account], Error> { promise in
            do {
                let response = try decoder.decode(AccountsResponse.self, from: jsonData)
                promise(.success(response.accounts))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
