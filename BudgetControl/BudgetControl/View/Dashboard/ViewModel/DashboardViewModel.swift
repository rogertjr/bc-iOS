//
//  DashboardViewModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import Foundation
import CoreData


@MainActor
final class DashboardViewModel: NSObject, ObservableObject {
    // MARK: - Properties
    private (set) var context: NSManagedObjectContext
    
    @Published var cards = [CardModel]()
    private (set) var selectedCard: Card?
    @Published var goToNewTransaction: Bool = false
    @Published var filterTabSelected: TransactionType = .income
    
    private let fetchedResultsController: NSFetchedResultsController<Card>
    
    // MARK: - Init
    init(_ context: NSManagedObjectContext) {
        self.context = context
        fetchedResultsController = NSFetchedResultsController(fetchRequest: Card.allCardsRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            guard let cards = fetchedResultsController.fetchedObjects else { return }
            self.selectedCard = cards.filter({ $0.isSelected == true }).first
            self.cards = cards.map(CardModel.init)
        } catch {
            print("Error while fetching cards - \(error.localizedDescription)")
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension DashboardViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let cards = controller.fetchedObjects as? [Card] else { return }
        self.cards = cards.map(CardModel.init)
    }
}
    
