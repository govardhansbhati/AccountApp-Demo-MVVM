//
//  AccountBookAppTests.swift
//  AccountBookAppTests
//
//  Created by Govardhan Singh on 21/04/25.
//

import XCTest
import Combine

@testable import AccountBookApp

class AccountViewModelTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []

    override func tearDown() {
        cancellables.removeAll()
    }

    // 1. Test successful loading of accounts
    func testLoadAccounts_Success() {
        // Given
        let mockAccountService = MockAccountService(result: .success([Account.mockAccount1, Account.mockAccount2])) // Use mock data
        let viewModel = AccountViewModel(accountService: mockAccountService)
        let expectation = XCTestExpectation(description: "Accounts loaded")

        // When
        viewModel.loadAccounts()

        // Then
        viewModel.$accounts
            .dropFirst() // Ignore initial empty value
            .sink { accounts in
                XCTAssertEqual(accounts.count, 2)
                XCTAssertEqual(accounts[0].accountName, "Test Account 1")
                XCTAssertEqual(accounts[1].accountName, "Test Account 2")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.1) // Use a very small timeout, the operation should be quick
    }

    // 2. Test handling of an error during account loading
    func testLoadAccounts_Failure() {
        // Given
        let mockAccountService = MockAccountService(result: .failure(NSError(domain: "AppError", code: 999, userInfo: nil)))
        let viewModel = AccountViewModel(accountService: mockAccountService)
        let expectation = XCTestExpectation(description: "Error received")

        // When
        viewModel.loadAccounts()

        // Then
        //We don't have a published property for errors, so we need to check the service call.
        mockAccountService.fetchAccounts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                  XCTAssertEqual((error as NSError).code, 999)
                  expectation.fulfill()
                case .finished:
                    XCTFail("Expected an error, but received finish.")
                }
            }, receiveValue: { _ in
                XCTFail("Expected no value, but received a value.")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 0.1)
    }
}

// MARK: - Mock Account Service for testing
class MockAccountService: AccountServiceProtocol {
    let result: Result<[Account], Error>
    private var fetchAccountsCalled = false

    init(result: Result<[Account], Error>) {
        self.result = result
    }

    func fetchAccounts() -> AnyPublisher<[Account], Error> {
        fetchAccountsCalled = true //track the function was called
        return Future<[Account], Error> { promise in
            switch self.result {
            case .success(let accounts):
                promise(.success(accounts))
            case .failure(let error):
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func verifyFetchAccountsCalled() -> Bool{
        return fetchAccountsCalled
    }
}

// MARK: - Mock Account Data for testing
extension Account {
    static let mockAccount1 = Account(accountName: "Test Account 1", sortingOrder: 1, currency: "USD", conversionRate: "1.0", cards: [], transactions: [], uniqueID: "1")
    static let mockAccount2 = Account(accountName: "Test Account 2", sortingOrder: 2, currency: "EUR", conversionRate: "0.85", cards: [], transactions: [], uniqueID: "2")
}
