//
//  Wallet+CoreDataProperties.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 14/06/22.
//
//

import Foundation
import CoreData

extension Wallet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wallet> {
        return NSFetchRequest<Wallet>(entityName: "Wallet")
    }

    @NSManaged public var id: UUID
    @NSManaged public var userName: String?
    @NSManaged public var creationDate: Date
    @NSManaged public var cards: Set<Card>?
    public var cardList: [Card] {
        guard let setOfCards = cards else { return [] }
        return setOfCards.sorted(by: { $0.creationDate > $1.creationDate })
    }
}

// MARK: Generated accessors for cards
extension Wallet {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: Card)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: Card)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

extension Wallet : Identifiable {
    static var allWalletRequest: NSFetchRequest<Wallet> {
        let request: NSFetchRequest<Wallet> = Wallet.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Wallet.creationDate, ascending: false)]
        return request
    }
}
