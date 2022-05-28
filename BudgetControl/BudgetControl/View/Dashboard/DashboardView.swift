//
//  DashboardView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 24/05/22.
//

import SwiftUI

struct DashboardView: View {
    // MARK: - Env
    @Namespace var animation
    @Environment(\.managedObjectContext) var viewContext
    
    // MARK: - Properties
    @ObservedObject private var viewModel: DashboardViewModel
    
    // MARK: - Init
    init(_ viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }
        
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
                CardCarouselView(cards: viewModel.cards)
//                customSegmentedControl()
//                    .padding(.top)
                
                TransactionsListView(cards: viewModel.cards,
                                     shouldFilter: false,
                                     filterSelected: viewModel.filterTabSelected)
                    .padding(.top)
            }
            .padding()
        }
        .fullScreenCover(isPresented: $viewModel.goToNewTransaction) {
        } content: {
            NewTransactionView(.init(viewContext,
                                     selectedCard: viewModel.selectedCard))
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
    
    @ViewBuilder
    func customSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach([TransactionType.income, TransactionType.expense],id: \.rawValue) { tab in
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(viewModel.filterTabSelected == tab ? .white : .black)
                    .opacity(viewModel.filterTabSelected == tab ? 1 : 0.7)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(content: {
                        if viewModel.filterTabSelected == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.blue)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    })
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation{ viewModel.filterTabSelected = tab }
                    }
            }
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
        .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
    }
}

// MARK: - PreviewProvider
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(.init(PersistenceProvider.default.context))
    }
}
