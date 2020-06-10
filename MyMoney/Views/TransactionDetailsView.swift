//
//  TransactionDetailsView.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/6/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct TransactionDetailsView: View {
    static var service = TransactionService.getInstance()

    @Binding var transaction: Transaction

    @State private var editMode: EditMode = .inactive
    @State private var draftTransaction: Transaction = Transaction()
    @State private var loading = false
    @State private var error: String?

    private var cancelButton: some View {
        Button("Cancel") {
            self.draftTransaction = self.transaction
            self.editMode = .inactive
        }
    }

    private func updateTransaction() {
        self.loading = true
        Self.service.update(updated: self.draftTransaction) { result in
            switch result {
                case .success:
                    self.loading = false
                    self.error = nil
                    self.transaction = self.draftTransaction
                case let .failure(error):
                    self.loading = false
                    self.error = error.message
            }
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if loading {
                    ActivityIndicator()
                } else if editMode == .inactive {
                    TransactionSummary(transaction: transaction)
                } else {
                    TransactionEditor(transaction: $draftTransaction)
                        .onAppear {
                            self.draftTransaction = self.transaction
                        }
                    .onDisappear(perform: updateTransaction)
                }
            }
            .navigationBarTitle("Transaction details")
            .navigationBarItems(trailing: EditButton())
            .environment(\.editMode, $editMode)
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
        TransactionDetailsView(transaction: Binding.constant(transaction))
    }
}
