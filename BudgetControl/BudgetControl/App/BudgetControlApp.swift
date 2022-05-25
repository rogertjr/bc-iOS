//
//  BudgetControlApp.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 24/05/22.
//

import SwiftUI

@main
struct BudgetControlApp: App {
    @StateObject private var wallet = WalletManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(wallet)
        }
    }
}
