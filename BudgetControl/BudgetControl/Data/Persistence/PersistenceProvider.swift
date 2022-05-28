//
//  PersistenceController.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import Foundation
import CoreData

final class PersistenceProvider {
    enum StoreType {
        case inMemory, persisted
    }
    
    static var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: PersistenceProvider.self)
        guard let url = bundle.url(forResource: "BC", withExtension: "momd") else {
            fatalError("Failed to locate momd file for BCModel")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load momd file for BCModel")
        }
        return model
    }()
    
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    static let `default`: PersistenceProvider = PersistenceProvider()
    init(storeType: StoreType = .persisted) {
        persistentContainer = NSPersistentContainer(name: "BC", managedObjectModel: Self.managedObjectModel)
        
        if storeType == .inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed loading persistent stores with error: \(error.localizedDescription)")
            }
        }
    }
}

