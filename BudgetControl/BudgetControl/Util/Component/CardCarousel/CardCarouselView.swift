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
    
    // MARK: - Subviews
    var cardList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(wallet.cards.indices, id: \.self) { index in
                    CardCarouselCellView(card: wallet.cards[index])
                    // TODO: - Select card on apresentation
                        .onTapGesture {
                            wallet.cards.indices.forEach { index in
                                wallet.cards[index].isSelected = false
                            }
                            wallet.cards[index].isSelected.toggle()
                        }
                }
            }
        }
    }
    
    // MARK: - Layout
    var body: some View {
        if wallet.cards.count > 0 {
            cardList
        } else {
            // TODO: - Create empty card
            EmptyView()
        }
    }
}
