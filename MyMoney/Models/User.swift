//
//  User.swift
//  MyMoney
//
//  Created by Pietro Dellino on 6/6/20.
//  Copyright © 2020 Pietro Dellino. All rights reserved.
//

import Foundation
import Firebase

struct MyMoneyUser: Identifiable {
    var id: String
    var email: String
    var displayName: String
    var createdAt: Date
}

extension MyMoneyUser: FirestoreEntity {
    init(fromFirestore data: [String: Any], id: String) throws {
        guard
            let email = data["email"] as? String,
            let displayName = data["displayName"] as? String,
            let createdAt = data["createdAt"] as? Timestamp
        else {
            throw InstanciationError(collection: "users", className: "MyMoneyUser", causedBy: data)
        }

        self.id = id
        self.email = email
        self.displayName = displayName
        self.createdAt = createdAt.dateValue()
    }

    func toFirestore() -> [String: Any] {
        return [
            "email": email,
            "displayName": displayName,
            "createdAt": createdAt
        ]
    }
}

extension MyMoneyUser {
    init(id: String, email: String, displayName: String) {
        self.init(id: id, email: email, displayName: displayName, createdAt: Date())
    }
}
