//
//  NewTransactionViewModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import Foundation

final class NewTransactionViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var amount: String = ""
    @Published var type: TransactionType = .all
    @Published var date: Date = Date()
    @Published var description: String = ""
    
    @Published var isAbleToContinue: Bool = true
    
    // MARK: - Helpers
    func currencySymbol() -> String {
        let locale = Locale.current
        guard let currentSymbol = locale.currencySymbol else { return "" }
        return currentSymbol
    }
}
