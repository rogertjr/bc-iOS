//
//  NewTransactionViewModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import Foundation
import CoreData

final class NewTransactionViewModel: ObservableObject {
    
    // MARK: - Properties
    private var selectedCard: Card?

    @Published var amount: Double?
    @Published var type: TransactionType = .all
    @Published var date: Date = Date()
    @Published var transactionTitle: String = ""
    
    @Published var hasError = false
    @Published var error: TransactionError?
    
    var isAbleToContinue: Bool {
        !transactionTitle.isEmpty && type != .all && amount != nil
    }
    
    // MARK: - Helpers
    init(_ selectedCard: Card? = nil) {
        self.selectedCard = selectedCard
    }
    
    // MARK: - Helpers
    func currencySymbol() -> String {
        let locale = Locale.current
        guard let currentSymbol = locale.currencySymbol else { return "" }
        return currentSymbol
    }
    
    // MARK: - Data Persistence
    func saveNewTransaction() {
        guard let selectedCard = selectedCard else { return }
        
        let transaction = Transaction(context: PersistenceManager.shared.context)
        transaction.id = UUID()
        transaction.title = transactionTitle
        transaction.amount = amount?.string ?? "0"
        transaction.type = type.rawValue
        transaction.date = date
        
        PersistenceManager.shared.createTransaction(with: transaction,
                                                    selectedCard: selectedCard) { result in
            switch result {
            case .success:
                self.hasError = false
                print("✅ - Transaction successfully saved")
            case .failure(let error):
                self.hasError = true
                self.error = .transactionPersistance
                print("⚠️ - \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Error Handler
extension NewTransactionViewModel {
    enum TransactionError: LocalizedError {
        case transactionPersistance
        
        var errorDescription: String? {
            switch self {
            case .transactionPersistance:
                return "⚠️ - Error while saving transaction"
            }
        }
    }
}
