//
//  BaseModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 28/05/22.
//

import Foundation
import CoreData

protocol BaseModel {
    static var viewContext: NSManagedObjectContext { get }
    func delete() throws
    func save() throws
}

extension BaseModel where Self: NSManagedObject {
    static var viewConext: NSManagedObjectContext {
        PersistenceManager.shared.context
    }
    
    func save() throws {
        try Self.viewContext.save()
    }
    
    func delete() throws {
        Self.viewContext.delete(self)
        try save()
    }
}
