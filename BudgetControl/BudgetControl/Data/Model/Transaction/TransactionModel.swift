//
//  TransactionModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 28/05/22.
//

import Foundation
import CoreData

public enum TransactionType: String {
    case income
    case expense
    case all
}

struct TransactionModel: Identifiable {
    // MARK: - Properties
    private var transaction: Transaction
    
    // MARK: - Init
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    var id: UUID {
        transaction.id
    }
    
    var title: String {
        transaction.title
    }
    
    var amount: String {
        transaction.amount
    }
    
    var date: Date {
        transaction.date
    }
    var color: String {
        transaction.color ?? ""
    }
    
    var card: Card {
        transaction.card
    }
    
    var type: TransactionType {
        TransactionType(rawValue: transaction.type) ?? .income
    }
}
