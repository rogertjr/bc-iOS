//
//  MainAppView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 06/06/22.
//

import SwiftUI

struct MainAppView: View {
    // MARK: - Properties
    @EnvironmentObject var session: SessionManager
    private let context = PersistenceManager.shared.context
    
    // MARK: - Layout
    var body: some View {
        ZStack {
            switch session.currentState {
            case .onboarding:
                OnboardingView(actionHandler: session.completeOnboarding)
                                .transition(.opacity)
            case .signup:
                RegisterView()
                    .transition(.asymmetric(insertion: .move(edge: .trailing),
                                            removal: .opacity))
            default:
                TabContainerView()
                    .environment(\.managedObjectContext, context)
                    .accentColor(.primary)
            }
        }
        .animation(.easeInOut, value: session.currentState)
        .onAppear(perform: session.configureCurrentState)
    }
}

// MARK: - Preview
struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
            .environmentObject(SessionManager())
    }
}
