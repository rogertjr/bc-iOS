//
//  DashboardView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 24/05/22.
//

import SwiftUI

struct DashboardView: View {
    // MARK: - Properties
    @StateObject private var viewModel = DashboardViewModel()
    
    // MARK: - Subviews
    var welcomeHeaderView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Olá,")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Text("Rogério")
                .font(.title2.bold())
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    var profileButtonHeaderView: some View {
        NavigationLink {
            // TODO: - create destination view
            EmptyView()
        } label: {
            Image(systemName: "person.crop.circle.fill")
                .foregroundColor(.gray)
                .frame(width: 40, height: 40)
                .background(.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
    }
    
    var settingsButtonHeaderView: some View {
        NavigationLink {
            // TODO: - create destination view
            EmptyView()
        } label: {
            Image(systemName: "gearshape.fill")
                .foregroundColor(.gray)
                .overlay(content: {
                    Circle()
                        .stroke(.white, lineWidth: 2)
                        .padding(7)
                })
                .frame(width: 40, height: 40)
                .background(.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
    }
    
    // MARK: - Layout
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                HStack(spacing: 16) {
                    welcomeHeaderView
                    profileButtonHeaderView
                    settingsButtonHeaderView
                }
                CardCarouselView()
                TransactionsListView()
                    .padding(.top)
            }
            .padding()
        }
        .fullScreenCover(isPresented: $viewModel.goToNewTransaction) {
        } content: {
            NewTransactionView()
        }
        .overlay(alignment: .bottomTrailing) {
            addButton()
        }
    }
    
    // MARK: - View Builder
    @ViewBuilder
    func addButton() -> some View{
        Button {
            // TODO: - Create implementation
            viewModel.goToNewTransaction.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background{
                    Circle()
                        .fill(.gray)
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        }
        .padding()
    }
}

// MARK: - PreviewProvider
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
