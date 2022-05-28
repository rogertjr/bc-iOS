//
//  CardModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 28/05/22.
//

import Foundation
import CoreData

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
    
    var transactionList: [Transaction] {
        card.transactionList
    }
}
