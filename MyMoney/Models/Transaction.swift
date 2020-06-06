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

extension Transaction {
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
            throw InstanciationError(collection: "transaction", className: "Transaction", causedBy: data)
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
            "currency": currency
        ]
    }
}

struct TransactionCategory: Hashable, Codable, Identifiable {
    let id: String
    let name: String
}

enum TransactionType {
    case expense
    case benefit
}
