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
            ForEach(wallet.cards[0].transations) { transaction in
                TransactionCellView(transation: transaction)
            }
        }
    }
}
