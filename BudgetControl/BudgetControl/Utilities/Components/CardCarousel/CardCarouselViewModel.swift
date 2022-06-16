//
//  CardCarouselViewModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 29/05/22.
//

import Foundation

final class CardCarouselViewModel: ObservableObject {
    // MARK: - Properties
    @Published var card: CardModel
    @Published var currentMonth: Date = Date()
    
    // MARK: - Init
    init(_ card: CardModel) {
        self.card = card
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month], from: Date())
        
        guard let calendar = calendar.date(from: components) else { return }
        currentMonth = calendar
    }
}
