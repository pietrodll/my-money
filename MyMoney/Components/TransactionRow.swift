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

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.description).font(.headline)
                Text(transaction.formattedDate).font(.subheadline)
            }

            Spacer()

            Text(transaction.formattedAmount).font(.headline)
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
