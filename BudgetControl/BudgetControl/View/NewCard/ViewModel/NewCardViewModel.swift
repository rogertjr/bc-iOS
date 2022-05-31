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
    var isAbleToContinue: Bool {
        !cardTitle.isEmpty
    }
    
    // MARK: - Persitence
    func saveNewCard() {
        PersistenceManager.shared.createCard(title: cardTitle,
                                             color: cardColor.rawValue) { result in
            switch result {
            case .success:
                print("✅ - Card successfully saved")
            case .failure(let error):
                print("⚠️ - \(error.localizedDescription)")
            }
        }
    }
}
