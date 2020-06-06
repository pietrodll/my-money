//
//  TransactionListView.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/6/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct TransactionListView: View {
    var service = TransactionService.getInstance()

    @State private var transactions: [Transaction] = []
    @State private var error: String? = nil
    @State private var loading = false

    func fetchTransactions() {
        loading = true
        service.list { result in
            switch result {
                case .success(let data):
                    self.error = nil
                    self.transactions = data.sorted(by: { $0.createdAt > $1.createdAt })
                case .failure(let err):
                    self.error = err.message
            }
            self.loading = false
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if loading {
                    ActivityIndicator(isAnimating: $loading, style: .large)
                } else {
                    if error != nil {
                        Text("Error: \(error ?? "")")
                    } else {
                        List {
                            ForEach(transactions) { transaction in
                                TransactionRow(transaction: transaction)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Transactions")
        }
        .onAppear(perform: fetchTransactions)
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
