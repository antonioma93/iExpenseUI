//
//  AddView.swift
//  iExpense
//
//  Created by Massa Antonio on 14/06/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @ObservedObject var expenses: Expenses
    
    @State private var isShowAlert = false
    @State private var messageForAlert = ""
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    print("Error")
                    self.isShowAlert = true
                }
            })
        }
        .alert(isPresented: $isShowAlert) { () -> Alert in
            Alert(title: Text("Entered amount is incorrect"),
                  message: Text("For 'Amount' field you need to enter a number \(messageForAlert)"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
