# AccountApp-Demo-MVVM
A clean, modular SwiftUI application that parses and displays customer account and transaction data from a JSON file (Accounts.txt). Built with a strong focus on SOLID principles, clean architecture, and maintainability.

## File Structure

* `DateFormatterProvider.swift`: Contains the implementation of the `DateFormatterProvider` singleton.
* `ContentView.swift`: The main view for the application, demonstrating how to use the `DateFormatterProvider`.
* `AccountRow.swift`: A view representing a single account in the list.
* `AccountDetailView.swift`: A view displaying the details of a single account.
* `TransactionRow.swift`: A view representing a single transaction.
* `AccountViewModel.swift`: The view model for `ContentView`, responsible for fetching and managing account data.
* `AccountService.swift`: A service responsible for fetching account data.
* `Account.swift`: Data model for an account.
* `Card.swift`: Data model for a card.
* `Transaction.swift`: Data model for a transaction.

## Classes

### `DateFormatterProvider`

A singleton class that provides a shared `DateFormatter` instance.

* `shared`: The static shared instance of the `DateFormatterProvider`.
* `dateFormatter`: A weak reference to a `DateFormatter`. The weak reference prevents a retain cycle.
* `init()`: Private initializer to enforce the singleton pattern. Configures the `DateFormatter` with the format "dd/MM/yyyy".
* `getFormatter()`: A static method that returns the shared `DateFormatter` instance. It retrieves the weakly held formatter. If the weak reference has become nil, it creates a new formatter, stores it in the weak reference, and returns it.
* `deinit`: Deinitializer for the `DateFormatterProvider`.

### `ContentView`

The main view for the application, displaying a list of accounts.

* `accountViewModel`: A `@StateObject` for managing the account data.
* `dateFormatter`: A constant that stores the shared instance of `DateFormatter`.
* `body`: Describes the user interface, a list of accounts with navigation links to detail views.
* `onAppear`: Calls the `loadAccounts()` method on the view model when the view appears.

### `AccountRow`

A view representing a single account in the list.

* `account`: The account to display.
* `body`: Displays the account name and balance.

### `AccountDetailView`

A view displaying the details of a single account.

* `account`: The account to display the details for.
* `dateFormatter`: The shared `DateFormatter` instance.
* `body`: Displays account details, cards, and transactions.

### `TransactionRow`

A view representing a single transaction.

* `transaction`: The transaction to display.
* `currency`: The currency.
* `dateFormatter`: The shared `DateFormatter` instance.
* `body`: Displays the transaction title, amount, and date.
* `formattedAmount(transaction:currency:)`: Formats the transaction amount with the appropriate sign and currency.
* `amountColor(transaction:)`: Returns the appropriate color for the transaction amount.
* `formatDate(_:)`: Formats the date string into a user-friendly date format.

### `AccountViewModel`

The view model for `ContentView`.

* `accounts`: A `@Published` property holding the array of accounts.
* `cancellables`: A set to hold Combine subscriptions.
* `accountService`: The service responsible for fetching account data.
* `init(accountService:)`: Initializes the view model with an account service.
* `loadAccounts()`: Loads the accounts from the account service, updates the `accounts` property, and handles errors.

### `AccountService`

A protocol for the account service.

* `fetchAccounts()`: Returns a publisher that fetches accounts.

### `AccountService` Implementation

Implementation of the `AccountServiceProtocol`.

* `dateFormatter`: The shared `DateFormatter` instance.
* `fetchAccounts()`: Fetches account data from a JSON file and decodes it into an array of `Account` objects.

### Data Models

* `AccountsResponse`: Represents the top-level JSON structure.
* `Account`: Represents an account.
* `Card`: Represents a card.
* `Transaction`: Represents a transaction.

## Key Concepts

* **Singleton:** The `DateFormatterProvider` ensures that only one instance of `DateFormatter` is created, preventing unnecessary overhead.
* **Weak Reference:** The `dateFormatter` property in `DateFormatterProvider` is a weak reference, which prevents a retain cycle.
* **Lazy Initialization:** The `DateFormatter` is only created when it's first needed, and if the weak reference has been deallocated.
* **Date Formatting:** The code formats dates consistently using the "dd/MM/yyyy" format.
* **MVVM:** The code follows the Model-View-ViewModel architecture.
* **Combine:** Used for asynchronous operations.
* **SOLID Principles:** The code adheres to SOLID principles to ensure maintainability, scalability, and testability.

## SOLID Principles

* **Single Responsibility Principle (SRP):**
    * `AccountService` is responsible for fetching account data.
    * `AccountViewModel` is responsible for managing the data for the view.
    * Views (`ContentView`, `AccountRow`, `AccountDetailView`, `TransactionRow`) are responsible for displaying the data.
    * `DateFormatterProvider` is responsible for providing a consistent date formatter.
* **Open/Closed Principle (OCP):**
    * The `AccountServiceProtocol` allows for different implementations of data fetching (e.g., from a file, a database, or a network) without modifying the classes that depend on it.
* **Liskov Substitution Principle (LSP):**
    * The code uses protocols (`AccountServiceProtocol`) and inheritance in a way that ensures that derived classes can be substituted for their base classes without altering the correctness of the program.
* **Interface Segregation Principle (ISP):**
    * The code uses focused protocols. For example, the `AccountServiceProtocol` only defines the `fetchAccounts` method, ensuring that classes that implement it only need to implement the methods that are relevant to them.
* **Dependency Inversion Principle (DIP):**
    * `AccountViewModel` depends on the `AccountServiceProtocol` rather than a concrete implementation of `AccountService`. This allows for dependency injection and makes the code more testable.
    * High-level modules (like `AccountViewModel`) do not depend on low-level modules (like `AccountService`). Both depend on abstractions (`AccountServiceProtocol`).

## Usage

1.  **Date Formatting:** Use `DateFormatterProvider.getFormatter()` to obtain the shared `DateFormatter` instance. This ensures consistent date formatting throughout the application.

2.  **Fetching Accounts:** The `AccountService` fetches account data, and the `AccountViewModel` manages and publishes this data to the `ContentView`.

3.  **Displaying Data:** The views (`ContentView`, `AccountRow`, `AccountDetailView`, and `TransactionRow`) use SwiftUI to display the account and transaction data.
