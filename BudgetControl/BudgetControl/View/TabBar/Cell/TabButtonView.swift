//
//  TabButtonView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 29/05/22.
//

import SwiftUI

struct TabButtonView : View {
    // MARK: - Properties
    var image : String
    
    // MARK: - Layout
    var body: some View {
        
        Button(action: {}) {
            Image(systemName: image)
                .renderingMode(.template)
                .foregroundColor(Color.black.opacity(0.4))
                .padding()
        }
    }
}
