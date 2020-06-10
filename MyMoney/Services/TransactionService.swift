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
    var db: Firestore
    private static var instance: TransactionService?

    static func getInstance() -> TransactionService {
        if Self.instance == nil {
            Self.instance = TransactionService()
        }

        return Self.instance!
    }

    private init() {
        self.db = Firestore.firestore()
    }
}
