//
//  NewTransactionView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI
import Foundation

struct NewTransactionView: View {
    // MARK: - Env
    @Environment(\.dismiss) private var dismiss
    
    // MARK:  - Properties
    @ObservedObject private var viewModel: NewTransactionViewModel
    @State private var focus = false
    
    // MARK: - Init
    init(_ viewModel: NewTransactionViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Layout
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                headerLabelView
                currencyFieldView
                titleFieldView
                transactionTypeView
                dateFieldView
            }
            .frame(maxHeight: .infinity,alignment: .center)
            
            saveButtonView
        }
        .padding()
        .background {
            Color.gray.opacity(0.06)
                .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            closeButtonView
        }
        .alert(isPresented: $viewModel.hasError,
               error: viewModel.error) { }
    }
}

// MARK: - SubViews
private extension NewTransactionView {
    var headerLabelView: some View {
        Text("new_transaction_title".localized)
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    var currencyFieldView: some View {
        CurrencyTextField("0".currencyFormatting(),
                          value: $viewModel.amount,
                          isResponder: $focus,
                          alwaysShowFractions: true)
            .font(.system(size: 35))
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background {
                Capsule()
                    .fill(.white)
            }
            .padding(.horizontal, 20)
            .padding(.top)
            .onAppear {
                self.focus = true
            }
    }

    var titleFieldView: some View {
        Label {
            TextField("description".localized,
                      text: $viewModel.transactionTitle)
                .padding(.leading ,10)
        } icon: {
            Image(systemName: "doc.text.fill")
                .font(.title3)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white)
        }
        .padding(.top,25)
    }
    
    var transactionTypeView: some View {
        Label {
            CustomCheckboxes()
        } icon: {
            Image(systemName: "arrow.up.arrow.down")
                .font(.title3)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white)
        }
        .padding(.top, 5)
    }
    
    var dateFieldView: some View {
        Label {
            DatePicker.init("",
                            selection: $viewModel.date,
                            in: Date.distantPast...Date(),
                            displayedComponents: [.date])
                .datePickerStyle(.compact)
                .labelsHidden()
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading, 10)
        } icon: {
            Image(systemName: "calendar")
                .font(.title3)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background {
            RoundedRectangle(cornerRadius: 12,
                             style: .continuous)
                .fill(.white)
        }
        .padding(.top,5)
    }
    
    var saveButtonView: some View {
        Button(action: {
            viewModel.saveNewTransaction()
            if !viewModel.hasError {
                dismiss()
            }
        }) {
            Text("save".localized)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 12,
                                     style: .continuous)
                        .fill(Color.bcPurple)
                }
                .foregroundColor(.white)
                .padding(.bottom, 10)
        }
        .disabled(!viewModel.isAbleToContinue)
        .opacity(viewModel.isAbleToContinue ? 1 : 0.6)
    }
    
    var closeButtonView: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.title2)
                .foregroundColor(.bcPurple)
        }
        .padding()
    }
    
    // MARK: - View Builder
    @ViewBuilder
    func CustomCheckboxes() -> some View {
        HStack(spacing: 10) {
            ForEach([TransactionType.income, TransactionType.expense], id: \.self) { type in
                ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black, lineWidth: 2)
                        .frame(width: 20, height: 20)
                    
                    if viewModel.type == type {
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(.green)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.type = type
                }
                
                Text(type.rawValue.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.trailing, 10)
            }
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding(.leading, 10)
    }
}

// MARK: - PreviewProvider
struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView(.init())
    }
}
