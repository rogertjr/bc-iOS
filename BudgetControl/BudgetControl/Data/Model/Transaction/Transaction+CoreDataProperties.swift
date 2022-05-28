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

    @discardableResult
    func createTransaction(
        with transactionModel: Transaction,
        card: Card,
        in context: NSManagedObjectContext
    ) -> Transaction {
        let transaction = Transaction(context: context)
        transaction.id = UUID()
        transaction.title = transactionModel.title
        transaction.color = "red"
        transaction.amount = "99,00"
        transaction.date = Date()
        card.addToTransactions(transaction)

        try? context.save()
        return transaction
    }

    func delete(
        _ transactions: [Transaction],
        in context: NSManagedObjectContext
    ) {
        for transaction in transactions {
            context.delete(transaction)
        }
        try? context.save()
    }
}
