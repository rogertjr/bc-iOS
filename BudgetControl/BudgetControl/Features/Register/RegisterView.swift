//
//  RegisterView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 14/06/22.
//

import SwiftUI

struct RegisterView: View {
    // MARK: - Env
    @EnvironmentObject var session: SessionManager
    
    // MARK: - Properties
    @ObservedObject private var viewModel = RegisterViewModel()
    @State private var dismiss = false
    
    // MARK: - Layout
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                headerLabelView
                userNameFieldView
            }
            .frame(maxHeight: .infinity,
                   alignment: .center)
            
            saveButtonView
        }
        .padding()
        .background {
            Color.gray.opacity(0.06)
                .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            closeButtonView
        }
        .animation(.easeInOut, value: dismiss)
        .alert(isPresented: $viewModel.hasError,
                       error: viewModel.error) { }
    }
}

// MARK: - SubViews
private extension RegisterView {
    var headerLabelView: some View {
        Text("register_title".localized)
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    var userNameFieldView: some View {
        Label {
            TextField("register_username".localized,
                      text: $viewModel.userName)
                .padding(.leading, 10)
        } icon: {
            Image(systemName: "person.fill")
                .font(.title3)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background{
            RoundedRectangle(cornerRadius: 12,
                             style: .continuous)
                .fill(.white)
        }
        .padding(.top, 25)
    }
    
    var saveButtonView: some View {
        Button(action: {
            viewModel.createWallet()
            if !viewModel.hasError {
                session.register()
            }
        }) {
            Text("save".localized)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .background{
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
            dismiss.toggle()
        } label: {
            Image(systemName: "chevron.left")
                .font(.title2)
                .foregroundColor(.bcPurple)
        }
        .padding()
    }
}

// MARK: - PreviewProvider
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(SessionManager())
    }
}

