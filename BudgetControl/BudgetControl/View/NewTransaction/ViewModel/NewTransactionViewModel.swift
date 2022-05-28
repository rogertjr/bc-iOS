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
//    @Published var type: TransactionType = .all
    @Published var date: Date = Date()
    @Published var description: String = ""
    
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
    func saveNewTransaction() -> Bool {
        guard let selectedCard = selectedCard else { return false }

//        let card = Card(context: context)
//        card.id = UUID()
//        card.creationDate = Date()
//        card.isSelected = true
//        card.title = "Nubank"
//
        let transaction = Transaction(context: context)
        transaction.id = UUID()
        transaction.title = description
        transaction.color = "red"
        transaction.amount = amount
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
