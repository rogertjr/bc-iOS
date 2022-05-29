//
//  CardCarouselView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI

struct CardCarouselView: View {
    // MARK: - Properties
    var cards: [CardModel]
    
    // MARK: - Subviews
    var cardListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(cards.indices, id: \.self) { index in
                    CardCarouselCellView(.init(cards[index]))
                }
            }
        }
    }
    
    // MARK: - Layout
    var body: some View {
        if cards.count > 0 {
            cardListView
        } else {
            // TODO: - Create empty card
            EmptyView()
        }
    }
}
