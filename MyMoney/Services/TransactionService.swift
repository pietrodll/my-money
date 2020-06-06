//
//  TransactionService.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/6/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import Foundation
import Firebase

final class TransactionService: FirestoreService {
    typealias Item = Transaction

    static var collectionName = "transactions"
    static var db: Firestore? = nil
    private static var instance: TransactionService? = nil

    static func getInstance() -> TransactionService {
        if Self.instance == nil {
            Self.instance = TransactionService()
        }

        return Self.instance!
    }

    static func toModel(data: [String : Any], id: String) -> Transaction? {
        let transaction = try? Transaction(fromFirestore: data, id: id)
        return transaction
    }

    static func toDict(model: Transaction) -> [String : Any] {
        return model.toFirestore()
    }

    private init() {
        Self.db = Firestore.firestore()
    }

}
