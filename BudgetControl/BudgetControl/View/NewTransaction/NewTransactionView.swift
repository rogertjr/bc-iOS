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
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    // MARK: - Init
    init(_ viewModel: NewTransactionViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - SubViews
    var headerLabelView: some View {
        Text("Adicionar Transação")
            .font(.title2)
            .fontWeight(.semibold)
            .opacity(0.5)
    }
    
    // TODO: - Add currency field handler
    var valueFieldView: some View {
        TextField("0", text: $viewModel.amount)
            .font(.system(size: 35))
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
            .background {
                Text(viewModel.amount == "" ? "0" : viewModel.amount)
                    .font(.system(size: 35))
                    .opacity(0)
                    .overlay(alignment: .leading) {
                        Text(viewModel.currencySymbol())
                            .opacity(0.5)
                            .offset(x: -25, y: 5)
                    }
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background {
                Capsule()
                    .fill(.white)
            }
            .padding(.horizontal, 20)
            .padding(.top)
    }

    var descriptionFieldView: some View {
        Label {
            TextField("Descrição",text: $viewModel.description)
                .padding(.leading ,10)
        } icon: {
            Image(systemName: "list.bullet.rectangle.portrait.fill")
                .font(.title3)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white)
        }
        .padding(.top,25)
    }
    
    var transactionTypeView: some View {
        Label {
            // MARK: CheckBoxes
            CustomCheckboxes()
        } icon: {
            Image(systemName: "arrow.up.arrow.down")
                .font(.title3)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white)
        }
        .padding(.top, 5)
    }
    
    var dateFieldView: some View {
        Label {
            DatePicker.init("", selection: $viewModel.date, in: Date.distantPast...Date(), displayedComponents: [.date])
                .datePickerStyle(.compact)
                .labelsHidden()
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading, 10)
        } icon: {
            Image(systemName: "calendar")
                .font(.title3)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white)
        }
        .padding(.top,5)
    }
    
    var saveButtonView: some View {
        Button(action: {
            if viewModel.saveNewTransaction() {
                dismiss()
            }
        }) {
            Text("Salvar")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.gray)
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
                .foregroundColor(.black)
                .opacity(0.7)
        }
        .padding()
    }
    
    // MARK: - Layout
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                headerLabelView
                valueFieldView
                descriptionFieldView
                transactionTypeView
                dateFieldView
            }
            
            .frame(maxHeight: .infinity,alignment: .center)
            
            saveButtonView
        }
        .padding()
        .background{
            Color.gray.opacity(0.06)
                .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            closeButtonView
        }
    }
    
    // MARK: - View Builder
    @ViewBuilder
    func CustomCheckboxes() -> some View {
        HStack(spacing: 10) {
            ForEach([TransactionType.income, TransactionType.expense], id: \.self) { type in
                ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black, lineWidth: 2)
                        .opacity(0.5)
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
                    .opacity(0.7)
                    .padding(.trailing, 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
    }
}

// MARK: - PreviewProvider
struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView(.init(PersistenceProvider.default.context,
                                 selectedCard: nil))
    }
}
