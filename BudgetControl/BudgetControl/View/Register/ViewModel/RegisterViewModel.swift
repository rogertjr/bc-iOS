//
//  RegisterViewModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 14/06/22.
//

import Foundation
import CoreData

final class RegisterViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var userName: String = ""
    @Published var hasError = false
    @Published var error: RegistrationError?
    
    var isAbleToContinue: Bool {
        !userName.isEmpty
    }
    
    // MARK: - Persitence
    func createWallet() {
        PersistenceManager.shared.createWallet(username: userName) { result in
            switch result {
            case .success:
                self.hasError = false
                print("✅ - Wallet successfully saved")
            case .failure(let error):
                self.hasError = true
                self.error = .emptyUsername
                print("⚠️ - \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Error Handler
extension RegisterViewModel {
    enum RegistrationError: LocalizedError {
        case emptyUsername
        
        var errorDescription: String? {
            switch self {
            case .emptyUsername:
                return "⚠️ Username is empty"
            }
        }
    }
}
