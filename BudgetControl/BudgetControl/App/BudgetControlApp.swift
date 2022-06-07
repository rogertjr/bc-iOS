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
    @StateObject private var session = SessionManager()
    
    // MARK: - Layout
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .environmentObject(session)
        }
    }
}
