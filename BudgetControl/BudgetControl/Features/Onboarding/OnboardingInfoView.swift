//
//  OnboardingInfoView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 06/06/22.
//

import SwiftUI

struct OnboardingInfoView: View {
    // MARK: - Properties
    let item: OnboardingItem
    
    // MARK: - Layout
    var body: some View {
        VStack(spacing: 0) {
            Text(item.emoji)
                .font(.system(size: 150))
            
            Text(item.title)
                .font(.system(size: 35,
                              weight: .heavy,
                              design: .rounded))
                .padding(.bottom, 12)
            
            Text(item.content)
                .font(.system(size: 18,
                              weight: .light,
                              design: .rounded))
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
        .padding()
    }
}

// MARK: - Preview
struct OnboardingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingInfoView(item: OnboardingItem.onboardingFlow.first!)
            .previewLayout(.sizeThatFits)
            .background(Color.bcPurple)
    }
}
