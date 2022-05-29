//
//  BudgetControlApp.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 24/05/22.
//

import SwiftUI

@main
struct BudgetControlApp: App {
    private let context = PersistenceProvider.default.context
    
    var body: some Scene {
        WindowGroup {
            DashboardView(.init(context))
                .environment(\.managedObjectContext, context)
        }
    }
}
