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
        Text("new_card_title".localized)
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    var titleFieldView: some View {
        Label {
            TextField("description".localized,
                      text: $viewModel.cardTitle)
                .padding(.leading, 10)
        } icon: {
            Image(systemName: "doc.text.fill")
                .font(.title3)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white)
        }
        .padding(.top, 25)
    }
    
    var colorSectionView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("select_card_color".localized)
                .font(.caption)
                .fontWeight(.semibold)

            HStack(spacing: 16) {
                ForEach(viewModel.cardColors, id: \.self) { color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: 25, height: 25)
                        .background{
                            if viewModel.cardColor == color {
                                Circle()
                                    .strokeBorder(.gray)
                                    .padding(-3)
                            }
                        }
                        .contentShape(Circle())
                        .onTapGesture {
                            viewModel.cardColor = color
                        }
                }
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
        .padding(.horizontal, 15)
        .padding(.bottom, 15)
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white)
        }
    }
    
    var saveButtonView: some View {
        Button(action: {
            viewModel.saveNewCard()
            dismiss()
        }) {
            Text("save".localized)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
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
    
    // MARK: - Layout
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                headerLabelView
                titleFieldView
                colorSectionView
            }
            .frame(maxHeight: .infinity,alignment: .center)
            
            saveButtonView
        }
        .padding()
        .background {
            Color.bcPurple.opacity(0.06)
                .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            closeButtonView
        }
    }
}

// MARK: - PreviewProvider
struct NewCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardView(.init(PersistenceProvider.default.context))
    }
}
