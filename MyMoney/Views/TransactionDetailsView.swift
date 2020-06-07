//
//  TransactionDetailsView.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/6/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct TransactionDetailsView: View {
    var transaction: Transaction

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Description").font(.headline)
                    Text(transaction.description)

                    Text("Amount").font(.headline)
                    Text(transaction.formattedAmount)

                    Text("Date").font(.headline)
                    Text(transaction.formattedDate)

                    Text("Account").font(.headline)
                    Text(transaction.account.name)
                }
            }
            .navigationBarTitle("Transaction details")
        }
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static let transaction = Transaction(
        id: "tr1",
        amount: -25.0,
        description: "Pizza",
        account: Account(id: "ac1", name: "Chase"),
        currency: .USD,
        createdAt: Date(timeIntervalSinceNow: 0))

    static var previews: some View {
        TransactionDetailsView(transaction: transaction)
    }
}
