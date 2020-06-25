//
//  AccountService.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/9/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import Foundation
import Firebase

final class AccountService: UserFirestoreService {
    typealias Item = Account

    static var collectionName = "accounts"
    private static var instance: AccountService?

    var db: Firestore
    var userId: String?

    static func getInstance() -> AccountService {
        if instance == nil {
            instance = AccountService()
        }

        return instance!
    }

    private init() {
        self.db = Firestore.firestore()
    }
}
