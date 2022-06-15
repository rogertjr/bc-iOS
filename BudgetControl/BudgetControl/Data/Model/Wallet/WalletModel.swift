//
//  WalletModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 14/06/22.
//

import Foundation
import CoreData
import SwiftUI

struct WalletModel: Identifiable {
    // MARK: - Properties
    private var wallet: Wallet
    
    // MARK: - Init
    init(_ wallet: Wallet) {
        self.wallet = wallet
    }
    
    var id: UUID {
        wallet.id
    }
    
    var userName: String {
        wallet.userName ?? ""
    }
    
    var creationDate: Date {
        wallet.creationDate
    }
    
    var cards: Set<Card> {
        wallet.cards ?? Set<Card>()
    }
    
    var cardList: [CardModel] {
        wallet.cardList.map(CardModel.init)
    }
}
