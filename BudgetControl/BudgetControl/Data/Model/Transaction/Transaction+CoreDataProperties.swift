//
//  Transaction+CoreDataProperties.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 28/05/22.
//
//

import Foundation
import CoreData

extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var title: String
    @NSManaged public var amount: String
    @NSManaged public var date: Date
    @NSManaged public var color: String?
    @NSManaged public var id: UUID
    @NSManaged public var type: String
    @NSManaged public var card: Card

}

extension Transaction : Identifiable {
    func transactionsRequest(for card: Card) -> NSFetchRequest<Transaction> {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Card.transactions), card)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)]
        return request
    }

    static func createTransaction(
        with transactionModel: Transaction,
        card: Card,
        in context: NSManagedObjectContext,
        completion: @escaping (Result<Card, Error>) -> Void
    ) {
        
        card.addToTransactions(transactionModel)

        do {
            try context.save()
            completion(.success(card))
        } catch {
            completion(.failure(error))
        }
    }

    func delete(
        _ transactions: [Transaction],
        in context: NSManagedObjectContext,
        completion: (Result<[Transaction], Error>) -> Void
    ) {
        for transaction in transactions {
            context.delete(transaction)
        }
        do {
            try context.save()
            completion(.success(transactions))
        } catch {
            completion(.failure(error))
        }
    }
}
