//
//  TransactionSummary.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/8/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct TransactionSummary: View {
    var transaction: Transaction

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(transaction.description).font(.title).padding(.vertical)

                Text(transaction.formattedAmount).font(.title).padding(.bottom)

                HStack {
                    Image(systemName: "calendar")
                    Text(transaction.formattedDate)
                }

                Text("Account").font(.headline)
                Text(transaction.account.name)

                Spacer()
            }
        }
    }
}

struct TransactionSummary_Previews: PreviewProvider {
    static var previews: some View {
        TransactionSummary(transaction: Transaction())
    }
}
