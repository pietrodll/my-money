//
//  UserService.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/23/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import Foundation
import Firebase

final class UserService: FirestoreService {
    typealias Item = MyMoneyUser

    static var collectionName = "users"
    var db: Firestore
    private static var instance: UserService?

    static func getInstance() -> UserService {
        if Self.instance == nil {
            Self.instance = UserService()
        }

        return Self.instance!
    }

    private init() {
        self.db = Firestore.firestore()
    }

    public func create(fromAuth: AuthDataResult, name: String, completion: @escaping (Result<String, Error>) -> Void) {
        let user = Item(id: fromAuth.user.uid, email: fromAuth.user.email!, displayName: name)
        self.create(newItem: user) { result in
            switch result {
                case let .success(value):
                    completion(.success(value))
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
}
