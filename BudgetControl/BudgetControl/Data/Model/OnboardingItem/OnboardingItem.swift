//
//  OnboardingItem.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 06/06/22.
//

import Foundation

struct OnboardingItem: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let content: String
}

extension OnboardingItem: Equatable {}

extension OnboardingItem {
    static let onboardingFlow: [OnboardingItem] = [
        .init(emoji: "🤑",
              title: "Track your expenses",
              content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
        .init(emoji: "📈",
              title: "Organize your finances",
              content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
    ]
}
