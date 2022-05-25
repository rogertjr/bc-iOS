//
//  TransactionCellView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI

struct TransactionCellView: View {
    // MARK: - Properties
    var transation: Transaction
    
    // MARK: - Layout
    var body: some View {
        HStack(spacing: 12) {
            // MARK: First Letter Avatar
            if let first = transation.remark.first {
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background {
                        Circle()
                            .fill(.gray)
                    }
            }
            
            Text(transation.remark)
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .trailing, spacing: 7) {
                // TODO: Implement income and expense
                let price = transation.type == .expense ? "-R$ 99,00" : "R$ 99,00"
                Text(price)
                    .font(.callout)
                    .opacity(0.7)
                    .foregroundColor(transation.type == .expense ? .red : .green)
                Text(transation.date.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .opacity(0.5)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
        .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
    }
}
