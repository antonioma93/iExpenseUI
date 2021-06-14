//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Massa Antonio on 14/06/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
    
}
