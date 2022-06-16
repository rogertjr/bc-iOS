//
//  OnboardingView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 06/06/22.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Properties
    @StateObject private var manager = OnboardingManager()
    @State private var showButton = false
    let actionHandler: () -> Void
    
    // MARK: - Layout
    var body: some View {
        ZStack {
            Color.bcPurple
                .ignoresSafeArea()
            
            if !manager.items.isEmpty {
                TabView {
                    ForEach(manager.items) { item in
                        OnboardingInfoView(item: item)
                            .onAppear {
                                if item == manager.items.last {
                                    withAnimation(.spring().delay(0.25)) {
                                        showButton = true
                                    }
                                }
                            }
                            .overlay(alignment: .bottom) {
                                if showButton {
                                    Button("continue".localized) {
                                        actionHandler()
                                    }
                                    .font(.system(size: 20,
                                                  weight: .bold,
                                                  design: .rounded))
                                    .frame(width: 150,
                                           height: 50)
                                    .foregroundColor(Color.bcPurple)
                                    .background(.white,
                                                in: RoundedRectangle(cornerRadius: 10,
                                                                     style: .continuous))
                                    .offset(y: 50)
                                    .transition(.scale.combined(with: .opacity))
                                    
                                }
                            }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
        .onAppear(perform: manager.load)
    }
}

// MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView {}
    }
}
