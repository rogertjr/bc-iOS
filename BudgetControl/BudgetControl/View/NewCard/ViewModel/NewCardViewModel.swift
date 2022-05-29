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
    @Published var isAbleToContinue: Bool = true
     
    // MARK: - Helpers
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Persitence
    func saveNewCard() -> Bool {
        let card = Card(context: context)
        card.id = UUID()
        card.creationDate = Date()
        card.isSelected = true
        card.title = cardTitle
        
        do {
            try context.save()
            return true
        } catch {
            print("Error while saving card - \(error.localizedDescription)")
        }
        return false
    }
}
