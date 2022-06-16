//
//  String+Ext.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 28/05/22.
//

import UIKit

protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension String {
    
    /// Adds currency symbol to string
    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale.current
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}
