//
//  TransactionEditor.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/8/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct TransactionEditor: View {
    static var currencies = Currency.allCases.map { $0.rawValue }

    @State var currencyValue = currencies[0] {
        didSet {
            self.transaction.currency = Currency(rawValue: currencyValue) ?? Currency.allCases[0]
        }
    }

    @Binding var transaction: Transaction

    var body: some View {
        Form {
            TextField("Description", text: $transaction.description)
            TextField("Amount", value: $transaction.amount, formatter: NumberFormatter()).keyboardType(.decimalPad)
            Picker("Currency", selection: $currencyValue) {
                ForEach(TransactionEditor.currencies, id: \.self) {
                    Text($0)
                }
            }
        }
    }
}

struct TransactionEditor_Previews: PreviewProvider {
    static var previews: some View {
        TransactionEditor(transaction: Binding.constant(Transaction()))
    }
}
