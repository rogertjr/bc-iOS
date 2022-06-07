//
//  SessionManager.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 06/06/22.
//

import Foundation

final class SessionManager: ObservableObject {
    
    enum UserDefaultKeys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
        static let hasCompletedSignUpFlow = "hasCompletedSignUpFlow"
    }
    
    enum CurrentState {
        case loggedIn
        case loggedOut
        case onboarding
        case signup
    }
    
    @Published private(set) var currentState: CurrentState?
    
    func signIn() {
        currentState = .loggedIn
    }
    
    func signOut() {
        currentState = .loggedOut
    }
    
    func register() {
        signIn()
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasCompletedSignUpFlow)
    }
    
    func completeOnboarding() {
        currentState = .signup
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasSeenOnboarding)
    }
    
    /**
     - User closes the app during the onboarding phase > Resume the app from the onboarding screens
     - User closes the app during the sign up phase > Resume the app from the sign up screens
     - User closes the app after viewing onboarding and sign up phase > Resume the app from the log in screen
     */
    func configureCurrentState() {
        let hasCompletedSignUpFlow = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasCompletedSignUpFlow)
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
        
        if hasCompletedSignUpFlow {
            currentState = .loggedOut
        } else {
            currentState = hasCompletedOnboarding ? .signup : .onboarding
        }
    }
}
