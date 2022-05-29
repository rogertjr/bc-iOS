//
//  TabItem.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 29/05/22.
//

import Foundation

struct TabItem: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case dashboard
        case settings
    }
}
