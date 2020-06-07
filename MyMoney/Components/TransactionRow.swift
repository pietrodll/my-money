//
//  TransactionRow.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/6/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: transaction.createdAt)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.description).font(.headline)
                Text(dateString).font(.subheadline)
            }

            Spacer()

            Text("\(String(transaction.amount)) \(transaction.currency.rawValue)").font(.headline)
        }
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static let transaction = Transaction(
        id: "tr1",
        amount: 25.0,
        description: "Pizza",
        account: Account(id: "ac1", name: "Chase"),
        currency: .USD,
        createdAt: Date(timeIntervalSinceNow: 0)
    )

    static var previews: some View {
        TransactionRow(transaction: transaction)
    }
}
