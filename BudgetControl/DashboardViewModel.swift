//
//  DashboardViewModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import Foundation

final class DashboardViewModel: ObservableObject {
    // MARK: - Properties
    @Published var goToNewTransaction: Bool = false
    @Published var filterTabSelected: TransactionType = .income
}
    
