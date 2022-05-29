//
//  Card+CoreDataProperties.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 28/05/22.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var title: String
    @NSManaged public var color: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var creationDate: Date
    @NSManaged public var id: UUID
    @NSManaged public var transactions: Set<Transaction>?
    public var transactionList: [Transaction] {
        guard let setOfTransation = transactions else { return [] }
        return setOfTransation.sorted(by: { $0.date > $1.date })
    }
}

// MARK: Generated accessors for transactions
extension Card {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension Card : Identifiable {
    static var allCardsRequest: NSFetchRequest<Card> {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Card.creationDate, ascending: false)]
        return request
    }
    
    @discardableResult
    func createCard(
        with cardModel: Card,
        in context: NSManagedObjectContext
    ) -> Card {
        let card = Card(context: context)
        card.id = UUID()
        card.creationDate = Date()
        card.title = cardModel.title
        card.color = cardModel.color
        card.isSelected = true
        card.transactions = []

        try? context.save()
        return card
    }

    func delete(
        _ cards: [Card],
        in context: NSManagedObjectContext
    ) {
        for card in cards {
            context.delete(card)
        }

        try? context.save()
    }

    func setSelected(
        _ card: Card,
        in context: NSManagedObjectContext
    ) {
        card.isSelected.toggle()
        try? context.save()
    }
}