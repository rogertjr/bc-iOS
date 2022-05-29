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
    private (set) var context: NSManagedObjectContext
    
    private var selectedCard: Card?
    
    @Published var amount: String = ""
    @Published var type: TransactionType = .all
    @Published var date: Date = Date()
    @Published var transactionTitle: String = ""
    
    @Published var isAbleToContinue: Bool = true
    
    // MARK: - Helpers
    init(
        _ context: NSManagedObjectContext,
        selectedCard: Card?
    ) {
        self.context = context
        self.selectedCard = selectedCard
    }
    
    // MARK: - Helpers
    func currencySymbol() -> String {
        let locale = Locale.current
        guard let currentSymbol = locale.currencySymbol else { return "" }
        return currentSymbol
    }
    
    // MARK: - Data Persistence
    #warning("CREATE MODEL EXTENSION FOR PERSISTENCE")
    func saveNewTransaction() -> Bool {
        guard let selectedCard = selectedCard else { return false }
        
        let transaction = Transaction(context: context)
        transaction.id = UUID()
        transaction.title = transactionTitle
        transaction.color = "red"
        transaction.amount = amount
        transaction.type = type.rawValue
        #warning("theres a bug when changing date on datepicker")
        transaction.date = date
                
        selectedCard.addToTransactions(transaction)
        
        do {
            try context.save()
        } catch {
            print("Error - \(error.localizedDescription)")
            return false
        }
        
        return true
    }
}
