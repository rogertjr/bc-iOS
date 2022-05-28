//
//  CardCarouselView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI

struct CardCarouselView: View {
    // MARK: - Properties
    @EnvironmentObject var wallet: WalletManager
    var cards: [CardModel]
    
    // MARK: - Subviews
    var cardListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(cards.indices, id: \.self) { index in
                    CardCarouselCellView(card: cards[index])
                    // TODO: - Select card on apresentation
//                        .onTapGesture {
//                            cards.indices.forEach { index in
//                                cards[index].isSelected = false
//                            }
//                            cards[index].isSelected.toggle()
//                        }
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
