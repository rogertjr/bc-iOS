//
//  PersistenceManager.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    // MARK: - Store Enum
    enum StoreType {
        case inMemory, persisted
    }
    
    // MARK: - Properties
    static let shared: PersistenceManager = PersistenceManager()
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    static var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: PersistenceManager.self)
        guard let url = bundle.url(forResource: "BC", withExtension: "momd") else {
            fatalError("Failed to locate momd file for BCModel")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load momd file for BCModel")
        }
        return model
    }()
    
    // MARK: - Init
    init(storeType: StoreType = .persisted) {
        persistentContainer = NSPersistentContainer(name: "BC",
                                                    managedObjectModel: Self.managedObjectModel)
        
        if storeType == .inMemory {
            guard let persistentStoreDescriptions = persistentContainer.persistentStoreDescriptions.first else {
                fatalError("Failed to obtain container persistent store url")
            }
            persistentStoreDescriptions.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed loading persistent stores with error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Util
extension PersistenceManager {
    typealias CardHandler = (Result<Card, Error>) -> Void

    // MARK: - Cards
    func createCard(
        title: String,
        color: String,
        completion: CardHandler
    ) {
        let card = Card(context: persistentContainer.viewContext)
        card.id = UUID()
        card.creationDate = Date()
        card.isSelected = true
        card.title = title
        card.color = color
        card.transactions = []
        
        do {
            try context.save()
            completion(.success(card))
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - Transactions
    func createTransaction(
        with transactionModel: Transaction,
        selectedCard: Card,
        completion: @escaping CardHandler
    ) {
        
        selectedCard.addToTransactions(transactionModel)

        do {
            try context.save()
            completion(.success(selectedCard))
        } catch {
            completion(.failure(error))
        }
    }
}
