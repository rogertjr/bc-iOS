//
//  OnboardingManager.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 06/06/22.
//

import Foundation

final class OnboardingManager: ObservableObject {
    // MARK: - Properties
    @Published private(set) var items: [OnboardingItem] = []
    
    // MARK: - Fetch
    func load() {
        items = OnboardingItem.onboardingFlow
    }
}
