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
    private (set) var context: NSManagedObjectContext
    
    @Published var cardTitle: String = ""
    @Published var cardColor: String = "Black"
    var isAbleToContinue: Bool {
        !cardTitle.isEmpty && !cardColor.isEmpty
    }
    
    let cardColors: [String] = ["Yellow", "Green", "Blue", "Purple", "Red", "Orange", "Black"]
     
    // MARK: - Helpers
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Persitence
    func saveNewCard() {
        let card = Card(context: context)
        card.id = UUID()
        card.creationDate = Date()
        card.isSelected = true
        card.title = cardTitle
        card.color = cardColor
        
        Card.createCard(with: card,
                        in: context) { result in
            switch result {
            case .success:
                print("✅ - Card successfully saved")
            case .failure(let error):
                print("⚠️ - \(error.localizedDescription)")
            }
        }
    }
}
