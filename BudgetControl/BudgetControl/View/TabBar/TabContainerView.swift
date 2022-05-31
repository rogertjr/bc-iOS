//
//  TabContainerView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 29/05/22.
//

import SwiftUI

struct TabContainerView: View {
    // MARK: - Env
    @Environment(\.managedObjectContext) var viewContext
    
    // MARK: - Properties
    @StateObject var sharedViewModel: MainViewModel = MainViewModel()
    @StateObject private var viewModel = TabContainerViewModel()
    
    // MARK: - Init
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // MARK: - Layout
    var body: some View {
        VStack(spacing: 0) {
            productPages
            customBottomTabBar
        }
        .background(
            Color.bcBackground
                .ignoresSafeArea())
        .overlay(
            ZStack {
                if sharedViewModel.showProfile {
//                    ProfileView()
//                        .environmentObject(sharedViewModel)
//                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

// MARK: - Subviews
private extension TabContainerView {
    var productPages: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(viewModel.tabItems, id: \.self) { item in
                tabView(for: item.type)
                    .tabItem {
                        Image(systemName: item.imageName)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .frame(maxWidth: .infinity)
                    }
                    .tag(item.type)
            }
        }
        .accentColor(Color.bcPurple)
    }
    
    var customBottomTabBar: some View {
        HStack(spacing: 0) {
            ForEach(viewModel.tabItems, id: \.self) { tab in
                Button {
                    viewModel.selectedTab = tab.type
                } label: {
                    Image(systemName: tab.imageName)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .background(
                            Color.bcPurple
                                .opacity(0.1)
                                .cornerRadius(5)
                                .blur(radius: 5)
                                .padding(-7)
                                .opacity(viewModel.selectedTab == tab.type ? 1 : 0)
                                .opacity(1)
                        )
                        .frame(maxWidth: .infinity)
                        .foregroundColor(viewModel.selectedTab == tab.type
                                            ? Color.bcPurple
                                            : Color.gray)
                }
            }
        }
        .padding([.horizontal,.top])
        .padding(.bottom, 10)
    }
}

// MARK: - ViewBuilder
extension TabContainerView {
    @ViewBuilder
    func tabView(for tabItemType: TabItem.TabItemType) -> some View {
        switch tabItemType {
        case .dashboard:
            DashboardView(.init(viewContext))
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(sharedViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .settings:
            Text("WIP - Settings View")
        }
    }
}

