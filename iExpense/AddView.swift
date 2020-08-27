//
//  AddView.swift
//  Project 7
//
//  Created by Makwan BK on 12/14/19.
//  Copyright © 2019 Makwan BK. All rights reserved.
//

import SwiftUI

extension String {
  var isDigits: Bool {
    guard !self.isEmpty else { return false }
    return !self.contains { Int(String($0)) == nil }
  }
}

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses : Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    static let types = ["Business", "Personal"]
    @State private var isShowingAlert = false
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                }
            
                Section {
                    Picker("Type", selection: $type) {
                        ForEach(Self.types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                }
                
            }
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("Oops"), message: Text("You typed a word, which is illegat. Please type a number."), dismissButton: .cancel())
                }
        .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()

                }
                if !self.amount.isDigits {
                    self.isShowingAlert = true
                }
            })


        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
