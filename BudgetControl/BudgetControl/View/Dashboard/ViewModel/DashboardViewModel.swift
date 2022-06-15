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
    private (set) var currentWallet: Wallet?
    private (set) var selectedCard: Card? 
    
    @Published var wallet: WalletModel?
    @Published var filterTabSelected: TransactionType = .income
    @Published var goToNewTransaction: Bool = false
    @Published var goToNewCard: Bool = false

    @Published var hasError = false
    @Published var error: DashboardError?
    
    private let fetchedResultsController: NSFetchedResultsController<Wallet>
    
    // MARK: - Init
    init(_ context: NSManagedObjectContext) {
        self.context = context
        fetchedResultsController = NSFetchedResultsController(fetchRequest: Wallet.allWalletRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            guard let wallet = fetchedResultsController.fetchedObjects,
                let walletModel = wallet.map(WalletModel.init).first
            else { return }
            self.currentWallet = wallet.first
            self.wallet = walletModel

            self.selectedCard = walletModel.cards.filter({ $0.isSelected == true }).first
            self.hasError = false
        } catch {
            self.hasError = true
            self.error = .walletFetch
            print("⚠️ - \(error.localizedDescription)")
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension DashboardViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let wallet = fetchedResultsController.fetchedObjects,
            let walletModel = wallet.map(WalletModel.init).first
        else { return }
        self.currentWallet = wallet.first
        self.wallet = walletModel
        
        selectedCard = walletModel.cards.filter({ $0.isSelected == true }).first
    }
}

// MARK: - Error Handler
extension DashboardViewModel {
    enum DashboardError: LocalizedError {
        case walletFetch
        
        var errorDescription: String? {
            switch self {
            case .walletFetch:
                return "⚠️ - Error while fetching wallet data"
            }
        }
    }
}
