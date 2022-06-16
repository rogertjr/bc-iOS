//
//  Date+Ext.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 29/05/22.
//

import Foundation

extension Date {
    /// Ex: "1 de mai. de 2022 - 29 de mai. de 2022"
    func currentMonthDateString() -> String {
        return self.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
}
