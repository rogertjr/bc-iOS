//
//  Card.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI

struct Card: Hashable {
    var cardNumber: String
    var transations: [Transaction]
    var imageName: String
    var isSelected = false
    
    var backgroundColor: Color {
        .gray
    }
    
    var textColor: Color {
        isSelected ? .white : .black
    }
}

// MARK: - Dummy Data
extension Card {
    static var dummyCardData: [Card] = [
        .init(cardNumber: "**** 2561", transations: Transaction.dummyTransactionData, imageName: "visa", isSelected: true),
        .init(cardNumber: "**** 4355", transations: [], imageName: "mastercard")]
}
