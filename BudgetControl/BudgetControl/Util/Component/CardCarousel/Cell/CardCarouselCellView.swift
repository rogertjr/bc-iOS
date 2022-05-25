//
//  CardCarouselCellView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 25/05/22.
//

import SwiftUI

struct CardCarouselCellView: View {
    // MARK: - Properties
    let card: Card
    var isFilter: Bool = false

    // MARK: - Layout
    var body: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.gray)
            
            VStack(spacing: 16) {
                VStack(spacing: 16) {
                    Text("1 de mai. de 2022 - 25 de mai. de 2022")
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text("R$ 2.389,00")
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom,5)
                }
                .offset(y: -10)
                
                HStack(spacing: 16) {
                    Image(systemName: "arrow.down")
                        .font(.caption.bold())
                        .foregroundColor(.green)
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7),in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Entrada")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text("R$ 3.098,00")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Image(systemName: "arrow.up")
                        .font(.caption.bold())
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7),in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Saída")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text("R$ 709,00")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                }
                .padding(.horizontal)
                .padding(.trailing)
                .offset(y: 15)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(width: 340, height: 220)
        .padding(.top)
    }
}
