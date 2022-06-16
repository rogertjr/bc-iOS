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
    
    // MARK: - Layout
    var body: some View {
        VStack(spacing: 16) {
            headerLabel
            if let selectedCard = cards.filter({ $0.isSelected == true }).first {
                if selectedCard.transactionList.count > 0 {
                    if shouldFilter {
                        let filteredList = selectedCard.transactionList.filter { return $0.type == filterSelected }
                        if filteredList.count > 0 {
                            ForEach(filteredList) { transaction in
                                TransactionCellView(transaction: transaction)
                            }
                        } else {
                            emptyListView
                                .padding(.top, -12)
                                .padding(.bottom, 12)
                        }
                    } else {
                        ForEach(selectedCard.transactionList) { transaction in
                            TransactionCellView(transaction: transaction)
                        }
                    }
                } else {
                    emptyListView
                }
            } else {
                emptyListView
            }
        }
        .padding(.bottom, 12)
    }
}

// MARK: - Subviews
private extension TransactionsListView {
    var headerLabel: some View {
        Text("transaction_list_title".localized)
            .font(.title2.bold())
            .frame(maxWidth: .infinity,
                   alignment: .leading)
    }
    
    var emptyListView: some View {
        Text("empty_transaction_description".localized)
            .padding(.top)
    }
}
