//
//  CardCarouselCellView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI

struct CardCarouselCellView: View {
    // MARK: - Properties
    var viewModel: CardCarouselViewModel
    
    // MARK: - Init
    init(_ viewModel: CardCarouselViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Layout
    var body: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 20,
                             style: .continuous)
                .fill(Color(viewModel.card.color))
            
            VStack(spacing: 16) {
                VStack(spacing: 16) {
                    currentMonthView
                    cardBalanceView
                }
                .offset(y: -10)
                
                transactionsView
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .frame(width: 340,
               height: 220)
        .padding(.top)
    }
}

// MARK: - Subviews
private extension CardCarouselCellView {
    var currentMonthView: some View {
        Text(viewModel.currentMonth.currentMonthDateString())
            .font(.callout)
            .fontWeight(.semibold)
    }
    
    var cardBalanceView: some View {
        Text(viewModel.card.balance.currencyFormatting())
            .font(.system(size: 35, weight: .bold))
            .lineLimit(1)
    }
    
    var transactionsView: some View {
        HStack(spacing: 16) {
            CircleImageView(imageSystemName: "arrow.down",
                            foregroundColor: .green)
            
            incomeTransactionsView
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            
            CircleImageView(imageSystemName: "arrow.up",
                            foregroundColor: .red)
            
            expenseTransactionsView
        }
        .padding(.horizontal)
        .padding(.trailing)
        .offset(y: 15)
    }
    
    var incomeTransactionsView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("income".localized)
                .font(.caption)
                .opacity(0.7)
            
            Text(viewModel.card.income.currencyFormatting())
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(1)
                .fixedSize()
        }
    }
    
    var expenseTransactionsView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("expense".localized)
                .font(.caption)
                .opacity(0.7)
            
            Text(viewModel.card.expense.currencyFormatting())
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(1)
                .fixedSize()
        }
    }
}
