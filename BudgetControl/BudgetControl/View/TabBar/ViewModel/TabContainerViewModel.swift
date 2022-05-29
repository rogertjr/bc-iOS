//
//  TabContainerViewModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 29/05/22.
//

import Foundation

class TabContainerViewModel: ObservableObject {
    // TODO: Add local persistence to selected tab
    @Published var selectedTab: TabItem.TabItemType = .dashboard
    
    let tabItems = [
        TabItem(imageName: "house.fill", title: "Dashboard", type: .dashboard),
        TabItem(imageName: "gearshape.fill", title: "Settings", type: .settings)
    ]
}
