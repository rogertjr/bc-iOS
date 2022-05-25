//
//  Expense.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI

enum TransactionType: String {
    case income = "Income"
    case expense = "expenses"
    case all = "ALL"
}

struct Transaction: Identifiable, Hashable {
    var id = UUID().uuidString
    var remark: String
    var amount: Double
    var date: Date
    var type: TransactionType
    var color: String
}

// MARK: - Dummy Data
extension Transaction {
    static var dummyTransactionData: [Transaction] = [
        Transaction(remark: "iFood", amount: 99, date: Date(timeIntervalSince1970: 1652987245), type: .expense, color: "Yellow"),
        Transaction(remark: "iFood", amount: 19, date: Date(timeIntervalSince1970: 1652814445), type: .expense, color: "Red"),
        Transaction(remark: "Amazon Purchase", amount: 299, date: Date(timeIntervalSince1970: 1652209645), type: .expense, color: "Yellow"),
        Transaction(remark: "Stocks", amount: 2599, date: Date(timeIntervalSince1970: 1652036845), type: .income, color: "Purple"),
        Transaction(remark: "In App Purchase", amount: 499, date: Date(timeIntervalSince1970: 1651864045), type: .income, color: "Red"),
        Transaction(remark: "Apple Music", amount: 25, date: Date(timeIntervalSince1970: 1651518445), type: .expense, color: "Green")]
}
