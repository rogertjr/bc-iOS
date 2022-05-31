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
    @EnvironmentObject var sharedViewModel: MainViewModel
    
    // MARK: - Init
    init(_ viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Layout
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                HStack(spacing: 16) {
                    welcomeHeaderView
                    profileButtonHeaderView
                }
                
                if viewModel.cards.count > 0 {
                    CardCarouselView(cards: viewModel.cards)
                    customSegmentedControl()
                        .padding(.top)
                    
                    TransactionsListView(cards: viewModel.cards,
                                         shouldFilter: true,
                                         filterSelected: viewModel.filterTabSelected)
                        .padding([.top, .leading, .trailing])
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .top)
                        .background(
                            Color.gray.opacity(0.06)
                                .clipShape(RoundedRectangle(cornerRadius: 25,
                                                            style: .continuous))
                                .ignoresSafeArea()
                                .padding(.bottom)
                        )
                } else {
                    emptyDashboardView
                }
            }
            .padding()
        }
        .background(
            Color.bcBackground
                .ignoresSafeArea()
        )
        .fullScreenCover(isPresented: $viewModel.goToNewTransaction) {
        } content: {
            NewTransactionView(.init(viewContext,
                                     selectedCard: viewModel.selectedCard))
        }
        .fullScreenCover(isPresented: $viewModel.goToNewCard) {
        } content: {
            NewCardView(.init(viewContext))
        }
        .overlay(alignment: .bottomTrailing) {
            addButton()
        }
    }
}

// MARK: - Subviews
private extension DashboardView {
    var welcomeHeaderView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("hello_comma".localized)
                .font(.caption)
                .fontWeight(.semibold)
            
            Text("Rogério")
                .font(.title2.bold())
                .foregroundColor(Color.bcPurple)
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
    }
    
    var profileButtonHeaderView: some View {
        Image(systemName: "person.crop.circle.fill")
            .foregroundColor(Color.bcPurple)
            .frame(width: 40, height: 40)
            .background(Color.bcBackground,
                        in: RoundedRectangle(cornerRadius: 10,
                                             style: .continuous))
            .shadow(color: .black.opacity(0.1),
                    radius: 5, x: 5, y: 5)
            .onTapGesture {
                withAnimation {
                    sharedViewModel.showProfile = true
                }
            }
    }
    
    var emptyDashboardView: some View {
        Text("empty_dashboard".localized)
            .padding(.top)
    }
    
    // MARK: - View Builder
    @ViewBuilder
    func addButton() -> some View{
        Button {
            viewModel.cards.count > 0
                ? viewModel.goToNewTransaction.toggle()
                : viewModel.goToNewCard.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background {
                    Circle()
                        .fill(Color.bcPurple)
                }
                .shadow(color: .black.opacity(0.1),
                        radius: 5, x: 5, y: 5)
        }
        .padding()
    }
    
    @ViewBuilder
    func customSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach([TransactionType.income, TransactionType.expense],id: \.rawValue) { tab in
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(viewModel.filterTabSelected == tab ? .white : .gray)
                    .opacity(viewModel.filterTabSelected == tab ? 1 : 0.7)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(content: {
                        if viewModel.filterTabSelected == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.bcPurple)
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
            RoundedRectangle(cornerRadius: 10,
                             style: .continuous)
                .fill(Color.bcBackground)
        }
        .shadow(color: .black.opacity(0.1),
                radius: 5, x: 5, y: 5)
    }
}

// MARK: - PreviewProvider
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(.init(PersistenceProvider.default.context))
    }
}
