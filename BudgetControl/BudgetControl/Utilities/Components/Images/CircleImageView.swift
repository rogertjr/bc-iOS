//
//  CircleImageView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 31/05/22.
//

import SwiftUI

struct CircleImageView: View {
    // MARK: - Properties
    let imageSystemName: String
    let foregroundColor: Color?
    
    // MARK: - Layout
    var body: some View {
        Image(systemName: imageSystemName)
            .font(.caption.bold())
            .foregroundColor(foregroundColor)
            .frame(width: 30, height: 30)
            .background(foregroundColor?.opacity(0.3) ?? .white,
                        in: Circle())
    }
}

// MARK: - PreviewProvider
struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(imageSystemName: "arrow.down",
                        foregroundColor: .green)
    }
}
