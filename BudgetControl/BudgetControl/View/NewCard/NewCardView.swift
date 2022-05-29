//
//  NewCardView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 29/05/22.
//

import SwiftUI

struct NewCardView: View {
    // MARK: - Env
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Properties
    @ObservedObject private var viewModel: NewCardViewModel
    
    // MARK: - Init
    init(_ viewModel: NewCardViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - SubViews
    var headerLabelView: some View {
        Text("Adicionar Cartão")
            .font(.title2)
            .fontWeight(.semibold)
            .opacity(0.5)
    }
    
    var titleFieldView: some View {
        Label {
            TextField("Descrição",text: $viewModel.cardTitle)
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
    
    var saveButtonView: some View {
        Button(action: {
            if viewModel.saveNewCard() {
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
                titleFieldView
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
}
