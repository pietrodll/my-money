//
//  NewTransactionView.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/24/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import SwiftUI

struct NewTransactionView: View {
    private let service = TransactionService.getInstance()

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var transaction = Transaction()
    @State private var error: String?

    private func submit() {
        service.create(newItem: transaction) { result in
            switch result {
                case .success:
                    self.error = nil
                    self.presentationMode.wrappedValue.dismiss()
                case let .failure(error):
                    self.error = error.message
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TransactionEditor(transaction: $transaction)
                Button(action: self.submit) {
                    Text("Add transaction")
                }

                if self.error != nil {
                    Text("Error: \(self.error!)")
                }
            }
            .navigationBarTitle("New transaction")
        }
    }
}

struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView()
    }
}
