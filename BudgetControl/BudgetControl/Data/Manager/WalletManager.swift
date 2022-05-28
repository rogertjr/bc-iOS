//
//  WalletManager.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import Foundation

class WalletManager: ObservableObject {
    @Published var cards: [Card] = []
    
    var selectedCard: Card {
        cards.first(where: { $0.isSelected })!
    }
}
