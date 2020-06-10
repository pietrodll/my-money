//
//  Transaction.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/5/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import Foundation
import Firebase

struct Transaction: Hashable, Identifiable {
    var id: String
    var amount: Float
    var description: String
    var account: Account
    var currency: Currency

    var createdAt: Date
}

enum TransactionType {
    case expense
    case benefit
}

protocol DisplayableTransaction {
    var formattedDate: String { get }
    var formattedAmount: String { get }
    var type: TransactionType { get }
}

extension Transaction: DisplayableTransaction {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self.createdAt)
    }

    var formattedAmount: String {
        String(format: "%.2f", amount) + " " + currency.symbol
    }

    var type: TransactionType {
        amount > 0 ? .benefit : .expense
    }
}

extension Transaction: FirestoreEntity {
    init(fromFirestore data: [String: Any], id: String) throws {
        guard
            let currency = Currency(rawValue: data["currency"] as? String ?? ""),
            let amount = data["amount"] as? Float,
            let description = data["description"] as? String,
            let createdAt = data["createdAt"] as? Timestamp,
            let account = data["account"] as? String
        else {
            throw InstanciationError(collection: "transactions", className: "Transaction", causedBy: data)
        }
        self.id = id
        self.currency = currency
        self.amount = amount
        self.description = description
        self.createdAt = createdAt.dateValue()
        self.account = Account(id: account)
    }

    func toFirestore() -> [String: Any] {
        return [
            "amount": amount,
            "description": description,
            "createdAt": createdAt,
            "account": account.id,
            "currency": currency.rawValue
        ]
    }
}

extension Transaction {
    init() {
        self.init(
            id: "id",
            amount: 0.0,
            description: "Expense",
            account: Account(id: "id"),
            currency: .EUR,
            createdAt: Date(timeIntervalSinceNow: 0)
        )
    }
}
