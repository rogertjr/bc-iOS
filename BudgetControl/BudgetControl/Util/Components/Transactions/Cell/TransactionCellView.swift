//
//  TransactionCellView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI

struct TransactionCellView: View {
    // MARK: - Properties
    var transaction: TransactionModel
    
    // MARK: - Layout
    var body: some View {
        HStack(spacing: 12) {
            if let first = transaction.title.first {
                avatarImageView(first)
            }
            transactionTitleView
            VStack(alignment: .trailing, spacing: 7) {
                transactionAmountView()
                transactionDateView
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15,
                             style: .continuous)
                .fill(Color.bcBackground)
        }
        .shadow(color: .black.opacity(0.08),
                radius: 5, x: 5, y: 5)
    }
}

// MARK: - Subviews
private extension TransactionCellView {
    @ViewBuilder
    func avatarImageView(_ letter: String.Element) -> some View {
        Text(String(letter))
            .font(.title.bold())
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background {
                Circle()
                    .fill(transaction.type == .expense ? .red : .green)
                    .opacity(0.7)
            }
    }
    
    var transactionTitleView: some View {
        Text(transaction.title)
            .fontWeight(.semibold)
            .lineLimit(1)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
    }
    
    @ViewBuilder
    func transactionAmountView() -> some View {
        let amount = transaction.amount.currencyFormatting()
        let price = (transaction.type == .expense)
            ? String(format: "-%@", amount)
            : String(format: "+%@", amount)
        Text(price)
            .font(.callout)
            .opacity(0.7)
            .foregroundColor(transaction.type == .expense ? .red : .green)
    }
    
    var transactionDateView: some View {
        Text(transaction.date.formatted(date: .numeric,
                                        time: .omitted))
            .font(.caption)
            .opacity(0.5)
    }
}
