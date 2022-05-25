//
//  TransactionsListView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI

struct TransactionsListView: View {
    // MARK: - Properties
    @EnvironmentObject var wallet: WalletManager
    var shouldFilter: Bool = false
    var filterSelected: TransactionType
    
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
            if shouldFilter {
                ForEach(wallet.selectedCard.transations.filter { return $0.type == filterSelected }) { transaction in
                    TransactionCellView(transation: transaction)
                }
            } else {
                ForEach(wallet.cards[0].transations) { transaction in
                    TransactionCellView(transation: transaction)
                }
            }
        }
    }
}
