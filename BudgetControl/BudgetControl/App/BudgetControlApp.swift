//
//  BudgetControlApp.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 24/05/22.
//

import SwiftUI

@main
struct BudgetControlApp: App {
    // MARK: - Properties
    private let context = PersistenceManager.shared.context
    
    // MARK: - Layout
    var body: some Scene {
        WindowGroup {
            TabContainerView()
                .environment(\.managedObjectContext, context)
                .accentColor(.primary)
        }
    }
}
