//
//  NewCardViewModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 29/05/22.
//

import Foundation
import CoreData

final class NewCardViewModel: ObservableObject {
    // MARK: - Properties
    @Published var cardTitle: String = ""
    @Published var cardColor: CardColors = .black
    @Published var hasError = false
    @Published var error: NewCardError?
    
    private (set) var currentWallet: Wallet?
    
    var isAbleToContinue: Bool {
        !cardTitle.isEmpty
    }
    
    // MARK: - Init
    init(_ currentWallet: Wallet? = nil) {
        self.currentWallet = currentWallet
    }
    
    // MARK: - Persitence
    func saveNewCard() {
        guard let currentWallet = currentWallet else { return }
        PersistenceManager.shared.createCard(title: cardTitle,
                                             color: cardColor.rawValue,
                                             in: currentWallet) { result in
            switch result {
            case .success:
                print("✅ - Card successfully saved")
                self.hasError = false
            case .failure(let error):
                self.hasError = true
                self.error = .cardPersistance
                print("⚠️ - \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Error Handler
extension NewCardViewModel {
    enum NewCardError: LocalizedError {
        case cardPersistance
        
        var errorDescription: String? {
            switch self {
            case .cardPersistance:
                return "⚠️ - Error while saving card"
            }
        }
    }
}
