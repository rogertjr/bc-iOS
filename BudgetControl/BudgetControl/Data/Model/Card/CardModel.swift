//
//  CardModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 28/05/22.
//

import Foundation
import CoreData
import SwiftUI

enum CardColors: String, CaseIterable {
    case yellow = "Yellow"
    case green = "Green"
    case blue = "Blue"
    case purple = "Purple"
    case red = "Red"
    case orange = "Orange"
    case black = "Black"
}

struct CardModel: Identifiable {
    // MARK: - Properties
    private var card: Card
    
    // MARK: - Init
    init(_ card: Card) {
        self.card = card
    }
    
    var id: UUID {
        card.id
    }
    
    var title: String {
        card.title
    }
    
    var color: String {
        card.color ?? ""
    }
    
    var isSelected: Bool {
        card.isSelected
    }
    
    var creationDate: Date {
        card.creationDate
    }
    
    var transactionList: [TransactionModel] {
        card.transactionList.map(TransactionModel.init)
    }
    
    var income: String {
        var total: Double = 0
        card.transactionList.forEach { transaction in
            if let type = TransactionType(rawValue: transaction.type),
               let currentAmount = Double(transaction.amount),
               type == .income {
                total += currentAmount
            }
        }
        
        return total.string
    }
    
    var expense: String {
        var total: Double = 0
        card.transactionList.forEach { transaction in
            if let type = TransactionType(rawValue: transaction.type),
               let currentAmount = Double(transaction.amount),
               type == .expense {
                total += currentAmount
            }
        }
        
        return total.string
    }
    
    var balance: String {
        var total: Double = 0
        card.transactionList.forEach { transaction in
            if let type = TransactionType(rawValue: transaction.type),
               let currentAmount = Double(transaction.amount) {
                
                if type == .income {
                    total += currentAmount
                } else {
                    total -= currentAmount
                }
            }
        }
        
        return total.string
    }
}
