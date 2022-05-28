//
//  TransactionsListView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI

struct TransactionsListView: View {
    // MARK: - Properties
    var cards: [CardModel]
    var shouldFilter: Bool = false
    var filterSelected: TransactionType = .income
    
    // MARK: - Subviews
    var headerLabel: some View {
        Text("Transações")
            .font(.title2.bold())
            .opacity(0.7)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Layout
    var body: some View {
        VStack(spacing: 16) {
            headerLabel
            
            if let selectedCard = cards.filter({ $0.isSelected == true }).first {
                if shouldFilter {
                    ForEach(selectedCard.transactionList.filter { return $0.type == filterSelected }) { transaction in
                        TransactionCellView(transaction: transaction)
                    }
                } else {
                    ForEach(selectedCard.transactionList) { transaction in
                        TransactionCellView(transaction: transaction)
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}
