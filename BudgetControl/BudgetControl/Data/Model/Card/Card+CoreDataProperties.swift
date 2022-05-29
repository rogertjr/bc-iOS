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

extension Card: Identifiable {
    typealias Handler = (Result<Card, Error>) -> Void
    
    static var allCardsRequest: NSFetchRequest<Card> {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Card.creationDate, ascending: false)]
        return request
    }
    
    static func createCard(
        with cardModel: Card,
        in context: NSManagedObjectContext,
        completion: @escaping Handler
    ) {        
        do {
            try context.save()
            completion(.success(cardModel))
        } catch {
            completion(.failure(error))
        }
    }

    func delete(
        _ cards: [Card],
        in context: NSManagedObjectContext,
        completion: @escaping (Result<[Card], Error>) -> Void
    ) {
        for card in cards {
            context.delete(card)
        }
        
        do {
            try context.save()
            completion(.success(cards))
        } catch {
            completion(.failure(error))
        }
    }

    func setSelected(
        _ card: Card,
        in context: NSManagedObjectContext,
        completion: @escaping Handler
    ) {
        card.isSelected.toggle()
        do {
            try context.save()
            completion(.success(card))
        } catch {
            completion(.failure(error))
        }
    }
}
